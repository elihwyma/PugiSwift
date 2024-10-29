//
//  XMLNode.swift
//  SwiftyXML
//
//  Created by Amy on 29/10/2024.
//

import Foundation
import pugixml

public struct XMLNode: Sendable {
    
    private let node: pugi.xml_node
    
    internal init(node: pugi.xml_node) {
        self.node = node
    }
    
    public var name: String {
        let ptr = node.name()!
        return String(cString: ptr)
    }
    
    public var value: String {
        let ptr = node.value()!
        return String(cString: ptr)
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
        let ptr = node.child(name)
        if ptr.empty() {
            return nil
        }
        return .init(node: ptr)
    }
    
    public func attribute(name: String) -> XMLAttribute? {
        let ptr = node.attribute(name)
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
    
    public struct Iterator: Sendable, IteratorProtocol {
        
        private var it: pugi.xml_node_iterator
        private let node: XMLNode
        
        public typealias Element = XMLNode
        
        internal init(node: XMLNode) {
            self.node = node
            self.it = node.internal_node_begin()
        }

        public mutating func next() -> XMLNode? {
            if it == node.internal_node_end() {
                return nil
            } else {
                defer {
                    it = it.successor()
                }
                return .init(node: it.pointee)
            }
        }
     
    }
    
    internal func internal_node_begin() -> pugi.xml_node_iterator {
        node.__beginUnsafe()
    }
    
    internal func internal_node_end() -> pugi.xml_node_iterator {
        node.__endUnsafe()
    }
    
    public func iterateNodes() -> XMLNode.Iterator {
        .init(node: self)
    }
    
    internal func internal_attributes_begin() -> pugi.xml_attribute_iterator {
        node.__attributes_beginUnsafe()
    }
    
    internal func internal_attributes_end() -> pugi.xml_attribute_iterator {
        node.__attributes_endUnsafe()
    }
    
    public func iterateAttributes() -> XMLAttribute.Iterator {
        .init(node: self)
    }
  
}
 
extension pugi.xml_node: Copyable {
    
}
