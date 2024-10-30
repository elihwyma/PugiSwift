//
//  XMLModifiableProtocol.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation
import pugixml

public protocol XMLModifiableProtocol: Sendable {
    
    @discardableResult mutating func set(name: String) -> Bool
    
    @discardableResult mutating func set(value: String) -> Bool
    
}

internal protocol _XMLModifiableProtocol: XMLModifiableProtocol {
    
    var node: pugi.xml_node { get set }
    
}

extension _XMLModifiableProtocol {
    
    @discardableResult public mutating func set(name: String) -> Bool {
        node.set_name(name)
    }
    
    @discardableResult public mutating func set(value: String) -> Bool {
        node.set_value(value)
    }
    
}
