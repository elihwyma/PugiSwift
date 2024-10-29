import Foundation
import pugixml

public struct XMLDocument: ~Copyable {
    
    private let document: pugi.xml_document
    
    internal init(document: consuming pugi.xml_document) {
        self.document = document
    }
    
    public init(data: Data) throws(XMLError) {
        var doc = pugi.xml_document()
        var err: pugi.xml_parse_result = .init()
        data.withUnsafeBytes { ptr in
            err = doc.load_buffer(ptr.baseAddress!,
                                  data.count)
        }
        if err.status != pugi.status_ok {
            throw .init(status: err.status)
        }
        self.document = doc
    }
    
    public init(url: URL) throws(XMLError) {
        guard url.scheme == "file" else {
            throw .fileNotFound
        }
        var doc = pugi.xml_document()
        let path = url.path
        let err = doc.load_file(path)
        if err.status != pugi.status_ok {
            throw .init(status: err.status)
        }
        self.document = doc
    }
    
    public init(string: String) throws(XMLError) {
        var doc = pugi.xml_document()
        let err = doc.load_string(string)
        if err.status != pugi.status_ok {
            throw .init(status: err.status)
        }
        self.document = doc
    }
    
    
    
}
