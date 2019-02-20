//
//  LIFXDecoder.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 20/02/19.
//

import Foundation

public class LIFXDecoder {
    
    private let data: Data
    
    private var cursor = 0
    
    private init(data: Data) {
        self.data = data
    }
    
}

extension LIFXDecoder {
    
    public enum Error: Swift.Error {
        
        case dataCorrupted(_ message: String)
        
    }
    
}

extension LIFXDecoder {
    
    public static func decode<T: LIFXDecodable>(_ type: T.Type, data: Data) throws -> T {
        return try T(from: LIFXDecoder(data: data))
    }
    
}

extension LIFXDecoder {
    
    internal func decodeEmpty(bytes: Int) throws {
        fatalError("Implement me")
    }
    
    internal func decodeData(bytes: Int) throws -> Data {
        fatalError("Implement me")
    }
    
    internal func decodeString(bytes: Int) throws -> String {
        fatalError("Implement me")
    }
    
    internal func decode<T: LIFXDecodable>(_ type: T.Type) throws -> T {
        fatalError("Implement me")
    }
    
}

extension LIFXDecoder {
    
    public func container() -> Container {
        return Container(decoder: self)
    }
    
    public struct Container {
        
        internal var decoder: LIFXDecoder
        
        mutating func decodeEmpty(bytes: Int) throws {
            try decoder.decodeEmpty(bytes: bytes)
        }
        
        mutating func decodeData(bytes: Int) throws -> Data {
            return try decoder.decodeData(bytes: bytes)
        }
        
        mutating func decodeString(bytes: Int) throws -> String {
            return try decoder.decodeString(bytes: bytes)
        }
        
        mutating func decode<T: LIFXDecodable>(_ type: T.Type) throws -> T {
            return try decoder.decode(type)
        }
        
    }
    
}
