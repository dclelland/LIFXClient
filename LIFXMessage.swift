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

    public struct GetService: LIFXMessage {
        
        public static let messageType: UInt16 = 2
        
    }

    public struct StateService: LIFXMessage {
        
        public static let messageType: UInt16 = 3
        
    }

    public struct GetHostInfo: LIFXMessage {
        
        public static let messageType: UInt16 = 12
        
    }

    public struct StateHostInfo: LIFXMessage {
        
        public static let messageType: UInt16 = 13
        
    }

    public struct GetHostFirmware: LIFXMessage {
        
        public static let messageType: UInt16 = 14
        
    }

    public struct StateHostFirmware: LIFXMessage {
        
        public static let messageType: UInt16 = 15
        
    }

    public struct GetWifiInfo: LIFXMessage {
        
        public static let messageType: UInt16 = 16
        
    }

    public struct StateWifiInfo: LIFXMessage {
        
        public static let messageType: UInt16 = 17
        
    }

    public struct GetWifiFirmware: LIFXMessage {
        
        public static let messageType: UInt16 = 18
        
    }

    public struct StateWifiFirmware: LIFXMessage {
        
        public static let messageType: UInt16 = 19
        
    }

    public struct GetPower: LIFXMessage {
        
        public static let messageType: UInt16 = 20
        
    }

    public struct SetPower: LIFXMessage {
        
        public static let messageType: UInt16 = 21
        
    }

    public struct StatePower: LIFXMessage {
        
        public static let messageType: UInt16 = 22
        
    }

    public struct GetLabel: LIFXMessage {
        
        public static let messageType: UInt16 = 23
        
    }

    public struct SetLabel: LIFXMessage {
        
        public static let messageType: UInt16 = 24
        
    }

    public struct StateLabel: LIFXMessage {
        
        public static let messageType: UInt16 = 25
        
    }

    public struct GetVersion: LIFXMessage {
        
        public static let messageType: UInt16 = 32
        
    }

    public struct StateVersion: LIFXMessage {
        
        public static let messageType: UInt16 = 33
        
    }

    public struct GetInfo: LIFXMessage {
        
        public static let messageType: UInt16 = 34
        
    }

    public struct StateInfo: LIFXMessage {
        
        public static let messageType: UInt16 = 35
        
    }

    public struct Acknowledgement: LIFXMessage {
        
        public static let messageType: UInt16 = 45
        
    }

    public struct GetLocation: LIFXMessage {
        
        public static let messageType: UInt16 = 48
        
    }

    public struct SetLocation: LIFXMessage {
        
        public static let messageType: UInt16 = 49
        
    }

    public struct StateLocation: LIFXMessage {
        
        public static let messageType: UInt16 = 50
        
    }

    public struct GetGroup: LIFXMessage {
        
        public static let messageType: UInt16 = 51
        
    }

    public struct SetGroup: LIFXMessage {
        
        public static let messageType: UInt16 = 52
        
    }

    public struct StateGroup: LIFXMessage {
        
        public static let messageType: UInt16 = 53
        
    }

    public struct EchoRequest: LIFXMessage {
        
        public static let messageType: UInt16 = 58
        
    }

    public struct EchoResponse: LIFXMessage {
        
        public static let messageType: UInt16 = 59
        
    }

}

public struct Light {

    public struct Get: LIFXMessage {
        
        public static let messageType: UInt16 = 101
        
    }

    public struct SetColor: LIFXMessage {
        
        public static let messageType: UInt16 = 102
        
    }

    public struct SetWaveform: LIFXMessage {
        
        public static let messageType: UInt16 = 103
        
    }

    public struct SetWaveformOptional: LIFXMessage {
        
        public static let messageType: UInt16 = 119
        
    }

    public struct State: LIFXMessage {
        
        public static let messageType: UInt16 = 107
        
    }

    public struct GetPower: LIFXMessage {
        
        public static let messageType: UInt16 = 116
        
    }

    public struct SetPower: LIFXMessage {
        
        public static let messageType: UInt16 = 117
        
    }

    public struct StatePower: LIFXMessage {
        
        public static let messageType: UInt16 = 118
        
    }

    public struct GetInfrared: LIFXMessage {
        
        public static let messageType: UInt16 = 120
        
    }

    public struct StateInfrared: LIFXMessage {
        
        public static let messageType: UInt16 = 121
        
    }

    public struct SetInfrared: LIFXMessage {
        
        public static let messageType: UInt16 = 122
        
    }

}
