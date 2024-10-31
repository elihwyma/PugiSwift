//
//  NumericRestrictions.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import Foundation

public enum NumericRestrictionsError: RestrictionsError {
    
    case maxExclusive
    
    case maxInclusive
    
    case minExclusive
    
    case minInclusive
    
    case totalDigits
    
    public var description: String {
        ""
    }
    
    public var errorDescription: String {
        description
    }
    
    
}
