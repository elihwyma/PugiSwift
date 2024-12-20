//
//  XMLDecoderError.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation

public enum XMLDecoderError: Error, LocalizedError, CustomStringConvertible {
    
    case failedToDecode(xmlError: XMLError)
    
    case invalidRootNode
    
    case keyNotFound(codingKey: String)
    
    case attributeNotFound(codingKey: String)
    
    case noValueFound
    
    case notImplemented
    
    case couldNotGetName
    
    case failedToParseURL(string: String)
    
    case invalidCase
    
    case restrictionError(error: RestrictionsError)
    
    case failedToParse(date: String)
    
    public var description: String {
        localizedDescription
    }
    
    public var localizedDescription: String {
        switch self {
        case .failedToDecode(xmlError: let xmlError):
            "Failed to decode: \(xmlError.description)"
        case .invalidRootNode:
            "Invalid Root Node"
        case .keyNotFound(codingKey: let codingKey):
            "Key not found \(codingKey)"
        case .attributeNotFound(codingKey: let codingKey):
            "Attribute not found \(codingKey)"
        case .noValueFound:
            "No Value Found"
        case .notImplemented:
            "Not Implemented"
        case .couldNotGetName:
            "Could not get name"
        case .failedToParseURL(string: let string):
            "Failed to parse into URL: \(string)"
        case .invalidCase:
            "Enum case not found"
        case .restrictionError(error: let error):
            "Error validating restrictions: \(error.errorDescription)"
        case .failedToParse(date: let date):
            "Failed to parse date: \(date)"
        }
    }
    
    public var localizedError: String? {
        localizedDescription
    }
    
    public var errorDescription: String? {
        localizedDescription
    }
    
}
