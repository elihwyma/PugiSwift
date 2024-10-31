//
//  NumericProtocol.swift
//  PugiSwift
//
//  Created by Amy on 31/10/2024.
//

import Foundation

extension FixedWidthInteger where Self: Comparable & SignedNumeric {
    
    var double: Double {
        .init(self)
    }
    var abs: Self {
        Swift.abs(self)
    }
    
    public var size: Self {
        self == 0 ? 1 : Self(pow(10.0, log10(abs.double).rounded(.down)))
    }
    
}
