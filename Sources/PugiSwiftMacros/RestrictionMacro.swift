//
//  RestrictionMacro.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import MacroToolkit

public struct RestrictionMacro: ExtensionMacro {
    
    internal static func createFunction(with access: AccessModifier?) -> FunctionDeclSyntax {
        let throwsClause = ThrowsClauseSyntax(throwsSpecifier: .keyword(.throws), leftParen: .leftParenToken(), type: .init(IdentifierTypeSyntax(name: "XMLDecoderError")), rightParen: .rightParenToken())
        var function =
            FunctionDeclSyntax(
                name: "validateRestrictions", signature: .init(parameterClause: FunctionParameterClauseSyntax(parameters: []),
                                           effectSpecifiers: .init(throwsClause: throwsClause)))
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
    
    private static func contains(variable: String, _ structDecl: Struct) -> Bool {
        structDecl.members.contains(where: { $0.asVariable?.identifiers.contains(where: { $0 == variable }) ?? false })
    }
    
    private static func genericNumeric(for structDecl: Struct) -> [CodeBlockItemSyntax] {
        var ret = [CodeBlockItemSyntax]()
        if Self.contains(variable: "maxExclusive", structDecl) {
            ret.append(
            """
            if rawValue > Self.maxExclusive {
                throw .restrictionError(error: NumericRestrictionsError.maxExclusive)
            }
            """
            )
        }
        if Self.contains(variable: "maxInclusive", structDecl) {
            ret.append(
            """
            if rawValue >= Self.maxInclusive {
                throw .restrictionError(error: NumericRestrictionsError.maxInclusive)
            }
            """
            )
        }
        if Self.contains(variable: "minExclusive", structDecl) {
            ret.append(
            """
            if rawValue < Self.minExclusive {
                throw .restrictionError(error: NumericRestrictionsError.minExclusive)
            }
            """
            )
        }
        if Self.contains(variable: "minInclusive", structDecl) {
            ret.append(
            """
            if rawValue <= Self.maxInclusive {
                throw .restrictionError(error: NumericRestrictionsError.minInclusive)
            }
            """
            )
        }
        if Self.contains(variable: "totalDigits", structDecl) {
            ret.append(
            """
            if rawValue.size != totalDigits {
                throw .restrictionError(error: NumericRestrictionsError.totalDigits)
            }
            """
            )
        }
        return ret
    }
    
    private static func numericRestrictions(for structDecl: Struct) throws -> [CodeBlockItemSyntax] {
        return genericNumeric(for: structDecl)
    }
    
    private static func floatingRestrictions(for structDecl: Struct) throws -> [CodeBlockItemSyntax] {
        return genericNumeric(for: structDecl)
    }
    
    private static func stringRestrictions(for structDecl: Struct) throws -> [CodeBlockItemSyntax] {
        return []
    }
    
    private static func listRestrictions(for structDecl: Struct) throws -> [CodeBlockItemSyntax] {
        return []
    }
    
    public static func expansion(of node: SwiftSyntax.AttributeSyntax,
                                 attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
                                 providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
                                 conformingTo protocols: [SwiftSyntax.TypeSyntax],
                                 in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        guard let structDecl = Struct(declaration) else {
            throw MacroError("@Restriction can only be allowed to a struct")
        }
        let inheritedTypes = structDecl.inheritedTypes
        
        var extensionDecl = try ExtensionDeclSyntax("extension \(raw: structDecl.identifier): XMLDecodable {}")
        
        var validateCode: [CodeBlockItemSyntax]
        if inheritedTypes.contains(where: { $0.description == "NumericRestrictions" }) {
            validateCode = try Self.numericRestrictions(for: structDecl)
        } else if inheritedTypes.contains(where: { $0.description == "FloatingRestrictions" }) {
            validateCode = try Self.floatingRestrictions(for: structDecl)
        } else if inheritedTypes.contains(where: { $0.description == "StringRestrictions" }) {
            validateCode = try Self.stringRestrictions(for: structDecl)
        } else if inheritedTypes.contains(where: { $0.description == "ListRestrictions" }) {
            validateCode = try Self.listRestrictions(for: structDecl)
        } else {
            throw MacroError("\(structDecl.identifier) must conform to one of the following protocols: NumericRestriction, FloatingRestrictions, StringRestrictions, ListRestrictions")
        }
        
        var genericInitFunction = NodeMacro.createFunction(with: structDecl.accessLevel, name: "node", type: "PugiSwift.XMLNode")
        let genericInitCode = CodeBlockItemSyntax(
        """
        self.rawValue = try .init(from: node)
        try self.validateRestrictions()
        """
        )
        genericInitFunction.body = CodeBlockSyntax(statements: CodeBlockItemListSyntax([genericInitCode]))
        let genericMemberBodySyntax = MemberBlockItemSyntax(decl: genericInitFunction)
        extensionDecl.memberBlock.members.append(genericMemberBodySyntax)
        
        var validateFunction = Self.createFunction(with: structDecl.accessLevel)
        validateFunction.body = CodeBlockSyntax(statements: CodeBlockItemListSyntax(validateCode))
        let genericValidateSyntax = MemberBlockItemSyntax(decl: validateFunction)
        extensionDecl.memberBlock.members.append(genericValidateSyntax)
        
        return [extensionDecl]
    }

}
