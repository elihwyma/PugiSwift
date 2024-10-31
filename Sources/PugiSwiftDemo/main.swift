//
//  main.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation
import PugiSwift

@Node struct Records {
    @Attribute let value: String
    @Element(childrenCodingKey: "record") let records: [Record]
}

@Restriction struct ExampleSimpleType: NumericRestrictions {
    
    var rawValue: Int {
        5
    }
    
}

@Node struct Record {
    let name: String
    let list: Int
    let color: Colours
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
</records> 
"""

@Node enum Colours: String {
    
    case red = "red"
    case green = "green"
    case blue = "blue"
    
}

do {
    let records = try Records(from: str)
    print(records)
} catch {
    print("Error: \(error.localizedDescription)")
}

