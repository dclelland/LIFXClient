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
    
    public static func decode<T: LIFXDecodable>(_ type: T.Type, data: Data) throws -> T {
        return try T(from: LIFXDecoder(data: data))
    }
    
}

extension LIFXDecoder {
    
    internal func decodeNil() -> Bool {
        return true
    }
    
    internal func decode<T: Decodable>(_ type: T.Type) throws -> T {
        fatalError("Implement me")
    }
    
}

extension LIFXDecoder: Decoder {
    
    public var codingPath: [CodingKey] {
        return []
    }
    
    public var userInfo: [CodingUserInfoKey: Any] {
        return [:]
    }
    
    public func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
        return KeyedDecodingContainer(KeyedContainer<Key>(decoder: self))
    }
    
    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return UnkeyedContainer(decoder: self)
    }
    
    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        return SingleValueContainer(decoder: self)
    }
    
    private struct KeyedContainer<Key: CodingKey>: KeyedDecodingContainerProtocol {
        
        var decoder: LIFXDecoder
        
        var codingPath: [CodingKey] {
            return []
        }
        
        var allKeys: [Key] {
            return []
        }
        
        func contains(_ key: Key) -> Bool {
            return true
        }
        
        func decodeNil(forKey key: Key) throws -> Bool {
            return decoder.decodeNil()
        }
        
        func decode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
            return try decoder.decode(type)
        }
        
        func nestedContainer<NestedKey: CodingKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> {
            return try decoder.container(keyedBy: type)
        }
        
        func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
            return try decoder.unkeyedContainer()
        }
        
        func superDecoder() throws -> Decoder {
            return decoder
        }
        
        func superDecoder(forKey key: Key) throws -> Decoder {
            return decoder
        }
        
    }
    
    private struct UnkeyedContainer: UnkeyedDecodingContainer {
        
        var decoder: LIFXDecoder
        
        var codingPath: [CodingKey] {
            return []
        }
        
        var count: Int? {
            return nil
        }
        
        var isAtEnd: Bool {
            return false
        }
        
        var currentIndex: Int {
            return 0
        }
        
        mutating func decodeNil() throws -> Bool {
            return decoder.decodeNil()
        }
        
        mutating func decode<T: Decodable>(_ type: T.Type) throws -> T {
            return try decoder.decode(type)
        }
        
        mutating func nestedContainer<NestedKey: CodingKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> {
            return try decoder.container(keyedBy: type)
        }
        
        mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
            return try decoder.unkeyedContainer()
        }
        
        mutating func superDecoder() throws -> Decoder {
            return decoder
        }
        
    }
    
    private struct SingleValueContainer: SingleValueDecodingContainer {
        
        var decoder: LIFXDecoder
        
        var codingPath: [CodingKey] {
            return []
        }
        
        func decodeNil() -> Bool {
            return decoder.decodeNil()
        }
        
        func decode<T: Decodable>(_ type: T.Type) throws -> T {
            return try decoder.decode(type)
        }
        
    }
    
}
