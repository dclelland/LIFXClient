//
//  LIFXClient.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 18/02/19.
//

import Foundation
import Network
import PromiseKit

public struct LIFXClient {
    
    public let source: UInt32
    public let connection: NWConnection
    
    public static func connect(host: NWEndpoint.Host = .ipv4(.broadcast), queue: DispatchQueue = DispatchQueue(label: "LIFXClient Queue"), source: UInt32 = 0) -> Promise<LIFXClient> {
        return NWConnection(host: host, port: 56700, using: .udp).connect(queue: queue).map { connection in
            return LIFXClient(source: source, connection: connection)
        }
    }
    
}

extension LIFXClient {
    
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
