//
//  DoubleRestrictions.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import Foundation

public protocol NumericRestrictions: RestrictionsProtocol {
    
    static var maxExclusive: Int { get }
    
    static var maxInclusive: Int { get }
    
    static var minExclusive: Int { get }
    
    static var minInclusive: Int { get }
    
    static var totalDigits: Int { get }
    
}

extension NumericRestrictions {
    
    public static var maxExclusive: Int {
        0
    }
    
    public static var maxInclusive: Int {
        0
    }
    
    public static var minExclusive: Int {
        0
    }
    
    public static var minInclusive: Int {
        0
    }
    
    public static var totalDigits: Int {
        0
    }
    
}
