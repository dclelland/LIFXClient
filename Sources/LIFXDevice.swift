//
//  LIFXDevice.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 21/02/19.
//

import Foundation
import PromiseKit

public class LIFXDevice: LIFXConnection { }

extension LIFXDevice {
    
    public enum Service: UInt8, LIFXDecodable {
        
        case udp = 1
        
    }
    
    public struct GetService: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 2
        
        public init() { }
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct StateService: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 5
        
        public static let messageType: UInt16 = 3
        
        public var service: Service
        
        public var port: UInt32
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            service = try container.decode(Service.self)
            port = try container.decode(UInt32.self)
        }
        
    }
    
    public func getService() -> Promise<StateService> {
        return requestMessage(GetService())
    }
    
}

extension LIFXDevice {
    
    public struct GetHostInfo: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 12
        
        public init() { }
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct StateHostInfo: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 12
        
        public static let messageType: UInt16 = 13
        
        public var signal: Float32
        
        public var tx: UInt32
        
        public var rx: UInt32
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            signal = try container.decode(Float32.self)
            tx = try container.decode(UInt32.self)
            rx = try container.decode(UInt32.self)
            try container.decodeEmpty(bytes: 2)
        }
        
    }
    
    public func getHostInfo(_ request: GetHostInfo) -> Promise<StateHostInfo> {
        return requestMessage(GetHostInfo())
    }
    
}

extension LIFXDevice {
    
    public struct GetHostFirmware: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 14
        
        public init() { }
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct StateHostFirmware: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 20
        
        public static let messageType: UInt16 = 15
        
        public var build: Date
        
        public var version: UInt32
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            build = try container.decode(Date.self)
            try container.decodeEmpty(bytes: 8)
            version = try container.decode(UInt32.self)
        }
        
    }
    
    public func getHostFirmware(_ request: GetHostFirmware) -> Promise<StateHostFirmware> {
        return requestMessage(GetHostFirmware())
    }
    
}

extension LIFXDevice {
    
    public struct GetWifiInfo: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 16
        
        public init() { }
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct StateWifiInfo: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 12
        
        public static let messageType: UInt16 = 17
        
        public var signal: Float32
        
        public var tx: UInt32
        
        public var rx: UInt32
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            signal = try container.decode(Float32.self)
            tx = try container.decode(UInt32.self)
            rx = try container.decode(UInt32.self)
            try container.decodeEmpty(bytes: 2)
        }
        
    }
    
    public func getWifiInfo() -> Promise<StateWifiInfo> {
        return requestMessage(GetWifiInfo())
    }
    
}

extension LIFXDevice {
    
    public struct GetWifiFirmware: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 18
        
        public init() { }
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct StateWifiFirmware: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 12
        
        public static let messageType: UInt16 = 19
        
        public var build: Date
        
        public var version: UInt32
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            build = try container.decode(Date.self)
            try container.decodeEmpty(bytes: 8)
            version = try container.decode(UInt32.self)
        }
        
    }
    
    public func getWifiFirmware() -> Promise<StateWifiFirmware> {
        return requestMessage(GetWifiFirmware())
    }
    
}

extension LIFXDevice {
    
    public struct GetPower: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 20
        
        public init() { }
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct SetPower: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 2
        
        public static let messageType: UInt16 = 21
        
        public var level: UInt16
        
        public init(level: UInt16) {
            self.level = level
        }
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encode(level)
        }
        
    }
    
    public struct StatePower: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 2
        
        public static let messageType: UInt16 = 22
        
        public var level: UInt16
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            level = try container.decode(UInt16.self)
        }
        
    }
    
    public func getPower() -> Promise<StatePower> {
        return requestMessage(GetPower())
    }
    
    public func setPower(_ request: SetPower) -> Promise<StatePower> {
        return requestMessage(request)
    }
    
}

extension LIFXDevice {
    
    public struct GetLabel: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 23
        
        public init() { }
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct SetLabel: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 32
        
        public static let messageType: UInt16 = 24
        
        public var label: String
        
        public init(label: String) {
            self.label = label
        }
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encodeString(label, bytes: 32)
        }
        
    }
    
    public struct StateLabel: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 32
        
        public static let messageType: UInt16 = 25
        
        public var label: String
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            label = try container.decodeString(bytes: 32)
        }
        
    }
    
    public func getLabel() -> Promise<StateLabel> {
        return requestMessage(GetLabel())
    }
    
    public func setLabel(_ request: SetLabel) -> Promise<StateLabel> {
        return requestMessage(request)
    }
    
}

extension LIFXDevice {
    
    public struct GetVersion: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 32
        
        public init() { }
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct StateVersion: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 12
        
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
    
    public func getVersion() -> Promise<StateVersion> {
        return requestMessage(GetVersion())
    }
    
}

extension LIFXDevice {
    
    public struct GetInfo: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 34
        
        public init() { }
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct StateInfo: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 24
        
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
    
    public func getInfo() -> Promise<StateInfo> {
        return requestMessage(GetInfo())
    }
    
}

extension LIFXDevice {
    
    public struct GetLocation: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 48
        
        public init() { }
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct SetLocation: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 56
        
        public static let messageType: UInt16 = 49
        
        public var location: Data
        
        public var label: String
        
        public var updatedAt: Date
        
        public init(location: Data, label: String, updatedAt: Date) {
            self.location = location
            self.label = label
            self.updatedAt = updatedAt
        }
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encodeData(location, bytes: 16)
            try container.encodeString(label, bytes: 32)
            try container.encode(updatedAt)
        }
        
    }
    
    public struct StateLocation: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 56
        
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
    
    public func getLocation() -> Promise<StateLocation> {
        return requestMessage(GetLocation())
    }
    
    public func setLocation(_ request: SetLocation) -> Promise<StateLocation> {
        return requestMessage(request)
    }
    
}

extension LIFXDevice {
    
    public struct GetGroup: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 51
        
        public func encode(to encoder: LIFXEncoder) throws { }
        
    }
    
    public struct SetGroup: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 56
        
        public static let messageType: UInt16 = 52
        
        public var group: Data
        
        public var label: String
        
        public var updatedAt: Date
        
        public init(group: Data, label: String, updatedAt: Date) {
            self.group = group
            self.label = label
            self.updatedAt = updatedAt
        }
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encodeData(group, bytes: 16)
            try container.encodeString(label, bytes: 32)
            try container.encode(updatedAt)
        }
        
    }
    
    public struct StateGroup: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 56
        
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
    
    public func getGroup() -> Promise<StateGroup> {
        return requestMessage(GetGroup())
    }
    
    public func setGroup(_ request: SetGroup) -> Promise<StateGroup> {
        return requestMessage(request)
    }
    
}

extension LIFXDevice {
    
    public struct EchoRequest: LIFXEncodableMessage {
        
        public static let messageSize: UInt16 = 64
        
        public static let messageType: UInt16 = 58
        
        public var payload: Data
        
        public init(payload: Data) {
            self.payload = payload
        }
        
        public func encode(to encoder: LIFXEncoder) throws {
            var container = encoder.container()
            try container.encodeData(payload, bytes: 64)
        }
        
    }
    
    public struct EchoResponse: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 64
        
        public static let messageType: UInt16 = 59
        
        public var payload: Data
        
        public init(from decoder: LIFXDecoder) throws {
            var container = decoder.container()
            payload = try container.decodeData(bytes: 64)
        }
        
    }
    
    public func echo(_ request: EchoRequest) -> Promise<EchoResponse> {
        return requestMessage(request)
    }
    
}