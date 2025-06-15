//
//  XMLAttribute.swift
//  PugiSwift
//
//  Created by Amy on 29/10/2024.
//

import Foundation
@preconcurrency import pugixml

public struct XMLAttribute: Sendable, AttributeProtocol {
    
    private var attribute: pugi.xml_attribute
    
    internal init(attribute: pugi.xml_attribute) {
        self.attribute = attribute
    }
    
    public var name: String? {
        let ptr = attribute.local_name()!
        let str = String(cString: ptr)
        if str.isEmpty {
            return nil
        }
        return str
    }
    
    public var value: String? {
        let ptr = attribute.value()!
        let str = String(cString: ptr)
        if str.isEmpty {
            return nil
        }
        return str
    }
    
    public var empty: Bool {
        attribute.empty()
    }
    
    public func as_string(def: String = "") -> String {
        let ptr = attribute.as_string(def)!
        return String(cString: ptr)
    }
    
    public func as_int(def: Int = 0) -> Int {
        Int(attribute.as_int(Int32(def)))
    }
    
    public func as_uint(def: UInt32 = 0) -> UInt32 {
        attribute.as_uint(def)
    }
    
    public func as_double(def: Double = 0) -> Double {
        attribute.as_double(def)
    }
    
    public func as_float(def: Float = 0) -> Float {
        attribute.as_float(def)
    }
    
    public func as_bool(def: Bool = false) -> Bool {
        attribute.as_bool(def)
    }
    
    public func next() -> XMLAttribute? {
        let attr = attribute.next_attribute()
        if attr.empty() {
            return nil
        }
        return .init(attribute: attr)
    }
    
    public func previous() -> XMLAttribute? {
        let attr = attribute.previous_attribute()
        if attr.empty() {
            return nil
        }
        return .init(attribute: attr)
    }
    
    public struct Iterator: IteratorProtocol, Sequence {
        
        private var it: pugi.xml_attribute_iterator
        private let node: XMLNode
        
        public typealias Element = XMLAttribute
        
        internal init(node: XMLNode) {
            self.node = node
            self.it = node.internal_attributes_begin()
        }

        public mutating func next() -> XMLAttribute? {
            if it == node.internal_attributes_end() {
                return nil
            } else {
                defer {
                    it = it.successor()
                }
                return .init(attribute: it.pointee)
            }
        }
     
    }
    
    @discardableResult public mutating func set(name: String) -> Bool {
        attribute.set_name(name)
    }
    
    @discardableResult public mutating func set(value: String) -> Bool {
        attribute.set_value(value)
    }
    
}
