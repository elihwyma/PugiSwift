//
//  XMLError.swift
//  SwiftyXML
//
//  Created by Amy on 29/10/2024.
//

import Foundation

public enum XMLError: Error, LocalizedError, CustomStringConvertible {
    
    case fileNotFound
    
    case ioError
    
    case outOfMemory
    
    case internalError
    
    case unrecognizedTag
    
    case badPi
    
    case badComment
    
    case badCData
    
    case badDocType
    
    case badPCData
    
    case badStartElement
    
    case badAttribute
    
    case badEndElement
    
    case endElementMismatch
    
    case appendInvalidRoot
    
    case noDocumentElement
    
    public var description: String {
        errorDescription!
    }
    
    public var errorDescription: String? {
        switch self {
        case .fileNotFound:
            "File was not found during load_file()"
        case .ioError:
            "Error reading from file/stream"
        case .outOfMemory:
            "Could not allocate memory"
        case .internalError:
            "Internal error occurred"
        case .unrecognizedTag:
            "Parser could not determine tag type"
        case .badPi:
            "Parsing error occurred while parsing document declaration/processing instruction"
        case .badComment:
            "Parsing error occurred while parsing comment"
        case .badCData:
            "Parsing error occurred while parsing CDATA section"
        case .badDocType:
            "Parsing error occurred while parsing document type declaration"
        case .badPCData:
            "Parsing error occurred while parsing PCDATA section"
        case .badStartElement:
            "Parsing error occurred while parsing start element tag"
        case .badAttribute:
            "Parsing error occurred while parsing element attribute"
        case .badEndElement:
            "Parsing error occurred while parsing end element tag"
        case .endElementMismatch:
            "There was a mismatch of start-end tags (closing tag had incorrect name, some tag was not closed or there was an excessive closing tag)"
        case .appendInvalidRoot:
            "Unable to append nodes since root type is not node_element or node_document"
        case .noDocumentElement:
            "Parsing resulted in a document without element nodes"
        }
    }
    
}

import pugixml

extension XMLError {
    
    internal init(status: pugi.xml_parse_status) {
        switch status {
        case pugi.status_file_not_found:
            self = .fileNotFound
        case pugi.status_io_error:
            self = .ioError
        case pugi.status_out_of_memory:
            self = .outOfMemory
        case pugi.status_internal_error:
            self = .internalError
        case pugi.status_unrecognized_tag:
            self = .unrecognizedTag
        case pugi.status_bad_pi:
            self = .badPi
        case pugi.status_bad_comment:
            self = .badComment
        case pugi.status_bad_cdata:
            self = .badCData
        case pugi.status_bad_doctype:
            self = .badDocType
        case pugi.status_bad_pcdata:
            self = .badPCData
        case pugi.status_bad_start_element:
            self = .badStartElement
        case pugi.status_bad_attribute:
            self = .badAttribute
        case pugi.status_bad_end_element:
            self = .badEndElement
        case pugi.status_end_element_mismatch:
            self = .endElementMismatch
        case pugi.status_append_invalid_root:
            self = .appendInvalidRoot
        case pugi.status_no_document_element:
            self = .noDocumentElement
        default:
            self = .internalError
        }
    }
    
}
