import Foundation
import pugixml

public final class XMLDocument {
    
    private var document = pugi.xml_document()
   
    public init(data: Data) throws(XMLError) {
        var err: pugi.xml_parse_result = .init()
        data.withUnsafeBytes { ptr in
            err = document.load_buffer(ptr.baseAddress!,
                                  data.count)
        }
        if err.status != pugi.status_ok {
            throw .init(status: err.status)
        }
    }
    
    public init(url: URL) throws(XMLError) {
        guard url.scheme == "file" else {
            throw .fileNotFound
        }
        let path = url.path
        let err = document.load_file(path)
        if err.status != pugi.status_ok {
            throw .init(status: err.status)
        }
    }
    
    public init(string: String) throws(XMLError) {
        let err = document.load_string(string)
        if err.status != pugi.status_ok {
            throw .init(status: err.status)
        }
    }
  
}

