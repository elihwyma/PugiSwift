//
//  DoubleRestrictions.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import Foundation

public protocol NumericRestrictions: RestrictionsProtocol {
    
    associatedtype T: Numeric
    
    static var maxExclusive: T { get }
    
    static var maxInclusive: T { get }
    
    static var minExclusive: T { get }
    
    static var minInclusive: T { get }
    
    static var totalDigits: Int { get }
    
    var rawValue: T { get }
    
}

extension NumericRestrictions {
    
    public static var maxExclusive: T {
        0
    }
    
    public static var maxInclusive: T {
        0
    }
    
    public static var minExclusive: T {
        0
    }
    
    public static var minInclusive: T {
        0
    }
    
    public static var totalDigits: Int {
        0
    }
    
}
