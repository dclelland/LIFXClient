//
//  LIFXDecoder.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 20/02/19.
//

import Foundation

//public protocol LIFXDecodable: Encodable {
//
//    init(from decoder: LIFXDecoder) throws
//
//}

public class LIFXDecoder {
    
    fileprivate let data: Data
    
    fileprivate var cursor = 0
    
    public init(data: Data) {
        self.data = data
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
        fatalError("Keyed container is unavailable")
    }
    
    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        fatalError("Unkeyed container is unavailable")
    }
    
    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        fatalError("Single value container is unavailable")
    }
    
}
