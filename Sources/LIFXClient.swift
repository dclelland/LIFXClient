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
    
    public class func connect(host: NWEndpoint.Host = .ipv4(.broadcast), port: NWEndpoint.Port = 56700, queue: DispatchQueue = DispatchQueue(label: "LIFX Queue"), source: UInt32 = UInt32.random()) -> Promise<LIFXClient> {
        return NWConnection(host: host, port: port, using: .udp).connect(queue: queue).map { connection in
            return LIFXClient(connection: connection, source: source, target: 0)
        }
    }
    
}

extension LIFXClient {
    
    public func getDevice() -> Promise<LIFXDevice> {
        return requestPacket(LIFXPacket(tagged: true, source: source, target: target, response: true, message: LIFXDevice.GetService())).map { packet in
            return LIFXDevice(connection: self.connection, source: self.source, target: packet.target)
        }
    }
    
    public func getLight() -> Promise<LIFXLight> {
        return requestPacket(LIFXPacket(tagged: true, source: source, target: target, response: true, message: LIFXDevice.GetService())).map { packet in
            return LIFXLight(connection: self.connection, source: self.source, target: packet.target)
        }
    }
    
}
