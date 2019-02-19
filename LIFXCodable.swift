//
//  LIFXCodable.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 19/02/19.
//

import Foundation

public typealias LIFXCodable = LIFXEncodable & LIFXDecodable

public class LIFXEncoder {
    
    enum Error: Swift.Error {
        
    }
    
    fileprivate var data: [UInt8] = []
    
    public func encode<T: LIFXEncodable>(_ value: T) throws -> Data {
        fatalError()
    }
    
}

public protocol LIFXEncodable {
    
    func encode(to encoder: LIFXEncoder) throws
    
}

public class LIFXDecoder {
    
    enum Error: Swift.Error {
        
    }
    
    public func decode<T: LIFXDecodable>(_ type: T.Type, from data: Data) throws -> T {
        fatalError()
    }
    
}

public protocol LIFXDecodable {
    
    init(from decoder: LIFXDecoder) throws
    
}
