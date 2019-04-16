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
        
        case encodingFailed(message: String)
        case dataCountMismatch(received: Int, expected: Int)
        
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
    
    internal func encodeData(_ data: Data, count: Int) throws {
        guard data.count == count else {
            throw Error.dataCountMismatch(received: data.count, expected: count)
        }
        
        try encode(data)
    }
    
    internal func encodeEmpty(count: Int) throws {
        try encode(Data(count: count))
    }
    
    internal func encodeString(_ string: String, count: Int) throws {
        guard let data = string.padding(toLength: count, withPad: "\0", startingAt: 0).data(using: .utf8) else {
            throw Error.encodingFailed(message: "Invalid string")
        }
        
        try encodeData(data, count: count)
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
        
        mutating func encodeData(_ data: Data, count: Int) throws {
            try encoder.encodeData(data, count: count)
        }
        
        mutating func encodeEmpty(count: Int) throws {
            try encoder.encodeEmpty(count: count)
        }
        
        mutating func encodeString(_ string: String, count: Int) throws {
            try encoder.encodeString(string, count: count)
        }
        
    }
    
}
