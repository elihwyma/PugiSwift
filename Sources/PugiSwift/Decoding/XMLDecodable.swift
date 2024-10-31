//
//  XMLDecodable.swift
//  PugiSwift
//
//  Created by Amy on 30/10/2024.
//

import Foundation

public protocol XMLDecodable: Sendable {
    
    init(from string: String) throws(XMLDecoderError)
    
    init(from data: Data) throws(XMLDecoderError)
    
    init(from node: XMLNode) throws(XMLDecoderError)
    
    init(from attribute: AttributeProtocol?) throws (XMLDecoderError)
    
}

public extension XMLDecodable {
    
    init(from string: String) throws(XMLDecoderError) {
        let doc: XMLDocument
        do {
            doc = try XMLDocument(string: string)
        } catch {
            throw .failedToDecode(xmlError: error)
        }
        guard let firstChild = doc.first_child() else {
            throw .invalidRootNode
        }
        try self.init(from: firstChild)
    }
    
    init(from data: Data) throws(XMLDecoderError) {
        let doc: XMLDocument
        do {
            doc = try XMLDocument(data: data)
        } catch {
            throw .failedToDecode(xmlError: error)
        }
        guard let firstChild = doc.first_child() else {
            throw .invalidRootNode
        }
        try self.init(from: firstChild)
    }
    
    init(from node: XMLNode) throws(XMLDecoderError) {
        try self.init(from: node.text())
    }
    
    init(from attribute: (any AttributeProtocol)?) throws(XMLDecoderError) {
        throw .notImplemented
    }
    
}
