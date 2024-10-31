//
//  ListRestrictions.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import Foundation

public protocol ListRestrictions: RestrictionsProtocol {
    
    static var length: Int { get }
    
    static var minLength: Int { get }
    
}

extension ListRestrictions {
    
    public static var minLength: Int {
        0
    }
    
    public static var length: Int {
        0
    }
    
}

