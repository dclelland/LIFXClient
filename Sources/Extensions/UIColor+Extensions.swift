//
//  UIColor+Extensions.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 21/02/19.
//

import Foundation

extension UIColor {
    
    public var red: CGFloat {
        var red: CGFloat = 0.0
        getRed(&red, green: nil, blue: nil, alpha: nil)
        return red
    }
    
    public var green: CGFloat {
        var green: CGFloat = 0.0
        getRed(nil, green: &green, blue: nil, alpha: nil)
        return green
    }
    
    public var blue: CGFloat {
        var blue: CGFloat = 0.0
        getRed(nil, green: nil, blue: &blue, alpha: nil)
        return blue
    }
    
}

extension UIColor {
    
    public var hue: CGFloat {
        var hue: CGFloat = 0.0
        getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        return hue
    }
    
    public var saturation: CGFloat {
        var saturation: CGFloat = 0.0
        getHue(nil, saturation: &saturation, brightness: nil, alpha: nil)
        return saturation
    }
    
    public var brightness: CGFloat {
        var brightness: CGFloat = 0.0
        getHue(nil, saturation: nil, brightness: &brightness, alpha: nil)
        return brightness
    }
    
}
