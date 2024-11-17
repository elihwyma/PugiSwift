//
//  MacroDefinitions.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation
 
@attached(peer)
public macro Attribute(codingKey: String? = nil) = #externalMacro(module: "PugiSwiftMacros",
                                          type: "AttributeMacro")
@attached(peer)
public macro Element(codingKey: String? = nil, childrenCodingKey: String? = nil) = #externalMacro(module: "PugiSwiftMacros",
                                        type: "ElementMacro")

@attached(extension, conformances: XMLDecodable, names: arbitrary)
public macro Node(codingKey: String? = nil) =
    #externalMacro(module: "PugiSwiftMacros",
                   type: "NodeMacro")

@attached(extension, conformances: XMLDecodable, names: arbitrary)
public macro SimpleType(codingKey: String? = nil) =
    #externalMacro(module: "PugiSwiftMacros",
                   type: "SimpleTypeMacro")

@attached(extension, conformances: XMLDecodable, names: arbitrary)
public macro ComplexExtension(codingKey: String? = nil) = #externalMacro(module: "PugiSwiftMacros", type: "ComplexExtensionMacro")

