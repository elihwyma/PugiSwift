//
//  main.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation
import PugiSwift

@SimpleType public struct ExampleIntType: NumericRestrictions {
    
    public static let maxExclusive = 5
    
    public static let minExclusive = 3
    
    public let rawValue: Int
    
}

@SimpleType struct ExampleDoubleType: FloatingRestrictions {
        
    static let maxExclusive = 5.0
    
    static let minInclusive = 3.0
    
    let rawValue: Double
    
}

@SimpleType struct ExampleStringType: StringRestrictions {
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, macCatalyst 16.0, *)
    nonisolated(unsafe) static let pattern = try! Regex("[0-9][A-Z][0-9][0-9]")
    
    let rawValue: String
    
}

@ComplexExtension struct ExampleExtendedType {
    
    @Attribute let helloWorld: Int
    
    let rawValue: ExampleStringType
    
}

@Node struct Record {
    let name: String
    let list: Int?
    let color: Colours
}

@Node struct Records {
    @Attribute let value: String?
    @Element(childrenCodingKey: "record") let records: [Record]?
}

@Node enum Colours: String {
    
    case red = "red"
    case green = "green"
    case blue = "blue"
}

let str =
"""
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<records value="Hello World">
    <record>
        <name>Paul Koch</name>
        <list>17</list>
        <color>red</color>
    </record>
    <record>
        <name>John Appleseed</name>
        <list>423</list>
        <color>green</color>
    </record>
    <record>
        <name>John Appleseed</name>
        <color>green</color>
    </record>
</records> 
"""

do {
    let records = try Records(from: str)
    print(records)
} catch {
    print("Error: \(error.localizedDescription)")
}

