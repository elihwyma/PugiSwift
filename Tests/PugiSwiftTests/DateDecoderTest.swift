//
//  DateDecoderTest.swift
//  PugiSwift
//
//  Created by Amelia While on 23/11/2024.
//

import Foundation
import Testing
@testable import PugiSwift

@Suite struct DateDecoderTest {
    
    @Test func fullDate() throws {
        _ = try #require(FullDate.dateFormatter.date(from: "2002-09-24"))
    }
    
    @Test func dateWithTimeZone() throws {
        _ = try #require(DateWithTimeZone.dateFormatter.date(from: "2002-09-24Z"))
        _ = try #require(DateWithTimeZone.dateFormatter.date(from: "2002-09-24-06:00"))
    }
    
    @Test func dateWithTime() throws {
        _ = try #require(DateWithTime.dateFormatter.date(from: "2002-05-30T09:00:00Z"))
    }
    
    @Test func time() throws {
        _ = try #require(Time.dateFormatter.date(from: "09:00:00"))
    }
    
}
