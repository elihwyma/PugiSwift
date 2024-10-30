//
//  XMLText.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation
import pugixml

public struct XMLText: Sendable, AttributeProtocol {
    
    private let text: pugi.xml_text
    
    internal init(text: pugi.xml_text) {
        self.text = text
    }
    
    public var empty: Bool {
        text.empty()
    }
    
    public func as_string(def: String = "") -> String {
        let ptr = text.as_string(def)!
        return String(cString: ptr)
    }
    
    public func as_int(def: Int = 0) -> Int {
        Int(text.as_int(Int32(def)))
    }
    
    public func as_uint(def: UInt32 = 0) -> UInt32 {
        text.as_uint(def)
    }
    
    public func as_double(def: Double = 0) -> Double {
        text.as_double(def)
    }
    
    public func as_float(def: Float = 0) -> Float {
        text.as_float(def)
    }
    
    public func as_bool(def: Bool = false) -> Bool {
        text.as_bool(def)
    }
    
}
