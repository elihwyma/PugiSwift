import Foundation
import pugixml

public final actor XMLDocument {
    
    private var document = pugi.xml_document()
    
    internal let node: pugi.xml_node

    public init(data: Data) throws(XMLError) {
        var ptr: UnsafeRawBufferPointer!
        data.withUnsafeBytes { _ptr in
            ptr = _ptr
        }
        let err = document.load_buffer(ptr.baseAddress!,
                                       data.count)
        if err.status != pugi.status_ok {
            throw .init(status: err.status)
        }
        node = document.root()
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
        node = document.root()
    }
    
    public init(string: String) throws(XMLError) {
        let err = document.load_string(string)
        if err.status != pugi.status_ok {
            throw .init(status: err.status)
        }
        node = document.root()
    }
  
}

extension XMLDocument: @preconcurrency _XMLNodeProtocol {
    
}
