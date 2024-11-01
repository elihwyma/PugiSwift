//
//  Restriction.swift
//  PugiSwift
//
//  Created by Amy on 01/11/2024.
//

import Foundation
import PugiSwift

@Node public struct Restriction {
    
    @Attribute public var base: BaseType
    
    @Element(childrenCodingKey: "xs:enumeration") public let enumeration: [BasicType]?
    
    @Element(codingKey: "xs:length") public let length: BasicType?
    
    @Element(codingKey: "xs:maxExclusive") public let maxExclusive: BasicType?
    
    @Element(codingKey: "xs:maxInclusive") public let maxInclusive: BasicType?
    
    @Element(codingKey: "xs:maxLength") public let maxLength: BasicType?
    
    @Element(codingKey: "xs:minExclusive") public let minExclusive: BasicType?
    
    @Element(codingKey: "xs:minInclusive") public let minInclusive: BasicType?
    
    @Element(codingKey: "xs:minLength") public let minLength: BasicType?
    
    @Element(codingKey: "xs:pattern") public let pattern: BasicType?
    
    @Element(codingKey: "xs:totalDigits") public let totalDigits: BasicType?
    
}
