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
    
    internal func read(count: Int) throws -> Data {
        guard cursor + count <= data.count else {
            throw Error.endOfData
        }
        
        defer {
            cursor += count
        }
        
        return data[cursor..<(cursor + count)]
    }
    
    internal func read<T>(_ type: T.Type) throws -> T {
        let data = try read(count: MemoryLayout<T>.size)
        return data.withUnsafeBytes { pointer in
            return pointer.baseAddress!.assumingMemoryBound(to: T.self).pointee
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
    
    internal func decodeData(count: Int) throws -> Data {
        return try read(count: count)
    }
    
    internal func decodeEmpty(count: Int) throws {
        _ = try read(count: count)
    }
    
    internal func decodeString(count: Int) throws -> String {
        guard let string = String(bytes: try read(count: count), encoding: .utf8) else {
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
        
        mutating func decodeData(count: Int) throws -> Data {
            return try decoder.decodeData(count: count)
        }
        
        mutating func decodeEmpty(count: Int) throws {
            try decoder.decodeEmpty(count: count)
        }
        
        mutating func decodeString(count: Int) throws -> String {
            return try decoder.decodeString(count: count)
        }
        
    }
    
}
