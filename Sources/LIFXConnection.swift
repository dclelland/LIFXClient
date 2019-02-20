//
//  LIFXClient.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 18/02/19.
//

import Foundation
import Network
import PromiseKit

public class LIFXConnection {
    
    public var connection: NWConnection
    
    public var source: UInt32
    
    public required init(connection: NWConnection, source: UInt32) {
        self.connection = connection
        self.source = source
    }
    
}

extension LIFXConnection {
    
    public class func connect<Connection: LIFXConnection>(host: NWEndpoint.Host = .ipv4(.broadcast), port: NWEndpoint.Port = 56700, queue: DispatchQueue = DispatchQueue(label: "LIFX Queue"), source: UInt32 = 0) -> Promise<Connection> {
        return NWConnection(host: host, port: port, using: .udp).connect(queue: queue).map { connection in
            return Connection(connection: connection, source: source)
        }
    }
    
}

extension LIFXConnection {
    
    public func send<Request: LIFXEncodableMessage>(_ packet: LIFXPacket<Request>) -> Promise<Void> {
        return firstly {
            return connection.send(try LIFXEncoder.encode(packet))
        }
    }
    
    public func receive<Response: LIFXDecodableMessage>(_ type: Response.Type) -> Promise<LIFXPacket<Response>> {
        return connection.receive().map { data in
            return try LIFXDecoder.decode(LIFXPacket<Response>.self, data: data)
        }
    }
    
    public func request<Request: LIFXEncodableMessage, Response: LIFXDecodableMessage>(_ packet: LIFXPacket<Request>) -> Promise<LIFXPacket<Response>> {
        return firstly {
            return connection.request(try LIFXEncoder.encode(packet))
        }.map { data in
            return try LIFXDecoder.decode(LIFXPacket<Response>.self, data: data)
        }
    }
    
}
