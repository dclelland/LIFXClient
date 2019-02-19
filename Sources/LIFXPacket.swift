//
//  LIFXPacket.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 19/02/19.
//

import Foundation

public struct LIFXPacket<Message: LIFXMessage> {
    
    public var message: Message
    
    public init(message: Message) {
        self.message = message
    }
    
}

extension LIFXPacket: Decodable, LIFXDecodable where Message: LIFXDecodable {
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        message = try container.decode(Message.self)
    }
    
}

extension LIFXPacket: Encodable, LIFXEncodable where Message: LIFXEncodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(message)
    }
    
}
