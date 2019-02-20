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

extension LIFXPacket: LIFXDecodable where Message: LIFXDecodable {
    
    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        message = try container.decode(Message.self)
    }
    
}

extension LIFXPacket: LIFXEncodable where Message: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        try container.encode(message)
    }
    
}
