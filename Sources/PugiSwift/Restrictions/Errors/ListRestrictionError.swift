//
//  ListRestrictionError.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import Foundation

public enum ListRestrictionError: RestrictionsError {
    
    case length(expected: Int, actual: Int, identifier: String)
    
    case minLength(expected: Int, actual: Int, identifier: String)
    
    case maxLength(expected: Int, actual: Int, identifier: String)

    public var description: String {
        switch self {
        case .length(expected: let expected, actual: let actual, identifier: let identifier):
            "Invalid Length for '\(identifier)', expected \(expected) but got \(actual)"
        case .minLength(expected: let expected, actual: let actual, identifier: let identifier):
            "Invalid Length for '\(identifier)', expected a minimum of \(expected) but got \(actual)"
        case .maxLength(expected: let expected, actual: let actual, identifier: let identifier):
            "Invalid Length for '\(identifier)', expected a maximum of \(expected) but got \(actual)"
        }
    }
    
    public var errorDescription: String {
        description
    }
    
}

