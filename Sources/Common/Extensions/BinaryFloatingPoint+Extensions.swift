//
//  BinaryFloatingPoint+Extensions.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 26/02/19.
//

import Foundation

extension BinaryFloatingPoint {
    
    internal init<T: FixedWidthInteger>(interpolating source: T) {
        self.init(Self(source).inverseInterpolate(min: Self(T.min), max: Self(T.max)))
    }
    
}

extension BinaryFloatingPoint {
    
    internal func interpolate(min: Self, max: Self) -> Self {
        return min + (self * (max - min))
    }
    
    internal func inverseInterpolate(min: Self, max: Self) -> Self {
        return (self - min) / (max - min)
    }
    
}
