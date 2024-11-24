//
//  XMLNodeProtocol.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation
import pugixml

public protocol XMLNodeProtocol: Sendable {
    
    var name: String? { get }
    
    var value: String? { get }
    
    var empty: Bool { get }
    
    func first_attribute() -> XMLAttribute?
    
    func last_attribute() -> XMLAttribute?
    
    func parent() -> XMLNode?
    
    func first_child() -> XMLNode?
    
    func last_child() -> XMLNode?
    
    func next_sibling() -> XMLNode?
    
    func last_sibling() -> XMLNode?
    
    func child_value() -> String
    
    func child_value(name: String) -> String
    
    func child(name: String) -> XMLNode?
    
    func attribute(name: String) -> XMLAttribute?
    
    func next_sibling(name: String) -> XMLNode?
    
    func previous_sibling(name: String) -> XMLNode?
    
    func find_child_by_attribute(name: String, attr_name: String, attr_value: String) -> XMLNode?
    
    func find_child_by_attribute(attr_name: String, attr_value: String) -> XMLNode?
    
    func root() -> XMLNode?
    
    func text() -> XMLText?
    
}

internal protocol _XMLNodeProtocol: XMLNodeProtocol {
    
    var node: pugi.xml_node { get }
    
}

extension _XMLNodeProtocol {
    
    public func text() -> XMLText? {
        let ptr = node.text()
        if ptr.empty() {
            return nil
        }
        return .init(text: ptr)
    }
    
    public func root() -> XMLNode? {
        let ptr = node.root()
        if ptr.empty() {
            return nil
        }
        return .init(node: ptr)
    }
    
    public var name: String? {
        let ptr = node.local_name()!
        let str = String(cString: ptr)
        if str.isEmpty {
            return nil
        }
        return str
    }
    
    public var value: String? {
        let ptr = node.value()!
        let str = String(cString: ptr)
        if str.isEmpty {
            return nil
        }
        return str
    }
    
    public var empty: Bool {
        node.empty()
    }
    
    public func first_attribute() -> XMLAttribute? {
        let attr = node.first_attribute()
        if attr.empty() {
            return nil
        }
        return .init(attribute: attr)
    }
    
    public func last_attribute() -> XMLAttribute? {
        let attr = node.last_attribute()
        if attr.empty() {
            return nil
        }
        return .init(attribute: attr)
    }
    
    public func parent() -> XMLNode? {
        let node = node.parent()
        if node.empty() {
            return nil
        }
        return .init(node: node)
    }
    
    public func first_child() -> XMLNode? {
        let node = node.first_child()
        if node.empty() {
            return nil
        }
        return .init(node: node)
    }
    
    public func last_child() -> XMLNode? {
        let node = node.last_child()
        if node.empty() {
            return nil
        }
        return .init(node: node)
    }
    
    public func next_sibling() -> XMLNode? {
        let node = node.next_sibling()
        if node.empty() {
            return nil
        }
        return .init(node: node)
    }
    
    public func last_sibling() -> XMLNode? {
        let node = node.previous_sibling()
        if node.empty() {
            return nil
        }
        return .init(node: node)
    }
    
    public func child_value() -> String {
        let ptr = node.child_value()!
        return String(cString: ptr)
    }

    public func child_value(name: String) -> String {
        let ptr = node.child_value(name)!
        return String(cString: ptr)
    }
    
    public func child(name: String) -> XMLNode? {
        let ptr = node.child_by_local_name(name)
        if ptr.empty() {
            return nil
        }
        return .init(node: ptr)
    }
    
    public func attribute(name: String) -> XMLAttribute? {
        let ptr = node.attribute_by_local_name(name)
        if ptr.empty() {
            return nil
        }
        return .init(attribute: ptr)
    }
    
    public func next_sibling(name: String) -> XMLNode? {
        let ptr = node.next_sibling(name)
        if ptr.empty() {
            return nil
        }
        return .init(node: ptr)
    }
    
    public func previous_sibling(name: String) -> XMLNode? {
        let ptr = node.previous_sibling(name)
        if ptr.empty() {
            return nil
        }
        return .init(node: ptr)
    }
    
    public func find_child_by_attribute(name: String, attr_name: String, attr_value: String) -> XMLNode? {
        let ptr = node.find_child_by_attribute(name, attr_name, attr_value)
        if ptr.empty() {
            return nil
        }
        return .init(node: ptr)
    }
    
    public func find_child_by_attribute(attr_name: String, attr_value: String) -> XMLNode? {
        let ptr = node.find_child_by_attribute(attr_name, attr_value)
        if ptr.empty() {
            return nil
        }
        return .init(node: ptr)
    }

}
