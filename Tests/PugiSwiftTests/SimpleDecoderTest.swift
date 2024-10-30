import Testing
import Foundation
@testable import PugiSwift

@Node struct Records {
    @Attribute let value: String
    @Element(childrenCodingKey: "record") let records: [Record]
}

@Node struct Record {
    let name: String
    let list: Int
}

let str =
"""
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<records value="Hello World">
    <record>
        <name>Paul Koch</name>
        <list>17</list>
    </record>
    <record>
        <name>John Appleseed</name>
        <list>423</list>
    </record>
</records> 
"""

@Test func decodableCheck() throws {
    _ = try Records(from: str)
}
