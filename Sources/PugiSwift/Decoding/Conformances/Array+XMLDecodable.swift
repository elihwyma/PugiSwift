//
//  Array+XMLDecodable.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation

extension Array: XMLDecodable where Element: XMLDecodable {
    
    public init(from node: XMLNode) throws(XMLDecoderError) {
        var ret = [Element]()
        for node in node.iterateNodes() {
            let ele = try Element.init(from: node)
            ret.append(ele)
        }
        self = ret
    }
    
}

extension ContiguousArray: XMLDecodable where Element: XMLDecodable {
    
    public init(from node: XMLNode) throws(XMLDecoderError) {
        var ret = ContiguousArray<Element>()
        for node in node.iterateNodes() {
            let ele = try Element.init(from: node)
            ret.append(ele)
        }
        self = ret
    }
    
}
