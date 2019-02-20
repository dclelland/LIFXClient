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

extension Bool: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        fatalError()
    }
    
}

extension UInt8: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        fatalError()
    }
    
}

extension Int8: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        fatalError()
    }
    
}

extension UInt16: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        fatalError()
    }
    
}

extension Int16: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        fatalError()
    }
    
}

extension UInt32: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        fatalError()
    }
    
}

extension Int32: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        fatalError()
    }
    
}

extension UInt64: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        fatalError()
    }
    
}

extension Int64: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        fatalError()
    }
    
}

extension Float32: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        fatalError()
    }
    
}

extension Float64: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        fatalError()
    }
    
}

extension Date: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        fatalError()
    }
    
}
