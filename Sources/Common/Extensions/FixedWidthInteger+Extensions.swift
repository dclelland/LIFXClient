//
//  FixedWidthInteger+Extensions.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 22/02/19.
//

import Foundation

extension FixedWidthInteger {
    
    public static func random() -> Self {
        return random(in: min...max)
    }
    
}

extension FixedWidthInteger {
    
    internal init<T: BinaryFloatingPoint>(interpolating source: T) {
        self.init(source.interpolate(min: T(Self.min), max: T(Self.max)))
    }
    
}
