//
//  LIFXClient.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 20/02/19.
//

import Foundation
import Network
import PromiseKit

public class LIFXClient: LIFXConnection {
    
    public class func connect(host: NWEndpoint.Host = .ipv4(.broadcast), port: NWEndpoint.Port = 56700, queue: DispatchQueue = DispatchQueue(label: "LIFX Queue"), source: UInt32 = 0) -> Promise<LIFXConnection> {
        return NWConnection(host: host, port: port, using: .udp).connect(queue: queue).map { connection in
            return LIFXConnection(connection: connection, source: source)
        }
    }
    
}

extension LIFXConnection {
    
    public var device: LIFXDevice {
        return LIFXDevice(connection: connection, source: source)
    }
    
    public var light: LIFXLight {
        return LIFXLight(connection: connection, source: source)
    }
    
}

public class LIFXDevice: LIFXConnection {
    
    public func getService() -> Promise<Device.StateService> {
        return requestMessage(Device.GetService())
    }
    
    public func getHostInfo(_ request: Device.GetHostInfo) -> Promise<Device.StateHostInfo> {
        return requestMessage(Device.GetHostInfo())
    }
    
    public func getHostFirmware(_ request: Device.GetHostFirmware) -> Promise<Device.StateHostFirmware> {
        return requestMessage(Device.GetHostFirmware())
    }
    
    public func getWifiInfo(_ request: Device.GetWifiInfo) -> Promise<Device.StateWifiInfo> {
        return requestMessage(Device.GetWifiInfo())
    }
    
    public func getWifiFirmware(_ request: Device.GetWifiFirmware) -> Promise<Device.StateWifiFirmware> {
        return requestMessage(Device.GetWifiFirmware())
    }
    
    public func getPower() -> Promise<Device.StatePower> {
        return requestMessage(Device.GetPower())
    }
    
    public func setPower(_ request: Device.SetPower) -> Promise<Device.StatePower> {
        return requestMessage(request)
    }
    
    public func getLabel() -> Promise<Device.StateLabel> {
        return requestMessage(Device.GetLabel())
    }
    
    public func setLabel(_ request: Device.SetLabel) -> Promise<Device.StateLabel> {
        return requestMessage(request)
    }
    
    public func getVersion() -> Promise<Device.StateVersion> {
        return requestMessage(Device.GetVersion())
    }
    
    public func getInfo() -> Promise<Device.StateInfo> {
        return requestMessage(Device.GetInfo())
    }
    
    public func getLocation() -> Promise<Device.StateLocation> {
        return requestMessage(Device.GetLocation())
    }
    
    public func setLocation(_ request: Device.SetLocation) -> Promise<Device.StateLocation> {
        return requestMessage(request)
    }
    
    public func getGroup() -> Promise<Device.StateGroup> {
        return requestMessage(Device.GetGroup())
    }
    
    public func setGroup(_ request: Device.SetGroup) -> Promise<Device.StateGroup> {
        return requestMessage(request)
    }
    
    public func echo(_ request: Device.EchoRequest) -> Promise<Device.EchoResponse> {
        return requestMessage(request)
    }
    
}

public class LIFXLight: LIFXConnection {
    
    public func get() -> Promise<Light.State> {
        return requestMessage(Light.Get())
    }
    
    public func setColor(_ request: Light.SetColor) -> Promise<Light.State> {
        return requestMessage(request)
    }
    
    public func setWaveform(_ request: Light.SetWaveform) -> Promise<Light.State> {
        return requestMessage(request)
    }
    
    public func setWaveformOptional(_ request: Light.SetWaveformOptional) -> Promise<Light.State> {
        return requestMessage(request)
    }
    
    public func setPower(_ request: Light.SetPower) -> Promise<Light.State> {
        return requestMessage(request)
    }
    
    public func setInfrared(_ request: Light.SetInfrared) -> Promise<Light.State> {
        return requestMessage(request)
    }
    
}
