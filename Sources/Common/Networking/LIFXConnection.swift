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
    
    public var target: UInt64
    
    public required init(connection: NWConnection, source: UInt32, target: UInt64) {
        self.connection = connection
        self.source = source
        self.target = target
    }
    
}

extension LIFXConnection {
    
    public func sendPacket<Message: LIFXEncodableMessage>(_ packet: LIFXPacket<Message>) -> Promise<Void> {
        return firstly {
            return connection.send(try LIFXEncoder.encode(packet))
        }
    }
    
    public func receivePacket<Message: LIFXDecodableMessage>() -> Promise<LIFXPacket<Message>> {
        return connection.receive().map { data in
            return try LIFXDecoder.decode(LIFXPacket<Message>.self, data: data)
        }
    }
    
    public func requestPacket<Message: LIFXEncodableMessage>(_ packet: LIFXPacket<Message>) -> Promise<LIFXPacket<Message.Response>> {
        return firstly {
            return connection.request(try LIFXEncoder.encode(packet))
        }.map { data in
            return try LIFXDecoder.decode(LIFXPacket<Message.Response>.self, data: data)
        }
    }
    
}

extension LIFXConnection {
    
    public func sendMessage<Message: LIFXEncodableMessage>(_ message: Message) -> Promise<Void> {
        return sendPacket(LIFXPacket(tagged: target == 0, source: source, target: target, response: false, message: message))
    }
    
    public func receiveMessage<Message: LIFXDecodableMessage>() -> Promise<Message> {
        return receivePacket().map { packet in
            return packet.message
        }
    }
    
    public func requestMessage<Message: LIFXEncodableMessage>(_ message: Message) -> Promise<Message.Response> {
        return requestPacket(LIFXPacket(tagged: target == 0, source: source, target: target, response: true, message: message)).map { packet in
            return packet.message
        }
    }
    
}

extension LIFXConnection {

    public struct Acknowledgement: LIFXDecodableMessage {
        
        public static let messageSize: UInt16 = 0
        
        public static let messageType: UInt16 = 45
        
        public init(from decoder: LIFXDecoder) throws { }
        
    }

}
