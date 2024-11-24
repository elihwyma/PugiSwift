//
//  StringRestrictionsError.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import Foundation

public enum StringRestrictionsError: RestrictionsError {

    case pattern(actual: String, identifier: String)
    
    public var description: String {
        switch self {
        case .pattern(let actual, let identifier):
            return "Expected string to match pattern but got \(actual) for \(identifier)"
        }
    }
    
    public var errorDescription: String {
        description
    }
    
}

