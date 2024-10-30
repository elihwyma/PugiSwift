//
//  SignedInt+XMLDecodable.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation

extension Int: XMLDecodable {
    
    public init(from attribute: (any AttributeProtocol)?) throws(XMLDecoderError) {
        guard let attribute else {
            throw .noValueFound
        }
        self = Int(attribute.as_int(def: 0))
    }
    
}

extension Int16: XMLDecodable {
    
    public init(from attribute: (any AttributeProtocol)?) throws(XMLDecoderError) {
        guard let attribute else {
            throw .noValueFound
        }
        self = Int16(attribute.as_int(def: 0))
    }
    
}

extension Int32: XMLDecodable {
    
    public init(from attribute: (any AttributeProtocol)?) throws(XMLDecoderError) {
        guard let attribute else {
            throw .noValueFound
        }
        self = Int32(attribute.as_int(def: 0))
    }
    
}

extension Int64: XMLDecodable {
    
    public init(from attribute: (any AttributeProtocol)?) throws(XMLDecoderError) {
        guard let attribute else {
            throw .noValueFound
        }
        self = Int64(attribute.as_int(def: 0))
    }
    
}
