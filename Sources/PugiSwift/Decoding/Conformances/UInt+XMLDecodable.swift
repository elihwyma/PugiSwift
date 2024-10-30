//
//  UInt+XMLDecodable.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation

extension UInt: XMLDecodable {
    
    public init(from attribute: (any AttributeProtocol)?) throws(XMLDecoderError) {
        guard let attribute else {
            throw .noValueFound
        }
        self = UInt(attribute.as_uint(def: 0))
    }
    
}

extension UInt16: XMLDecodable {
    
    public init(from attribute: (any AttributeProtocol)?) throws(XMLDecoderError) {
        guard let attribute else {
            throw .noValueFound
        }
        self = UInt16(attribute.as_uint(def: 0))
    }
    
}

extension UInt32: XMLDecodable {
    
    public init(from attribute: (any AttributeProtocol)?) throws(XMLDecoderError) {
        guard let attribute else {
            throw .noValueFound
        }
        self = UInt32(attribute.as_uint(def: 0))
    }
    
}

extension UInt64: XMLDecodable {
    
    public init(from attribute: (any AttributeProtocol)?) throws(XMLDecoderError) {
        guard let attribute else {
            throw .noValueFound
        }
        self = UInt64(attribute.as_uint(def: 0))
    }
    
}
