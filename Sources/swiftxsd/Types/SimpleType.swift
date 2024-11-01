//
//  SimpleType.swift
//  PugiSwift
//
//  Created by Amy on 01/11/2024.
//

import Foundation
import PugiSwift

@Node public struct SimpleType {
    
    @Attribute public let name: String
    
    @Element(codingKey: "xs:annotation") public let annotation: Annotation?
    
    @Element(codingKey: "xs:restriction") public let restriction: Restriction
    
}
