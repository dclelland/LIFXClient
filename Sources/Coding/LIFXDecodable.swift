//
//  LIFXDecodable.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 20/02/19.
//

import Foundation

public protocol LIFXDecodable {

    init(from decoder: LIFXDecoder) throws
    
}

extension LIFXDecodable where Self: RawRepresentable, Self.RawValue: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        guard let value = Self(rawValue: try RawValue(from: decoder)) else {
            throw LIFXDecoder.Error.dataCorrupted("Invalid raw value while decoding RawRepresentable")
        }
        
        self = value
    }
    
}

extension Bool: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        fatalError()
    }
    
}

extension UInt8: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        fatalError()
    }
    
}

extension Int8: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        fatalError()
    }
    
}

extension UInt16: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        fatalError()
    }
    
}

extension Int16: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        fatalError()
    }
    
}

extension UInt32: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        fatalError()
    }
    
}

extension Int32: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        fatalError()
    }
    
}

extension UInt64: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        fatalError()
    }
    
}

extension Int64: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        fatalError()
    }
    
}

extension Float32: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        fatalError()
    }
    
}

extension Float64: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        fatalError()
    }
    
}

extension Date: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        fatalError()
    }
    
}
