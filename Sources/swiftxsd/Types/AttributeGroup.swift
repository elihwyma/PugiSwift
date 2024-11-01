//
//  AttributeGroup.swift
//  PugiSwift
//
//  Created by Amy on 01/11/2024.
//

import Foundation
import PugiSwift

@Node public struct AttributeGroup {

    @Attribute public let name: String
    
    @Element(childrenCodingKey: "xs:attribute") public let attributes: [Attribute]?
    
    @Element(codingKey: "xs:annotation") public let annotation: Annotation?

}

