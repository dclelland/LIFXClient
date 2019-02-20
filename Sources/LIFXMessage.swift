//
//  LIFXMessage.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 19/02/19.
//

import Foundation

public protocol LIFXMessage {
    
    static var messageType: UInt16 { get }
    
}

public struct Device {
    
    public enum Service: UInt8, LIFXDecodable {
        
        case udp = 1
        
    }
    
}

extension Device {

    public struct GetService: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 2
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct StateService: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 3
        
        public var service: Service
        
        public var port: UInt32
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            service = try container.decode(Service.self)
            port = try container.decode(UInt32.self)
        }
        
    }
    
}

extension Device {

    public struct GetHostInfo: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 12
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct StateHostInfo: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 13
        
        public var signal: Float32
        
        public var tx: UInt32
        
        public var rx: UInt32
        
        public var reserved: Int16
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            signal = try container.decode(Float32.self)
            tx = try container.decode(UInt32.self)
            rx = try container.decode(UInt32.self)
            reserved = try container.decode(Int16.self)
        }
        
    }
    
}

extension Device {

    public struct GetHostFirmware: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 14
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct StateHostFirmware: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 15
        
        public var build: Date
        
        public var reserved: UInt64
        
        public var version: UInt32
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            build = try container.decode(Date.self)
            reserved = try container.decode(UInt64.self)
            version = try container.decode(UInt32.self)
        }
        
    }
    
}

extension Device {

    public struct GetWifiInfo: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 16
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct StateWifiInfo: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 17
        
        public var signal: Float32
        
        public var tx: UInt32
        
        public var rx: UInt32
        
        public var reserved: Int16
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            signal = try container.decode(Float32.self)
            tx = try container.decode(UInt32.self)
            rx = try container.decode(UInt32.self)
            reserved = try container.decode(Int16.self)
        }
        
    }
    
}

extension Device {

    public struct GetWifiFirmware: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 18
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct StateWifiFirmware: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 19
        
        public var build: Date
        
        public var reserved: UInt64
        
        public var version: UInt32
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            build = try container.decode(Date.self)
            reserved = try container.decode(UInt64.self)
            version = try container.decode(UInt32.self)
        }
        
    }
    
}

extension Device {

    public struct GetPower: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 20
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct SetPower: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 21
        
        public var level: UInt16
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encode(level)
        }
        
    }

    public struct StatePower: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 22
        
        public var level: UInt16
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            level = try container.decode(UInt16.self)
        }
        
    }
    
}

extension Device {

    public struct GetLabel: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 23
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct SetLabel: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 24
        
        public var label: String
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encodeString(label, bytes: 32)
        }
        
    }

    public struct StateLabel: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 25
        
        public var label: String
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            label = try container.decodeString(bytes: 32)
        }
        
    }
    
}

extension Device {

    public struct GetVersion: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 32
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct StateVersion: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 33
        
        public var vendor: UInt32
        
        public var product: UInt32
        
        public var version: UInt32
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            vendor = try container.decode(UInt32.self)
            product = try container.decode(UInt32.self)
            version = try container.decode(UInt32.self)
        }
        
    }
    
}

extension Device {

    public struct GetInfo: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 34
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct StateInfo: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 35
        
        public var time: Date
        
        public var uptime: UInt64
        
        public var downtime: UInt64
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            time = try container.decode(Date.self)
            uptime = try container.decode(UInt64.self)
            downtime = try container.decode(UInt64.self)
        }
        
    }
    
}

extension Device {

    public struct Acknowledgement: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 45
        
        public init(from decoder: LIFXDecoder) throws { }
        
    }
    
}

extension Device {

    public struct GetLocation: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 48
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct SetLocation: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 49
        
        public var location: Data
        
        public var label: String
        
        public var updatedAt: Date
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encodeData(location, bytes: 16)
            try container.encodeString(label, bytes: 32)
            try container.encode(updatedAt)
        }
        
    }

    public struct StateLocation: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 50
        
        public var location: Data
        
        public var label: String
        
        public var updatedAt: Date
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            location = try container.decodeData(bytes: 16)
            label = try container.decodeString(bytes: 32)
            updatedAt = try container.decode(Date.self)
        }
        
    }
    
}

extension Device {

    public struct GetGroup: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 51
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct SetGroup: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 52
        
        public var group: Data
        
        public var label: String
        
        public var updatedAt: Date
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encodeData(group, bytes: 16)
            try container.encodeString(label, bytes: 32)
            try container.encode(updatedAt)
        }
        
    }

    public struct StateGroup: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 53
        
        public var group: Data
        
        public var label: String
        
        public var updatedAt: Date
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            group = try container.decodeData(bytes: 16)
            label = try container.decodeString(bytes: 32)
            updatedAt = try container.decode(Date.self)
        }
        
    }
    
}

extension Device {

    public struct EchoRequest: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 58
        
        public var payload: Data
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encodeData(payload, bytes: 64)
        }
        
    }

    public struct EchoResponse: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 59
        
        public var payload: Data
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            payload = try container.decodeData(bytes: 64)
        }
        
    }

}

public struct Light {
    
    public struct HSBK: LIFXCodable {
        
        public var hue: UInt16
        
        public var saturation: UInt16
        
        public var brightness: UInt16
        
        public var kelvin: UInt16
        
        public init(hue: UInt16, saturation: UInt16, brightness: UInt16, kelvin: UInt16) {
            self.hue = hue
            self.saturation = saturation
            self.brightness = brightness
            self.kelvin = kelvin
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
    
}

extension Light {

    public struct Get: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 101
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct SetColor: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 102
        
        public var reserved: UInt8
        
        public var color: HSBK
        
        public var duration: UInt32
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encode(reserved)
            try container.encode(color)
            try container.encode(duration)
        }
        
    }

    public struct SetWaveform: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 103
        
        public var reserved: UInt8
        
        public var transient: Bool
        
        public var color: HSBK
        
        public var period: UInt32
        
        public var cycles: Float32
        
        public var skewRatio: Int16
        
        public var waveform: Waveform
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encode(reserved)
            try container.encode(transient)
            try container.encode(color)
            try container.encode(period)
            try container.encode(cycles)
            try container.encode(skewRatio)
            try container.encode(waveform)
        }
        
    }

    public struct SetWaveformOptional: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 119
        
        public var reserved: UInt8
        
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
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encode(reserved)
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

    public struct State: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 107
        
        public var color: HSBK
        
        public var reserved1: Int16
        
        public var power: UInt16
        
        public var label: String
        
        public var reserved2: UInt64
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            color = try container.decode(HSBK.self)
            reserved1 = try container.decode(Int16.self)
            power = try container.decode(UInt16.self)
            label = try container.decodeString(bytes: 32)
            reserved2 = try container.decode(UInt64.self)
        }
        
    }
    
}

extension Light {

    public struct GetPower: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 116
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct SetPower: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 117
        
        public var level: UInt16
        
        public var duration: UInt32
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encode(level)
            try container.encode(duration)
        }
        
    }

    public struct StatePower: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 118
        
        public var level: UInt16
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            level = try container.decode(UInt16.self)
        }
        
    }
    
}

extension Light {

    public struct GetInfrared: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 120
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }

    public struct StateInfrared: LIFXMessage, LIFXDecodable {
        
        public static let messageType: UInt16 = 121
        
        public var brightness: UInt16
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            brightness = try container.decode(UInt16.self)
        }
        
    }

    public struct SetInfrared: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 122
        
        public var brightness: UInt16
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encode(brightness)
        }
        
    }

}
