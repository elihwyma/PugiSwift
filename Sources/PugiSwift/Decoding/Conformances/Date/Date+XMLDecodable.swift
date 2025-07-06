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
        for formatter in T.dateFormatters {
            if let date = formatter.date(from: str) {
                self.rawValue = date
                return
            }
        }
        throw .failedToParse(date: str)
    }
    
}
