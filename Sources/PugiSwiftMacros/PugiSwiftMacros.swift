//
//  PugiSwiftMacros.swift
//  PugiSwift
//
//  Created by Amy on 29/10/2024.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

import MacroToolkit

import Foundation

public struct AttributeMacro: PeerMacro {
    
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        []
    }
    
}

public struct ElementMacro: PeerMacro {
    
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        []
    }
    
}

public struct NodeMacro: ExtensionMacro {
    
    private static func createFunction(with access: AccessModifier?, name: String, type: String) -> InitializerDeclSyntax {
        let functionParameter = FunctionParameter(label: "from",
                                                  name: name,
                                                  type: "\(raw: type)")
        let parameterList = FunctionParameterListSyntax([functionParameter._syntax])
        let throwsClause = ThrowsClauseSyntax(throwsSpecifier: .keyword(.throws), leftParen: .leftParenToken(), type: .init(IdentifierTypeSyntax(name: "XMLDecoderError")), rightParen: .rightParenToken())
        var function =
            InitializerDeclSyntax(
                signature: .init(parameterClause: FunctionParameterClauseSyntax(parameters: parameterList),
                effectSpecifiers: .init(throwsClause: throwsClause))
            )
        if let access {
            let keyword: Keyword = {
                switch access {
                case .private:
                        .private
                case .fileprivate:
                        .fileprivate
                case .internal:
                        .internal
                case .package:
                        .package
                case .public:
                        .public
                case .open:
                        .open
                }
            }()
            let declModifier = DeclModifierSyntax(name: .keyword(keyword))
            function.modifiers.append(declModifier)
        }
        return function
    }
    
    private static func createBlockItem(for property: Property) throws -> [CodeBlockItemSyntax] {
        let propertyName = property.identifier
        guard let type = property.type else {
            throw MacroError("Unknown type for \(propertyName)")
        }
        
        // TODO: Check that every requested type will eventually conform. This is more difficult than it sounds.
        
        let nodeHelperName = "_\(propertyName)"
        
        NSLog("[PugiSwift] < \(property.attributes.first?.attribute?._syntax.attributeName.trimmedDescription) >")
        
        let xmlAttribute = property.attributes.first(where: { $0.attribute?._syntax.attributeName.trimmedDescription == "Attribute" })
        let xmlProperty = property.attributes.first(where: { $0.attribute?._syntax.attributeName.trimmedDescription == "Element" })
        if xmlAttribute != nil && xmlProperty != nil {
            throw MacroError("Property cannot both be an attribute and an element")
        }
        
        NSLog("[PugiSwift] Attr: \(xmlAttribute), Element: \(xmlProperty)")
        var codingKey = propertyName
        var childrenCodingKey: String? = nil
        var attribute = false
        
        // Get the codingKey
        if let xmlProperty {
            let expressions = xmlProperty.attribute?.asMacroAttribute?.arguments ?? []
            if let _codingKey = expressions.first(where: { $0.label == "codingKey" }) {
                codingKey = _codingKey.expr.asStringLiteral!.value!
            }
            if let _childCodingKey = expressions.first(where: { $0.label == "childrenCodingKey" }) {
                childrenCodingKey = _childCodingKey.expr.asStringLiteral!.value!
            }
        }
        if let xmlAttribute {
            attribute = true
            NSLog("[PugiSwift] Set attribute to true")
            let expressions = xmlAttribute.attribute?.asMacroAttribute?.arguments ?? []
            if let _codingKey = expressions.first(where: { $0.label == "codingKey" }) {
                codingKey = _codingKey.expr.asStringLiteral!.value!
            }
        }
        
        var optional = false
        if case .optional = type {
            optional = true
        }
        
        if optional {
            if attribute {
                let code = CodeBlockItemSyntax(
                """
                if let \(raw: nodeHelperName) = node.attribute(name: "\(raw: codingKey)") {
                    self.\(raw: propertyName) = try? .init(from: \(raw: nodeHelperName))
                } else {
                    self.\(raw: propertyName) = nil
                }
                """
                )
                return [code]
            } else {
                if let childrenCodingKey {
                    guard case let .array(arrayType) = type else {
                        throw MacroError("\(propertyName) must be an array")
                    }
                    let elementType = arrayType._baseSyntax.element.description
                    let code = CodeBlockItemSyntax(
                    """
                    var _\(raw: nodeHelperName) = \(raw: type.description)()
                    for child in node.iterateNodes() {
                        if child.name != "\(raw: childrenCodingKey)" {
                            continue
                        }
                        guard let __\(raw: nodeHelperName) = try? \(raw: elementType.description).init(from: child) else {
                            continue
                        }
                        _\(raw: nodeHelperName).append(__\(raw: nodeHelperName))
                    }
                    self.\(raw: propertyName) = _\(raw: nodeHelperName)
                    """
                    )
                    return [code]
                } else {
                    let code = CodeBlockItemSyntax(
                    """
                    if let \(raw: nodeHelperName) = node.child(name: \(raw: codingKey) {
                        self.\(raw: propertyName) = try? .init(from: \(raw: nodeHelperName))
                    } else {
                        self.\(raw: propertyName) = nil
                    }
                    """
                    )
                    return [code]
                }
            }
        } else {
            if !attribute,
               let childrenCodingKey {
                guard case let .array(arrayType) = type else {
                    throw MacroError("\(propertyName) must be an array")
                }
                let elementType = arrayType._baseSyntax.element.description
                let code = CodeBlockItemSyntax(
                """
                var _\(raw: nodeHelperName) = \(raw: type.description)()
                for child in node.iterateNodes() {
                    if child.name != "\(raw: childrenCodingKey)" {
                        continue
                    }
                    let __\(raw: nodeHelperName) = try \(raw: elementType).init(from: child)
                    _\(raw: nodeHelperName).append(__\(raw: nodeHelperName))
                }
                self.\(raw: propertyName) = _\(raw: nodeHelperName)
                """
                )
                return [code]
            }
            let createHelper: CodeBlockItemSyntax
            if attribute {
                createHelper = CodeBlockItemSyntax("guard let \(raw: nodeHelperName) = node.attribute(name: \"\(raw: codingKey)\") else { throw .attributeNotFound(codingKey: \"\(raw: codingKey)\") }")
            } else {
                createHelper = CodeBlockItemSyntax("guard let \(raw: nodeHelperName) = node.child(name: \"\(raw: codingKey)\") else { throw .keyNotFound(codingKey: \"\(raw: codingKey)\") }")
            }
            let assign = CodeBlockItemSyntax("self.\(raw: propertyName) = try .init(from: \(raw: nodeHelperName))")
            
            return [createHelper, assign]
        }
    }
    
    public static func expansion(of node: SwiftSyntax.AttributeSyntax,
                                 attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
                                 providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
                                 conformingTo protocols: [SwiftSyntax.TypeSyntax],
                                 in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        // Validate its a struct we're working with
        guard let structDecl = Struct(declaration) else {
            throw MacroError("@Node can only be applied to structs")
        }
        // Get the access level of the struct
        let modifier = structDecl.accessLevel
        // Create the extension syntax
        var extensionDecl =
            try ExtensionDeclSyntax("extension \(raw: structDecl.identifier): XMLDecodable {}")
        var definedFunc = Self.createFunction(with: modifier, name: "node", type: "PugiSwift.XMLNode")
        let defineProps = try structDecl.properties.map { try Self.createBlockItem(for: $0) }.joined()
        definedFunc.body = CodeBlockSyntax(statements: CodeBlockItemListSyntax(defineProps))
        
        let memberBlockItemSyntax = MemberBlockItemSyntax(decl: definedFunc)
        extensionDecl.memberBlock.members.append(memberBlockItemSyntax)
        
        return [extensionDecl]
    }
    
}

@main
struct PugiSwiftMacrosPlugin: CompilerPlugin {
    
    let providingMacros: [Macro.Type] = [
        AttributeMacro.self,
        ElementMacro.self,
        NodeMacro.self
    ]
    
}