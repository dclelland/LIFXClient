//
//  LIFXColor.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 21/02/19.
//

import AppKit

public typealias LIFXColor = NSColor

extension LIFXColor {
    
    public var red: CGFloat {
        var red: CGFloat = 0.0
        usingColorSpace(.sRGB)?.getRed(&red, green: nil, blue: nil, alpha: nil)
        return red
    }
    
    public var green: CGFloat {
        var green: CGFloat = 0.0
        usingColorSpace(.sRGB)?.getRed(nil, green: &green, blue: nil, alpha: nil)
        return green
    }
    
    public var blue: CGFloat {
        var blue: CGFloat = 0.0
        usingColorSpace(.sRGB)?.getRed(nil, green: nil, blue: &blue, alpha: nil)
        return blue
    }
    
}

extension LIFXColor {
    
    public var hue: CGFloat {
        var hue: CGFloat = 0.0
        usingColorSpace(.sRGB)?.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        return hue
    }
    
    public var saturation: CGFloat {
        var saturation: CGFloat = 0.0
        usingColorSpace(.sRGB)?.getHue(nil, saturation: &saturation, brightness: nil, alpha: nil)
        return saturation
    }
    
    public var brightness: CGFloat {
        var brightness: CGFloat = 0.0
        usingColorSpace(.sRGB)?.getHue(nil, saturation: nil, brightness: &brightness, alpha: nil)
        return brightness
    }
    
}
