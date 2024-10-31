//
//  StringRestrictions.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import Foundation

public protocol StringRestrictions: RestrictionsProtocol {
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, macCatalyst 16.0, *)
    static var pattern: Regex<AnyRegexOutput> { get }
    
    static var length: Int { get }
    
    static var minLength: Int { get }
    
    static var maxLength: Int { get }
    
    var rawValue: String { get }
    
}

extension StringRestrictions {
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, macCatalyst 16.0, *)
    public static var pattern: Regex<AnyRegexOutput> {
        try! Regex("")
    }
    
    public static var minLength: Int {
        0
    }
    
    public static var maxLength: Int {
        0
    }
    
    public static var length: Int {
        0
    }
    
}
