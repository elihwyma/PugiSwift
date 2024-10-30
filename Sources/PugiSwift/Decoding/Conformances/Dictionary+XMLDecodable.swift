//
//  Dictionary+XMLDecodable.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation

extension Dictionary: XMLDecodable where Key == String, Value: XMLDecodable {
    
    public init(from node: XMLNode) throws(XMLDecoderError) {
        var ret = [String: Value]()
        for node in node.iterateNodes() {
            guard let name = node.name else {
                throw .couldNotGetName
            }
            let val = try Value.init(from: node)
            ret[name] = val
        }
        self = ret
    }
    
}
