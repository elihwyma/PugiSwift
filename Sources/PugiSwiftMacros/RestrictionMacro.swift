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
    
    private static func numericRestrictions(for struct: Struct) -> [SwiftSyntax.ExtensionDeclSyntax] {
        []
    }
    
    private static func floatingRestrictions(for struct: Struct) -> [SwiftSyntax.ExtensionDeclSyntax] {
        []
    }
    
    private static func stringRestrictions(for struct: Struct) -> [SwiftSyntax.ExtensionDeclSyntax] {
        []
    }
    
    private static func listRestrictions(for struct: Struct) -> [SwiftSyntax.ExtensionDeclSyntax] {
        []
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
        
        if inheritedTypes.contains(where: { $0.description == "NumericRestrictions" }) {
            return Self.numericRestrictions(for: structDecl)
        } else if inheritedTypes.contains(where: { $0.description == "FloatingRestrictions" }) {
            return Self.floatingRestrictions(for: structDecl)
        } else if inheritedTypes.contains(where: { $0.description == "StringRestrictions" }) {
            return Self.stringRestrictions(for: structDecl)
        } else if inheritedTypes.contains(where: { $0.description == "ListRestrictions" }) {
            return Self.listRestrictions(for: structDecl)
        } else {
            throw MacroError("\(structDecl.identifier) must conform to one of the following protocols: NumericRestriction, FloatingRestrictions, StringRestrictions, ListRestrictions")
        }
    }

}
