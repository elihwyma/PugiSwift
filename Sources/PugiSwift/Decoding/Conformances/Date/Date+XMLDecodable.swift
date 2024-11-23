//
//  Time.swift
//  PugiSwift
//
//  Created by Amelia While on 23/11/2024.
//

import Foundation

public struct XMLDate<T: DateType>: XMLDecodable {
            
    public let rawValue: Date
    
    public init(from attribute: (any AttributeProtocol)?) throws(XMLDecoderError) {
        guard let attribute else {
            throw .noValueFound
        }
        let str = attribute.as_string(def: "")
        guard let date = T.dateFormatter.date(from: str) else {
            throw .failedToParse(date: str)
        }
        self.rawValue = date
    }
    
}
