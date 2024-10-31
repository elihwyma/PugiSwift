//
//  ListRestrictionError.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import Foundation

public enum ListRestrictionError: RestrictionsError {
    
    case length
    
    case minLength
    
    case maxLength

    public var description: String {
        switch self {
        case .length:
            return "The length of the list is not valid."
        case .minLength:
            return "The minimum length of the list is not valid."
        case .maxLength:
            return "The maximum length of the list is not valid."
        }
    }
    
    public var errorDescription: String {
        description
    }
    
}

