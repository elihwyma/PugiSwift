//
//  DateDecoding.swift
//  PugiSwift
//
//  Created by Amelia While on 23/11/2024.
//

import Foundation

public protocol DateType {
    
    static var dateFormatter: ISO8601DateFormatter { get }
    
}

public struct FullDate: _FullDate {}

public protocol _FullDate: DateType {
    
}

extension _FullDate {
    
    public static var dateFormatter: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withFullDate
        ]
        return formatter
    }
    
}

public struct DateWithTimeZone: _DateWithTimeZone {}

public protocol _DateWithTimeZone: DateType {
    
}

extension _DateWithTimeZone {
    
    public static var dateFormatter: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withFullDate,
            .withTimeZone
        ]
        return formatter
    }
    
}

public struct DateWithTime: _DateWithTime {}

public protocol _DateWithTime: DateType {

}

extension _DateWithTime {
    
    public static var dateFormatter: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withFullDate,
            .withFullTime
        ]
        return formatter
    }
    
}

public struct Time: _Time {}

public protocol _Time: DateType {
        
}

extension _Time {
    
    public static var dateFormatter: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withTime
        ]
        return formatter
    }
    
}

public struct FullDateWithTimeZone: _FullDateWithTimeZone {}

public protocol _FullDateWithTimeZone: DateType {
    
}

extension _FullDateWithTimeZone {
    
    public static var dateFormatter: ISO8601DateFormatter {
        ISO8601DateFormatter()
    }
    
}
