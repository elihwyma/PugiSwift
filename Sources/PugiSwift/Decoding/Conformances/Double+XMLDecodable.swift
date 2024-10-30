//
//  Double+XMLDecodable.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation

extension Double: XMLDecodable {
    
    public init(from attribute: (any AttributeProtocol)?) throws(XMLDecoderError) {
        guard let attribute else {
            throw .noValueFound
        }
        self = attribute.as_double(def: 0.0)
    }
    
}
