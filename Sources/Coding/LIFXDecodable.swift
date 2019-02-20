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

extension UInt8: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        fatalError()
    }
    
}

extension Int8: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        fatalError()
    }
    
}

extension UInt16: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        fatalError()
    }
    
}

extension Int16: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        fatalError()
    }
    
}

extension UInt32: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        fatalError()
    }
    
}

extension Int32: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        fatalError()
    }
    
}

extension UInt64: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        fatalError()
    }
    
}

extension Int64: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        fatalError()
    }
    
}

extension Float32: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        fatalError()
    }
    
}

extension Float64: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        fatalError()
    }
    
}

extension Bool: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        switch try container.decode(UInt8.self) {
        case 0:
            self = false
        case 1:
            self = true
        default:
            throw LIFXDecoder.Error.dataCorrupted("Invalid bool value")
        }
    }
    
}

extension Date: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        self.init(timeIntervalSince1970: TimeInterval(try container.decode(Int64.self) / 1_000_000))
    }
    
}
