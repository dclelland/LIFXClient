//
//  LIFXCodable.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 19/02/19.
//

import Foundation

public typealias LIFXCodable = LIFXEncodable & LIFXDecodable

public class LIFXEncoder: Encoder {
    
    public enum Error: Swift.Error {
        
        case keyedContainerUnavailable
        case unkeyedContainerUnavailable
        case singleValueContainerUnavailable
        
    }
    
    public var codingPath: [CodingKey] = []
    
    public var userInfo: [CodingUserInfoKey: Any] = [:]
    
    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        throw Error.keyedContainerUnavailable
    }
    
    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        throw Error.unkeyedContainerUnavailable
    }
    
    public func singleValueContainer() -> SingleValueEncodingContainer {
        throw Error.singleValueContainerUnavailable
    }
    
}

extension LIFXEncoder {
    
    public func encode<T: LIFXEncodable>(_ value: T) throws -> Data {
        fatalError()
    }
    
    public struct Container {
        
        fileprivate var data: Data
        
        public init(data: Data = Data()) {
            self.data = data
        }
        
    }
    
}

extension LIFXEncoder {
    
    public func encode<T: LIFXEncodable>(_ value: T) throws {
        
    }
    
}

public protocol LIFXEncodable {
    
    func encode(to encoder: LIFXEncoder) throws
    
}

public class LIFXDecoder: Decoder {
    
    public enum Error: Swift.Error {
        
        case keyedContainerUnavailable
        case unkeyedContainerUnavailable
        case singleValueContainerUnavailable
        
    }
    
    public var codingPath: [CodingKey] = []
    
    public var userInfo: [CodingUserInfoKey: Any] = [:]
    
    public func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        throw Error.keyedContainerUnavailable
    }
    
    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        throw Error.unkeyedContainerUnavailable
    }
    
    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        throw Error.singleValueContainerUnavailable
    }
    
}

public protocol LIFXDecodable {
    
    init(from decoder: LIFXDecoder) throws
    
}
