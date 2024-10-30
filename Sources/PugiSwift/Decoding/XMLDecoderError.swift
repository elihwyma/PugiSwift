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
    
    public var description: String {
        localizedDescription
    }
    
    public var localizedDescription: String {
        switch self {
        case .failedToDecode(xmlError: let xmlError):
            "Failed to decode"
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
        }
    }
    
    public var localizedError: String? {
        localizedDescription
    }
    
    public var errorDescription: String? {
        localizedDescription
    }
    
}