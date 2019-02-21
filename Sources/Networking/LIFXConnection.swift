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
    
    public func sendPacket<Request: LIFXEncodableMessage>(_ packet: LIFXPacket<Request>) -> Promise<Void> {
        return firstly {
            return connection.send(try LIFXEncoder.encode(packet))
        }
    }
    
    public func receivePacket<Response: LIFXDecodableMessage>() -> Promise<LIFXPacket<Response>> {
        return connection.receive().map { data in
            return try LIFXDecoder.decode(LIFXPacket<Response>.self, data: data)
        }
    }
    
    public func requestPacket<Request: LIFXEncodableMessage>(_ packet: LIFXPacket<Request>) -> Promise<LIFXPacket<Request.Response>> {
        return firstly {
            return connection.request(try LIFXEncoder.encode(packet))
        }.map { data in
            return try LIFXDecoder.decode(LIFXPacket<Request.Response>.self, data: data)
        }
    }
    
}

extension LIFXConnection {
    
    public func sendMessage<Request: LIFXEncodableMessage>(_ request: Request) -> Promise<Void> {
        return sendPacket(LIFXPacket(source: source, message: request))
    }
    
    public func receiveMessage<Response: LIFXDecodableMessage>() -> Promise<Response> {
        return receivePacket().map { packet in
            return packet.message
        }
    }
    
    public func requestMessage<Request: LIFXEncodableMessage>(_ request: Request) -> Promise<Request.Response> {
        return requestPacket(LIFXPacket(source: source, response: true, message: request)).map { packet in
            return packet.message
        }
    }
    
}
