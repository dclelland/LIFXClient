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
    
    public class func connect(host: NWEndpoint.Host, port: NWEndpoint.Port = 56700, queue: DispatchQueue = DispatchQueue(label: "LIFX Queue"), source: UInt32 = UInt32.random(), target: UInt64 = 0) -> Promise<LIFXClient> {
        return NWConnection(host: host, port: port, using: .udp).connect(queue: queue).map { connection in
            return LIFXClient(connection: connection, source: source, target: target)
        }
    }
    
}

extension LIFXClient {
    
    public var device: LIFXDevice {
        return LIFXDevice(connection: connection, source: source, target: target)
    }
    
    public var light: LIFXLight {
        return LIFXLight(connection: connection, source: source, target: target)
    }
    
}
