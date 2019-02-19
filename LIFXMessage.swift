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
    
    public enum Service: UInt8 {
        
        case udp = 1
        
    }
    
    public typealias Port = UInt32
    
}

extension Device {

    public struct GetService: LIFXMessage, LIFXEncodable {
        
        public static let messageType: UInt16 = 2
        
        public func encode(to encoder: LIFXEncoder) throws {
            return
        }
        
    }

    public struct StateService: LIFXMessage {
        
        public static let messageType: UInt16 = 3
        
        public var service: Service
        
        public var port: Port
        
    }
    
}

extension Device {

    public struct GetHostInfo: LIFXMessage {
        
        public static let messageType: UInt16 = 12
        
    }

    public struct StateHostInfo: LIFXMessage {
        
        public static let messageType: UInt16 = 13
        
        public var signal: Float32
        
        public var tx: UInt32
        
        public var rx: UInt32
        
        public var reserved: Int16 = 0
        
    }
    
}

extension Device {

    public struct GetHostFirmware: LIFXMessage {
        
        public static let messageType: UInt16 = 14
        
    }

    public struct StateHostFirmware: LIFXMessage {
        
        public static let messageType: UInt16 = 15
        
        public var build: UInt64
        
        public var reserved: UInt64 = 0
        
        public var version: UInt32
        
    }
    
}

extension Device {

    public struct GetWifiInfo: LIFXMessage {
        
        public static let messageType: UInt16 = 16
        
    }

    public struct StateWifiInfo: LIFXMessage {
        
        public static let messageType: UInt16 = 17
        
        public var signal: Float32
        
        public var tx: UInt32
        
        public var rx: UInt32
        
        public var reserved: Int16 = 0
        
    }
    
}

extension Device {

    public struct GetWifiFirmware: LIFXMessage {
        
        public static let messageType: UInt16 = 18
        
    }

    public struct StateWifiFirmware: LIFXMessage {
        
        public static let messageType: UInt16 = 19
        
        public var build: UInt64
        
        public var reserved: UInt64 = 0
        
        public var version: UInt32
        
    }
    
}

extension Device {

    public struct GetPower: LIFXMessage {
        
        public static let messageType: UInt16 = 20
        
    }

    public struct SetPower: LIFXMessage {
        
        public static let messageType: UInt16 = 21
        
        public var level: UInt16
        
    }

    public struct StatePower: LIFXMessage {
        
        public static let messageType: UInt16 = 22
        
        public var level: UInt16
        
    }
    
}

extension Device {

    public struct GetLabel: LIFXMessage {
        
        public static let messageType: UInt16 = 23
        
    }

    public struct SetLabel: LIFXMessage {
        
        public static let messageType: UInt16 = 24
        
        public var label: String
        
    }

    public struct StateLabel: LIFXMessage {
        
        public static let messageType: UInt16 = 25
        
        public var label: String
        
    }
    
}

extension Device {

    public struct GetVersion: LIFXMessage {
        
        public static let messageType: UInt16 = 32
        
    }

    public struct StateVersion: LIFXMessage {
        
        public static let messageType: UInt16 = 33
        
        public var vendor: UInt32
        
        public var product: UInt32
        
        public var version: UInt32
        
    }
    
}

extension Device {

    public struct GetInfo: LIFXMessage {
        
        public static let messageType: UInt16 = 34
        
    }

    public struct StateInfo: LIFXMessage {
        
        public static let messageType: UInt16 = 35
        
        public var time: UInt64
        
        public var uptime: UInt64
        
        public var downtime: UInt64
        
    }
    
}

extension Device {

    public struct Acknowledgement: LIFXMessage {
        
        public static let messageType: UInt16 = 45
        
    }
    
}

extension Device {

    public struct GetLocation: LIFXMessage {
        
        public static let messageType: UInt16 = 48
        
    }

    public struct SetLocation: LIFXMessage {
        
        public static let messageType: UInt16 = 49
        
        public var location: [UInt8]
        
        public var label: String
        
        public var updatedAt: Int64
        
    }

    public struct StateLocation: LIFXMessage {
        
        public static let messageType: UInt16 = 50
        
        public var location: [UInt8]
        
        public var label: String
        
        public var updatedAt: Int64
        
    }
    
}

extension Device {

    public struct GetGroup: LIFXMessage {
        
        public static let messageType: UInt16 = 51
        
    }

    public struct SetGroup: LIFXMessage {
        
        public static let messageType: UInt16 = 52
        
        public var group: Data
        
        public var label: String
        
        public var updatedAt: Int64
        
    }

    public struct StateGroup: LIFXMessage {
        
        public static let messageType: UInt16 = 53
        
        public var group: Data
        
        public var label: String
        
        public var updatedAt: Int64
        
    }
    
}

extension Device {

    public struct EchoRequest: LIFXMessage {
        
        public static let messageType: UInt16 = 58
        
        public var payload: Data
        
    }

    public struct EchoResponse: LIFXMessage {
        
        public static let messageType: UInt16 = 59
        
        public var payload: Data
        
    }

}

public struct Light {
    
    public struct HSBK {
        
        public var hue: UInt16
        
        public var saturation: UInt16
        
        public var brightness: UInt16
        
        public var kelvin: UInt16
        
    }
    
    public enum Waveform: UInt8 {
        
        case saw = 0
        
        case sine = 1
        
        case halfSine = 2
        
        case triangle = 3
        
        case pulse = 4
        
    }
    
}

extension Light {

    public struct Get: LIFXMessage {
        
        public static let messageType: UInt16 = 101
        
    }

    public struct SetColor: LIFXMessage {
        
        public static let messageType: UInt16 = 102
        
        public var reserved: UInt8 = 0
        
        public var color: HSBK
        
        public var duration: UInt32
        
    }

    public struct SetWaveform: LIFXMessage {
        
        public static let messageType: UInt16 = 103
        
        public var reserved: UInt8 = 0
        
        public var transient: Bool
        
        public var color: HSBK
        
        public var period: UInt32
        
        public var cycles: Float32
        
        public var skewRatio: Int16
        
        public var waveform: Waveform
        
    }

    public struct SetWaveformOptional: LIFXMessage {
        
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
        
    }

    public struct State: LIFXMessage {
        
        public static let messageType: UInt16 = 107
        
        public var color: HSBK
        
        public var reserved1: Int16 = 0
        
        public var power: UInt16
        
        public var label: String
        
        public var reserved2: UInt64 = 0
        
    }
    
}

extension Light {

    public struct GetPower: LIFXMessage {
        
        public static let messageType: UInt16 = 116
        
    }

    public struct SetPower: LIFXMessage {
        
        public static let messageType: UInt16 = 117
        
        public var level: UInt16
        
        public var duration: UInt32
        
    }

    public struct StatePower: LIFXMessage {
        
        public static let messageType: UInt16 = 118
        
        public var level: UInt16
        
    }
    
}

extension Light {

    public struct GetInfrared: LIFXMessage {
        
        public static let messageType: UInt16 = 120
        
    }

    public struct StateInfrared: LIFXMessage {
        
        public static let messageType: UInt16 = 121
        
        public var brightness: UInt16
        
    }

    public struct SetInfrared: LIFXMessage {
        
        public static let messageType: UInt16 = 122
        
        public var brightness: UInt16
        
    }

}
