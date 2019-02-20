//
//  LIFXEncoder.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 20/02/19.
//

import Foundation

public class LIFXEncoder {
    
    private var data: Data = Data()
    
}

extension LIFXEncoder {
    
    public enum Error: Swift.Error {
        
        case dataCorrupted(_ message: String)
        
    }
    
}

extension LIFXEncoder {
    
    public static func encode(_ value: LIFXEncodable) throws -> Data {
        let encoder = LIFXEncoder()
        try value.encode(to: encoder)
        return encoder.data
    }
    
}

extension LIFXEncoder {
    
    internal func write<T>(_ value: T) throws {
        var target = value
        withUnsafeBytes(of: &target) { pointer in
            data.append(contentsOf: pointer)
        }
    }
    
}

extension LIFXEncoder {
    
    internal func encode(_ value: Data) throws {
        data.append(value)
    }
    
    internal func encode(_ value: LIFXEncodable) throws {
        try value.encode(to: self)
    }
    
}

extension LIFXEncoder {
    
    internal func encodeData(_ data: Data, bytes: Int) throws {
        guard data.count == bytes else {
            throw Error.dataCorrupted("Invalid data count")
        }
        
        try encode(data)
    }
    
    internal func encodeEmpty(bytes: Int) throws {
        try encode(Data(count: bytes))
    }
    
    internal func encodeString(_ string: String, bytes: Int) throws {
        guard let data = string.data(using: .utf8) else {
            throw Error.dataCorrupted("Invalid string")
        }
        
        try encodeData(data, bytes: bytes)
    }
    
}

extension LIFXEncoder {
    
    public func container() -> Container {
        return Container(encoder: self)
    }
    
    public struct Container {
        
        internal var encoder: LIFXEncoder
        
        mutating func write<T>(_ value: T) throws {
            try encoder.write(value)
        }
        
        mutating func encode<T: LIFXEncodable>(_ value: T) throws {
            try encoder.encode(value)
        }
        
        mutating func encodeData(_ data: Data, bytes: Int) throws {
            try encoder.encodeData(data, bytes: bytes)
        }
        
        mutating func encodeEmpty(bytes: Int) throws {
            try encoder.encodeEmpty(bytes: bytes)
        }
        
        mutating func encodeString(_ string: String, bytes: Int) throws {
            try encoder.encodeString(string, bytes: bytes)
        }
        
    }
    
}
