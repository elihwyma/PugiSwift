//
//  RestrictionsError.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import Foundation

public protocol RestrictionsError: Error, LocalizedError, CustomStringConvertible {
    
    var errorDescription: String { get }
    
}
