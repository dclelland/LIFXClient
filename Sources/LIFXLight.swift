//
//  LIFXLight.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 21/02/19.
//

import Foundation
import PromiseKit

public class LIFXLight: LIFXConnection { }

extension LIFXLight {
    
    public struct HSBK: LIFXCodable {
        
        public var hue: UInt16
        
        public var saturation: UInt16
        
        public var brightness: UInt16
        
        public var kelvin: UInt16
        
        public static let neutralKelvin: UInt16 = 3500
        
        public init(hue: UInt16, saturation: UInt16, brightness: UInt16, kelvin: UInt16) {
            self.hue = hue
            self.saturation = saturation
            self.brightness = brightness
            self.kelvin = kelvin
        }
        
        public init(color: UIColor, kelvin: UInt16 = HSBK.neutralKelvin) {
            self.init(
                hue: UInt16(color.hue * CGFloat(UInt16.max)),
                saturation: UInt16(color.saturation * CGFloat(UInt16.max)),
                brightness: UInt16(color.brightness * CGFloat(UInt16.max)),
                kelvin: kelvin
            )
        }
        
        public var color: UIColor {
            return UIColor(
                hue: CGFloat(hue) / CGFloat(UInt16.max),
                saturation: CGFloat(saturation) / CGFloat(UInt16.max),
                brightness: CGFloat(brightness) / CGFloat(UInt16.max),
                alpha: 1.0
            )
        }
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            hue = try container.decode(UInt16.self)
            saturation = try container.decode(UInt16.self)
            brightness = try container.decode(UInt16.self)
            kelvin = try container.decode(UInt16.self)
        }
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encode(hue)
            try container.encode(saturation)
            try container.encode(brightness)
            try container.encode(kelvin)
        }
        
    }
    
    public enum Waveform: UInt8, LIFXEncodable {
        
        case saw = 0
        
        case sine = 1
        
        case halfSine = 2
        
        case triangle = 3
        
        case pulse = 4
        
    }
    
    public struct Get: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 101
        
        public init() { }
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct SetColor: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 13
        
        public static let messageType: UInt16 = 102
        
        public var color: HSBK
        
        public var duration: UInt32
        
        public init(color: HSBK, duration: UInt32) {
            self.color = color
            self.duration = duration
        }
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encodeEmpty(bytes: 1)
            try container.encode(color)
            try container.encode(duration)
        }
        
    }
    
    public struct SetWaveform: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 21
        
        public static let messageType: UInt16 = 103
        
        public var transient: Bool
        
        public var color: HSBK
        
        public var period: UInt32
        
        public var cycles: Float32
        
        public var skewRatio: Int16
        
        public var waveform: Waveform
        
        public init(transient: Bool, color: HSBK, period: UInt32, cycles: Float32, skewRatio: Int16, waveform: Waveform) {
            self.transient = transient
            self.color = color
            self.period = period
            self.cycles = cycles
            self.skewRatio = skewRatio
            self.waveform = waveform
        }
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encodeEmpty(bytes: 1)
            try container.encode(transient)
            try container.encode(color)
            try container.encode(period)
            try container.encode(cycles)
            try container.encode(skewRatio)
            try container.encode(waveform)
        }
        
    }
    
    public struct SetWaveformOptional: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 25
        
        public static let messageType: UInt16 = 119
        
        public var transient: Bool
        
        public var color: HSBK
        
        public var period: UInt32
        
        public var cycles: Float32
        
        public var skewRatio: Int16
        
        public var waveform: Waveform
        
        public var setHue: Bool
        
        public var setSaturation: Bool
        
        public var setBrightness: Bool
        
        public var setKelvin: Bool
        
        public init(transient: Bool, color: HSBK, period: UInt32, cycles: Float32, skewRatio: Int16, waveform: Waveform, setHue: Bool, setSaturation: Bool, setBrightness: Bool, setKelvin: Bool) {
            self.transient = transient
            self.color = color
            self.period = period
            self.cycles = cycles
            self.skewRatio = skewRatio
            self.waveform = waveform
            self.setHue = setHue
            self.setSaturation = setSaturation
            self.setBrightness = setBrightness
            self.setKelvin = setKelvin
        }
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encodeEmpty(bytes: 1)
            try container.encode(transient)
            try container.encode(color)
            try container.encode(period)
            try container.encode(cycles)
            try container.encode(skewRatio)
            try container.encode(waveform)
            try container.encode(setHue)
            try container.encode(setSaturation)
            try container.encode(setBrightness)
            try container.encode(setKelvin)
        }
        
    }
    
    public struct State: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 52
        
        public static let messageType: UInt16 = 107
        
        public var color: HSBK
        
        public var power: UInt16
        
        public var label: String
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            color = try container.decode(HSBK.self)
            try container.decodeEmpty(bytes: 2)
            power = try container.decode(UInt16.self)
            label = try container.decodeString(bytes: 32)
            try container.decodeEmpty(bytes: 8)
        }
        
    }
    
    public func get() -> Promise<State> {
        return requestMessage(Get())
    }
    
    public func setColor(color: HSBK, duration: UInt32 = 0) -> Promise<State> {
        return requestMessage(SetColor(color: color, duration: duration))
    }
    
    public func setColor(color: UIColor, kelvin: UInt16 = HSBK.neutralKelvin, duration: UInt32 = 0) -> Promise<State> {
        return setColor(color: HSBK(color: color, kelvin: kelvin), duration: duration)
    }
    
    public func setWaveform(transient: Bool = false, color: HSBK, period: UInt32, cycles: Float32 = .infinity, skewRatio: Int16 = 0, waveform: Waveform) -> Promise<State> {
        return requestMessage(SetWaveform(transient: transient, color: color, period: period, cycles: cycles, skewRatio: skewRatio, waveform: waveform))
    }
    
    public func setWaveform(transient: Bool = false, color: UIColor, kelvin: UInt16 = HSBK.neutralKelvin, period: UInt32, cycles: Float32 = .infinity, skewRatio: Int16 = 0, waveform: Waveform) -> Promise<State> {
        return setWaveform(transient: transient, color: HSBK(color: color, kelvin: kelvin), period: period, cycles: cycles, skewRatio: skewRatio, waveform: waveform)
    }
    
    public func setWaveformOptional(transient: Bool = false, color: HSBK, period: UInt32, cycles: Float32 = .infinity, skewRatio: Int16 = 0, waveform: Waveform, setHue: Bool, setSaturation: Bool, setBrightness: Bool, setKelvin: Bool) -> Promise<State> {
        return requestMessage(SetWaveformOptional(transient: transient, color: color, period: period, cycles: cycles, skewRatio: skewRatio, waveform: waveform, setHue: setHue, setSaturation: setSaturation, setBrightness: setBrightness, setKelvin: setKelvin))
    }
    
    public func setWaveformOptional(transient: Bool = false, color: UIColor, kelvin: UInt16 = HSBK.neutralKelvin, period: UInt32, cycles: Float32 = .infinity, skewRatio: Int16 = 0, waveform: Waveform, setHue: Bool, setSaturation: Bool, setBrightness: Bool, setKelvin: Bool) -> Promise<State> {
        return setWaveformOptional(transient: transient, color: HSBK(color: color, kelvin: kelvin), period: period, cycles: cycles, skewRatio: skewRatio, waveform: waveform, setHue: setHue, setSaturation: setSaturation, setBrightness: setBrightness, setKelvin: setKelvin)
    }
    
}

extension LIFXLight {
    
    public struct GetPower: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 116
        
        public init() { }
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct SetPower: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 6
        
        public static let messageType: UInt16 = 117
        
        public var level: UInt16
        
        public var duration: UInt32
        
        public init(level: UInt16, duration: UInt32) {
            self.level = level
            self.duration = duration
        }
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encode(level)
            try container.encode(duration)
        }
        
    }
    
    public struct StatePower: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 2
        
        public static let messageType: UInt16 = 118
        
        public var level: UInt16
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            level = try container.decode(UInt16.self)
        }
        
    }
    
    public func getPower() -> Promise<StatePower> {
        return requestMessage(GetPower())
    }
    
    public func setPower(level: UInt16, duration: UInt32 = 0) -> Promise<StatePower> {
        return requestMessage(SetPower(level: level, duration: duration))
    }
    
}

extension LIFXLight {
    
    public struct GetInfrared: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 120
        
        public init() { }
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct SetInfrared: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 2
        
        public static let messageType: UInt16 = 122
        
        public var brightness: UInt16
        
        public init(brightness: UInt16) {
            self.brightness = brightness
        }
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encode(brightness)
        }
        
    }
    
    public struct StateInfrared: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 2
        
        public static let messageType: UInt16 = 121
        
        public var brightness: UInt16
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            brightness = try container.decode(UInt16.self)
        }
        
    }
    
    public func getInfrared() -> Promise<StateInfrared> {
        return requestMessage(GetInfrared())
    }
    
    public func setInfrared(brightness: UInt16) -> Promise<StateInfrared> {
        return requestMessage(SetInfrared(brightness: brightness))
    }
    
}
