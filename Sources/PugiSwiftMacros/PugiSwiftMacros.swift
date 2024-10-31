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

@main
struct PugiSwiftMacrosPlugin: CompilerPlugin {
    
    let providingMacros: [Macro.Type] = [
        AttributeMacro.self,
        ElementMacro.self,
        NodeMacro.self,
        RestrictionMacro.self
    ]
    
}
