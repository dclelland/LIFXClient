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
        
        case decodingFailed(message: String)
        case endOfData
        
    }
    
}

extension LIFXDecoder {
    
    internal func read(bytes: Int) throws -> Data {
        guard cursor + bytes <= data.count else {
            throw Error.endOfData
        }
        
        defer {
            cursor += bytes
        }
        
        return data[cursor..<(cursor + bytes)]
    }
    
    internal func read<T>(_ type: T.Type) throws -> T {
        let data = try read(bytes: MemoryLayout<T>.size)
        return data.withUnsafeBytes { pointer in
            return pointer.pointee
        }
    }
    
}

extension LIFXDecoder {
    
    public static func decode<T: LIFXDecodable>(_ type: T.Type, data: Data) throws -> T {
        return try T(from: LIFXDecoder(data: data))
    }
    
}

extension LIFXDecoder {

    internal func decode<T: LIFXDecodable>(_ type: T.Type) throws -> T {
        return try T(from: self)
    }

}

extension LIFXDecoder {
    
    internal func decodeData(bytes: Int) throws -> Data {
        return try read(bytes: bytes)
    }
    
    internal func decodeEmpty(bytes: Int) throws {
        _ = try read(bytes: bytes)
    }
    
    internal func decodeString(bytes: Int) throws -> String {
        guard let string = String(bytes: try read(bytes: bytes), encoding: .utf8) else {
            throw Error.decodingFailed(message: "Invalid string")
        }
        
        return String(string.prefix(while: { $0 != "\0" }))
    }
    
}

extension LIFXDecoder {
    
    public func container() -> Container {
        return Container(decoder: self)
    }
    
    public struct Container {
        
        internal var decoder: LIFXDecoder
        
        mutating func read<T>(_ value: T.Type) throws -> T {
            return try decoder.read(value)
        }
        
        mutating func decode<T: LIFXDecodable>(_ type: T.Type) throws -> T {
            return try decoder.decode(type)
        }
        
        mutating func decodeData(bytes: Int) throws -> Data {
            return try decoder.decodeData(bytes: bytes)
        }
        
        mutating func decodeEmpty(bytes: Int) throws {
            try decoder.decodeEmpty(bytes: bytes)
        }
        
        mutating func decodeString(bytes: Int) throws -> String {
            return try decoder.decodeString(bytes: bytes)
        }
        
    }
    
}
