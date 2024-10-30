import Testing
import Foundation
@testable import PugiSwift

@Node struct Records {
        
}

@Node struct Record {
    let name: String
    let list: Int
}

@Test func debugging() throws {
    let str =
    """
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <records value="Hello World">
        <record>
            <name>Paul Koch</name>
            <list>17</list>
        </record>
    </records> 
    """
}
