//
//  NodeMacro.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import MacroToolkit

public struct NodeMacro: ExtensionMacro {
    
    internal static func createFunction(with access: AccessModifier?, name: String, type: String) -> InitializerDeclSyntax {
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
    
    internal static func createBlockItem(for property: Property, attributesOnly: Bool = false) throws -> [CodeBlockItemSyntax] {
        let propertyName = property.identifier
        guard let type = property.type else {
            if attributesOnly {
                return []
            }
            throw MacroError("Unknown type for \(propertyName)")
        }
        
        // TODO: Check that every requested type will eventually conform. This is more difficult than it sounds.
        
        let nodeHelperName = "_\(propertyName)"
     
        let xmlAttribute = property.attributes.first(where: { $0.attribute?._syntax.attributeName.trimmedDescription == "Attribute" })
        let xmlProperty = property.attributes.first(where: { $0.attribute?._syntax.attributeName.trimmedDescription == "Element" })
        if xmlAttribute != nil && xmlProperty != nil {
            throw MacroError("Property cannot both be an attribute and an element")
        }
        if attributesOnly && xmlAttribute == nil {
            return []
        }

        var codingKey = propertyName
        var childrenCodingKey: String? = nil
        var defaultValue: String? = nil
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
            if let _defaultValue = expressions.first(where: { $0.label == "default" }) {
                defaultValue = _defaultValue.expr._syntax.description
            }
        }
        if let xmlAttribute {
            attribute = true
            let expressions = xmlAttribute.attribute?.asMacroAttribute?.arguments ?? []
            if let _codingKey = expressions.first(where: { $0.label == "codingKey" }) {
                codingKey = _codingKey.expr.asStringLiteral!.value!
            }
            if let _defaultValue = expressions.first(where: { $0.label == "default" }) {
                defaultValue = _defaultValue.expr._syntax.description
            }
        }
        
        var optional = false
        if case .optional = type {
            optional = true
        }
        
        var optionalReplacement = "nil"
        if let defaultValue {
            optionalReplacement = defaultValue
        }
        
        if optional {
            if attribute {
                #if DEBUG
                let code = CodeBlockItemSyntax(
                """
                if let \(raw: nodeHelperName) = node.attribute(name: "\(raw: codingKey)") {
                    do {
                        self.\(raw: propertyName) = try .init(from: \(raw: nodeHelperName))
                    } catch {
                        self.\(raw: propertyName) = \(raw: optionalReplacement)
                        print("[🐞] Parsing error in \(raw: propertyName): \\(error.localizedDescription)")
                    }
                } else {
                    self.\(raw: propertyName) = \(raw: optionalReplacement)
                }
                """
                )
                #else
                let code = CodeBlockItemSyntax(
                """
                if let \(raw: nodeHelperName) = node.attribute(name: "\(raw: codingKey)") {
                    self.\(raw: propertyName) = (try? .init(from: \(raw: nodeHelperName))) ?? \(raw: optionalReplacement)
                } else {
                    self.\(raw: propertyName) = \(raw: optionalReplacement)
                }
                """
                )
                #endif
                return [code]
            } else {
                if let childrenCodingKey {
                    guard case let .optional(optionalArrayType) = type else {
                        throw MacroError("\(propertyName) optional error??")
                    }
                    guard let wrappedArry = ArrayTypeSyntax(optionalArrayType._baseSyntax.wrappedType) else {
                        throw MacroError("\(propertyName) must be an array")
                    }
                    let elementType = wrappedArry.element.description
                    let code = CodeBlockItemSyntax(
                    """
                    var _\(raw: nodeHelperName) = [\(raw: elementType)]()
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
                    #if DEBUG
                    let code = CodeBlockItemSyntax(
                    """
                    if let \(raw: nodeHelperName) = node.child(name: "\(raw: codingKey)") {
                        do {
                            self.\(raw: propertyName) = try .init(from: \(raw: nodeHelperName))
                        } catch {
                            self.\(raw: propertyName) = \(raw: optionalReplacement)
                            print("[🐞] Parsing error in \(raw: propertyName): \\(error.localizedDescription)")
                        }
                    } else {
                        self.\(raw: propertyName) = \(raw: optionalReplacement)
                    }
                    """
                    )
                    #else
                    let code = CodeBlockItemSyntax(
                    """
                    if let \(raw: nodeHelperName) = node.child(name: "\(raw: codingKey)") {
                        self.\(raw: propertyName) = (try? .init(from: \(raw: nodeHelperName))) ?? \(raw: optionalReplacement)
                    } else {
                        self.\(raw: propertyName) = \(raw: optionalReplacement)
                    }
                    """
                    )
                    #endif
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
            
            if let defaultValue {
                if attribute {
                    let codeBlock = CodeBlockItemSyntax(
                        """
                        if let \(raw: nodeHelperName) = node.attribute(name: \"\(raw: codingKey)\")  {
                            self.\(raw: propertyName) = try .init(from: \(raw: nodeHelperName))
                        } else {
                            self.\(raw: propertyName) = \(raw: defaultValue)
                        }
                        """
                    )
                    return [codeBlock]
                } else {
                    let codeBlock = CodeBlockItemSyntax(
                        """
                        if let \(raw: nodeHelperName) = node.child(name: \"\(raw: codingKey)\") {
                            self.\(raw: propertyName) = try .init(from: \(raw: nodeHelperName))
                        } else {
                            self.\(raw: propertyName) = \(raw: defaultValue)
                        }
                        """
                    )
                    return [codeBlock]
                }
            } else {
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
    }
    
    private static func structExpansion(struct structDecl: Struct) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
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
    
    private static func enumExpansion(enum enumDecl: Enum) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        
        var extensionDecl = try ExtensionDeclSyntax("extension \(raw: enumDecl.identifier): XMLDecodable {}")
        guard let rawType = enumDecl.inheritedTypes.first?.normalizedDescription else {
            throw MacroError("Enum must have a raw type.")
        }
        var functionDeclAttr = Self.createFunction(with: enumDecl.accessLevel,
                                                   name: "attribute",
                                                   type: "(any AttributeProtocol)?")
        let syntaxAttribute = CodeBlockItemSyntax(
        """
        let rawValue = try \(raw: rawType).init(from: attribute)
        guard let enumType = \(raw: enumDecl.identifier).init(rawValue: rawValue) else {
            throw .invalidCase
        }
        self = enumType
        """
        )
        functionDeclAttr.body = CodeBlockSyntax(statements: CodeBlockItemListSyntax([syntaxAttribute]))
        let memberBlockItemSyntaxAttr = MemberBlockItemSyntax(decl: functionDeclAttr)
        extensionDecl.memberBlock.members.append(memberBlockItemSyntaxAttr)
         
        return [extensionDecl]
    }
    
    public static func expansion(of node: SwiftSyntax.AttributeSyntax,
                                 attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
                                 providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
                                 conformingTo protocols: [SwiftSyntax.TypeSyntax],
                                 in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        if let structDecl = Struct(declaration) {
            return try Self.structExpansion(struct: structDecl)
        } else if let enumDecl = Enum(declaration) {
            return try Self.enumExpansion(enum: enumDecl)
        }
        throw MacroError("@Node applied to invalid type")
    }
    
}
