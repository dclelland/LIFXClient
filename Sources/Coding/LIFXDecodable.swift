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
            throw LIFXDecoder.Error.decodingFailed(message: "Invalid raw value")
        }
        
        self = value
    }
    
}

extension UInt8: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        self = try container.read(UInt8.self)
    }
    
}

extension Int8: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        self = try container.read(Int8.self)
    }
    
}

extension UInt16: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        self = try container.read(UInt16.self)
    }
    
}

extension Int16: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        self = try container.read(Int16.self)
    }
    
}

extension UInt32: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        self = try container.read(UInt32.self)
    }
    
}

extension Int32: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        self = try container.read(Int32.self)
    }
    
}

extension UInt64: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        self = try container.read(UInt64.self)
    }
    
}

extension Int64: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        self = try container.read(Int64.self)
    }
    
}

extension Float32: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        self = try container.read(Float32.self)
    }
    
}

extension Float64: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        self = try container.read(Float64.self)
    }
    
}

extension Bool: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        switch try container.decode(UInt8.self) {
        case 0:
            self = false
        default:
            self = true
        }
    }
    
}

extension Date: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        self.init(timeIntervalSince1970: TimeInterval(try container.decode(Int64.self) / 1_000_000))
    }
    
}
