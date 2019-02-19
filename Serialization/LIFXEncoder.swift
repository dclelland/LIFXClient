//
//  LIFXEncoder.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 20/02/19.
//

import Foundation

//public protocol LIFXEncodable: Encodable {
//
//    func encode(to encoder: LIFXEncoder) throws
//
//}

public class LIFXEncoder {
    
    fileprivate var data: [UInt8] = []
    
    public init() {}
    
}

extension LIFXEncoder: Encoder {
    
    public var codingPath: [CodingKey] {
        return []
    }
    
    public var userInfo: [CodingUserInfoKey: Any] {
        return [:]
    }
    
    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        fatalError("Keyed container is unavailable")
    }
    
    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError("Unkeyed container is unavailable")
    }
    
    public func singleValueContainer() -> SingleValueEncodingContainer {
        fatalError("Single value container is unavailable")
    }
    
}
