//
//  NumericRestrictions.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import Foundation

public enum NumericRestrictionsError<T: Numeric>: RestrictionsError where T: Sendable {
    
    case maxExclusive(expected: T, actual: T, identifier: String)
    
    case maxInclusive(expected: T, actual: T, identifier: String)
    
    case minExclusive(expected: T, actual: T, identifier: String)
    
    case minInclusive(expected: T, actual: T, identifier: String)
    
    case totalDigits(expected: Int, actual: Int, identifier: String)
    
    public var description: String {
        switch self {
        case .maxExclusive(let expected, let actual, let identifier):
            return "Expected \(identifier) to be less than \(expected) but got \(actual)"
        case .maxInclusive(let expected, let actual, let identifier):
            return "Expected \(identifier) to be less than or equal to \(expected) but got \(actual)"
        case .minExclusive(let expected, let actual, let identifier):
            return "Expected \(identifier) to be greater than \(expected) but got \(actual)"
        case .minInclusive(let expected, let actual, let identifier):
            return "Expected \(identifier) to be greater than or equal to \(expected) but got \(actual)"
        case .totalDigits(let expected, let actual, let identifier):
            return "Expected \(identifier) to have \(expected) digits but got \(actual)"
        }
    }
    
    public var errorDescription: String {
        description
    }
    
}
