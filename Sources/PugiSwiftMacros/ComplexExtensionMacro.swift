//
//  ComplexExtensionMcaro.swift
//  PugiSwift
//
//  Created by Amy on 17/11/2024.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import MacroToolkit

public struct ComplexExtensionMacro: ExtensionMacro {
    
    public static func expansion(of node: SwiftSyntax.AttributeSyntax,
                                 attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
                                 providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
                                 conformingTo protocols: [SwiftSyntax.TypeSyntax],
                                 in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        guard let structDecl = Struct(declaration) else {
            throw MacroError("@SimpleType can only be allowed to a struct")
        }

        var extensionDecl = try ExtensionDeclSyntax("extension \(raw: structDecl.identifier): XMLDecodable {}")

        var genericInitFunction = NodeMacro.createFunction(with: structDecl.accessLevel, name: "node", type: "PugiSwift.XMLNode")
        let genericInitCode = CodeBlockItemSyntax(
        """
        self.rawValue = try .init(from: node)
        """
        )
        
        let defineProps = try structDecl.properties.map { try NodeMacro.createBlockItem(for: $0, attributesOnly: true) }.joined()
        
        genericInitFunction.body = CodeBlockSyntax(statements: CodeBlockItemListSyntax(defineProps + [genericInitCode]))
        let genericMemberBodySyntax = MemberBlockItemSyntax(decl: genericInitFunction)
        extensionDecl.memberBlock.members.append(genericMemberBodySyntax)
        
        return [extensionDecl]
    }
    
}
