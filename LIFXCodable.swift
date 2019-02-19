//
//  LIFXCodable.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 19/02/19.
//

import Foundation

public typealias LIFXCodable = LIFXEncodable & LIFXDecodable

public class LIFXEncoder {
    
    public func encode<T: LIFXEncodable>(_ value: T) throws -> Data {
        fatalError()
    }
    
}

extension LIFXEncoder {
    
    
    
}

public protocol LIFXEncodable {
    
    func encode(to encoder: LIFXEncoder) throws
    
}

public class LIFXDecoder {
    
    public func decode<T: LIFXDecodable>(_ type: T.Type, from data: Data) throws -> T {
        fatalError()
    }
    
}

public protocol LIFXDecodable {
    
    init(from decoder: LIFXDecoder) throws
    
}
