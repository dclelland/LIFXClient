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
    
    public class func connect(host: NWEndpoint.Host = .ipv4(.broadcast), port: NWEndpoint.Port = 56700, queue: DispatchQueue = DispatchQueue(label: "LIFX Queue"), source: UInt32 = UInt32.random()) -> Promise<LIFXConnection> {
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
