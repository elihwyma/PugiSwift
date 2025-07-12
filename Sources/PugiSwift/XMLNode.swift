//
//  XMLNode.swift
//  SwiftyXML
//
//  Created by Amy on 29/10/2024.
//

import Foundation
import pugixml

public struct XMLNode: Sendable {
    
    internal var node: pugi.xml_node
    
    internal init(node: pugi.xml_node) {
        self.node = node
    }
    
    public struct Iterator: IteratorProtocol, Sequence {
        
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
    
    public func attribute(name: String, caseSensitive: Bool = true) -> XMLAttribute? {
        if caseSensitive {
            let ptr = node.attribute_by_local_name(name)
            if ptr.empty() {
                return nil
            }
            return .init(attribute: ptr)
        } else {
            for attr in self.iterateAttributes() {
                if attr.name?.caseInsensitiveCompare(name) == .orderedSame {
                    if attr.empty {
                        return nil
                    }
                    return attr
                }
            }
            return nil
        }
    }
 
}

extension XMLNode: _XMLNodeProtocol {
    

}

extension XMLNode: _XMLModifiableProtocol {
    
    
}

extension pugi.xml_node: @unchecked Sendable {
    
}
