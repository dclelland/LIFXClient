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
    
    public static func encode(_ value: LIFXEncodable) throws -> Data {
        let encoder = LIFXEncoder()
        try value.encode(to: encoder)
        return encoder.data
    }
    
}

extension LIFXEncoder {
    
    internal func encodeNil() throws {
        
    }
    
    internal func encode(_ encodable: Encodable) throws {
        fatalError("Implement me")
    }
    
}

extension LIFXEncoder: Encoder {
    
    public var codingPath: [CodingKey] {
        return []
    }
    
    public var userInfo: [CodingUserInfoKey: Any] {
        return [:]
    }
    
    public func container<Key: CodingKey>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
        return KeyedEncodingContainer(KeyedContainer<Key>(encoder: self))
    }
    
    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        return UnkeyedContainer(encoder: self)
    }
    
    public func singleValueContainer() -> SingleValueEncodingContainer {
        return SingleValueContainer(encoder: self)
    }
    
    private struct KeyedContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
        
        var encoder: LIFXEncoder
        
        var codingPath: [CodingKey] {
            return []
        }
        
        mutating func encodeNil(forKey key: Key) throws {
            try encoder.encodeNil()
        }
        
        mutating func encode<T: Encodable>(_ value: T, forKey key: Key) throws {
            try encoder.encode(value)
        }
        
        mutating func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> {
            return encoder.container(keyedBy: keyType)
        }
        
        mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
            return encoder.unkeyedContainer()
        }
        
        mutating func superEncoder() -> Encoder {
            return encoder
        }
        
        mutating func superEncoder(forKey key: Key) -> Encoder {
            return encoder
        }
        
    }
    
    private struct UnkeyedContainer: UnkeyedEncodingContainer {
        
        var encoder: LIFXEncoder
        
        var codingPath: [CodingKey] {
            return []
        }
        
        var count: Int {
            return 0
        }
        
        mutating func encodeNil() throws {
            try encoder.encodeNil()
        }
        
        mutating func encode<T: Encodable>(_ value: T) throws {
            try encoder.encode(value)
        }
        
        mutating func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> {
            return encoder.container(keyedBy: keyType)
        }
        
        mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
            return encoder.unkeyedContainer()
        }
        
        mutating func superEncoder() -> Encoder {
            return encoder
        }
        
    }
    
    private struct SingleValueContainer: SingleValueEncodingContainer {
        
        var encoder: LIFXEncoder
        
        var codingPath: [CodingKey] {
            return []
        }
        
        mutating func encodeNil() throws {
            try encoder.encodeNil()
        }
        
        mutating func encode<T: Encodable>(_ value: T) throws {
            try encoder.encode(value)
        }
        
    }
    
}
