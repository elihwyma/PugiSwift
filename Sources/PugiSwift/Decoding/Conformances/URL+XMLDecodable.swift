//
//  URL+XMLDecodable.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation

extension URL: XMLDecodable {

    public init(from attribute: (any AttributeProtocol)?) throws(XMLDecoderError) {
        guard let attribute else {
            throw .noValueFound
        }
        let str = attribute.as_string(def: "")
        guard let url = URL(string: str) else {
            throw .failedToParseURL(string: str)
        }
        self = url
    }
    
}
