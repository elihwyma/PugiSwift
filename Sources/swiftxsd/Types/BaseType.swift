//
//  BaseTypes.swift
//  PugiSwift
//
//  Created by Amy on 01/11/2024.
//

import Foundation
import PugiSwift

@Node public enum BaseType: String {
    
    case string = "xs:string"
    
    case integer = "xs:integer"
    
    case unsignedInt = "xs:unsignedInt"
    
    case unsignedShort = "xs:unsignedShort"
    
    case short = "xs:short"
    
    case decimal = "xs:decimal"
    
    case boolean = "xs:boolean"
    
    case date = "xs:date"
    
    case time = "xs:time"
    
    case dateTime = "xs:dateTime"
    
    case anyURI = "xs:anyURI"
    
    public var rawType: XMLDecodable.Type {
        switch self {
        case .string:
            return String.self
        case .integer:
            return Int.self
        case .unsignedInt:
            return UInt32.self
        case .unsignedShort:
            return UInt16.self
        case .short:
            return Int16.self
        case .decimal:
            return Double.self
        case .boolean:
            return Bool.self
        case .date:
            return String.self
        case .time:
            return String.self
        case .dateTime:
            return String.self
        case .anyURI:
            return URL.self
        }
    }
   
}
