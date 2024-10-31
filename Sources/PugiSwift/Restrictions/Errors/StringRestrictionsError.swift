//
//  StringRestrictionsError.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import Foundation

public enum StringRestrictionsError: RestrictionsError {

    case pattern
    
    public var description: String {
        switch self {
        case .pattern:
            return "The pattern of the string is not valid."
        }
    }
    
    public var errorDescription: String {
        description
    }
    
}

