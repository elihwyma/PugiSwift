//
//  Annotation.swift
//  PugiSwift
//
//  Created by Amy on 01/11/2024.
//
import Foundation
import PugiSwift

@Node public struct Annotation {
    
    @Element(codingKey: "xs:documentation") public let documentation: String?
    
}
