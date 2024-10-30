//
//  String+XMLDecodable.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation

extension String: XMLDecodable {

    public init(from attribute: (any AttributeProtocol)?) throws(XMLDecoderError) {
        guard let attribute else {
            throw .noValueFound
        }
        self = attribute.as_string(def: "")
    }
    
}
