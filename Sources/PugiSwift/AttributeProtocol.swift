//
//  AttributeProtocol.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation

public protocol AttributeProtocol {
    
    func as_string(def: String) -> String
    
    func as_int(def: Int) -> Int
    
    func as_uint(def: UInt32) -> UInt32
    
    func as_double(def: Double) -> Double
    
    func as_float(def: Float) -> Float
    
    func as_bool(def: Bool) -> Bool
    
}
