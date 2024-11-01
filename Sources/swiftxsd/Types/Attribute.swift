//
//  Attribute.swift
//  PugiSwift
//
//  Created by Amy on 01/11/2024.
//

import Foundation
import PugiSwift

@Node public struct Attribute {
    
    @Attribute public let name: String
    
    @Attribute public let type: String
    
    @Attribute public let use: String?
    
    @Element(codingKey: "xs:annotation") public let annotation: Annotation?
    
}

