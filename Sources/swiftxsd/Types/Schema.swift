//
//  Schema.swift
//  PugiSwift
//
//  Created by Amy on 01/11/2024.
//

import Foundation
import PugiSwift

@Node public struct Schema {
    
    @Element(childrenCodingKey: "xs:simpleType") public let simpleTypes: [SimpleType]
    
    @Element(childrenCodingKey: "xs:attributeGroup") public let attributeGroups: [AttributeGroup]
    
    
}
