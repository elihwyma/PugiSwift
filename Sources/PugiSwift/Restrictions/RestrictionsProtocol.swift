//
//  ResrictionsProtocol.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation

public protocol RestrictionsProtocol: Sendable {
    
    func validateRestrictions() throws(XMLDecoderError)
    
}

extension RestrictionsProtocol {
    
    public func validateRestrictions() throws(XMLDecoderError) {
        
    }
    
}
