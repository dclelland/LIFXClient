//
//  LIFXEncodable.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 20/02/19.
//

import Foundation

public protocol LIFXEncodable {
    
    func encode(to encoder: LIFXEncoder) throws

}

extension LIFXEncodable where Self: RawRepresentable, Self.RawValue: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        try rawValue.encode(to: encoder)
    }
    
}

extension UInt8: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        try container.write(littleEndian)
    }
    
}

extension Int8: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        try container.write(littleEndian)
    }
    
}

extension UInt16: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        try container.write(littleEndian)
    }
    
}

extension Int16: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        try container.write(littleEndian)
    }
    
}

extension UInt32: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        try container.write(littleEndian)
    }
    
}

extension Int32: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        try container.write(littleEndian)
    }
    
}

extension UInt64: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        try container.write(littleEndian)
    }
    
}

extension Int64: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        try container.write(littleEndian)
    }
    
}

extension Float32: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        try container.write(self)
    }
    
}

extension Float64: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        try container.write(self)
    }
    
}

extension Bool: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        switch self {
        case false:
            try container.encode(UInt8(0))
        case true:
            try container.encode(UInt8(1))
        }
    }
    
}

extension Date: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        try container.encode(Int64(timeIntervalSince1970 * 1_000_000))
    }
    
}
