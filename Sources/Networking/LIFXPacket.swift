//
//  LIFXPacket.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 19/02/19.
//

import Foundation

public struct LIFXPacket<Message: LIFXMessage> {
    
    public var origin: UInt8
    
    public var tagged: Bool
    
    public var addressable: Bool
    
    public var `protocol`: UInt16
    
    public var source: UInt32
    
    public var target: UInt64
    
    public var sequence: UInt8
    
    public var acknowledgement: Bool
    
    public var response: Bool
    
    public var message: Message
    
    public init(origin: UInt8 = 0, tagged: Bool = true, addressable: Bool = true, protocol: UInt16 = 1024, source: UInt32 = 0, target: UInt64 = 0, acknowledgement: Bool = false, response: Bool = false, sequence: UInt8 = 0, message: Message) {
        self.origin = origin
        self.tagged = tagged
        self.addressable = addressable
        self.protocol = `protocol`
        self.source = source
        self.target = target
        self.acknowledgement = acknowledgement
        self.response = response
        self.sequence = sequence
        self.message = message
    }
    
}

extension LIFXPacket {
    
    private static var packetSize: UInt16 {
        return Message.messageSize + 36
    }
    
    private static var messageType: UInt16 {
        return Message.messageType
    }
    
}

extension LIFXPacket {
    
    public enum Error: Swift.Error {
        
        case incorrectPacketSize(expected: UInt16, received: UInt16)
        case incorrectMessageType(expected: UInt16, received: UInt16)
        
    }
    
}

extension LIFXPacket: LIFXDecodable where Message: LIFXDecodable {

    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        
        // Frame
        let size = try container.decode(UInt16.self)
        guard size == LIFXPacket.packetSize else { throw Error.incorrectPacketSize(expected: LIFXPacket.packetSize, received: size) }
        let frame = try container.decode(UInt16.self)
        origin = UInt8(frame & 0b1100_0000_0000_0000 >> 14)
        tagged = frame & 0b0010_0000_0000_0000 != 0
        addressable = frame & 0b0001_0000_0000_0000 != 0
        `protocol` = frame & 0b0000_1111_1111_1111
        source = try container.decode(UInt32.self)
        
        // Frame address
        target = try container.decode(UInt64.self)
        try container.decodeEmpty(bytes: 6)
        let requirements = try container.decode(UInt8.self)
        acknowledgement = requirements & 0b0000_0010 != 0
        response = requirements & 0b0000_0001 != 0
        sequence = try container.decode(UInt8.self)
        
        // Protocol header
        try container.decodeEmpty(bytes: 8)
        let type = try container.decode(UInt16.self)
        guard type == Message.messageType else { throw Error.incorrectMessageType(expected: LIFXPacket.messageType, received: type) }
        try container.decodeEmpty(bytes: 2)
        
        // Payload
        message = try container.decode(Message.self)
    }

}

extension LIFXPacket: LIFXEncodable where Message: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        
        // Frame
        try container.encode(LIFXPacket.packetSize)
        try container.encode(UInt16((UInt16(origin) << 14) | (tagged ? 0b0010_0000_0000_0000 : 0) | (addressable ? 0b0001_0000_0000_0000 : 0) | (`protocol` & 0b0000_1111_1111_1111)))
        try container.encode(source)
        
        // Frame address
        try container.encode(target)
        try container.encodeEmpty(bytes: 6)
        try container.encode(UInt8((acknowledgement ? 0b0000_0010 : 0) | (response ? 0b0000_0001 : 0)))
        try container.encode(sequence)
        
        // Protocol header
        try container.encodeEmpty(bytes: 8)
        try container.encode(LIFXPacket.messageType)
        try container.encodeEmpty(bytes: 2)
        
        // Payload
        try container.encode(message)
    }
    
}
