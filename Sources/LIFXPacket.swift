//
//  LIFXPacket.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 19/02/19.
//

import Foundation

public struct LIFXPacket<Message: LIFXMessage> {
    
    public var source: UInt32
    
    public var target: UInt64
    
    public var sequence: UInt8
    
    public var message: Message
    
    public init(source: UInt32 = 0, target: UInt64 = 0, sequence: UInt8 = 0, message: Message) {
        self.source = source
        self.target = target
        self.sequence = sequence
        self.message = message
    }
    
}

extension LIFXPacket {
    
    private static var size: UInt16 {
        return 36 + Message.messageSize
    }
    
}

extension LIFXPacket: LIFXDecodable where Message: LIFXDecodable {

    public init(from decoder: LIFXDecoder) throws {
        var container = decoder.container()
        
        // Frame
        guard try container.decode(UInt16.self) == LIFXPacket.size else { throw LIFXDecoder.Error.dataCorrupted("Invalid packet size") }
        _ = try container.decode(UInt16.self)
        source = try container.decode(UInt32.self)
        
        // Frame address
        target = try container.decode(UInt64.self)
        try container.decodeEmpty(bytes: 6)
        _ = try container.decode(UInt8.self)
        sequence = try container.decode(UInt8.self)
        
        // Protocol header
        try container.decodeEmpty(bytes: 8)
        guard try container.decode(UInt16.self) == Message.messageType else { throw LIFXDecoder.Error.dataCorrupted("Invalid message type") }
        try container.decodeEmpty(bytes: 2)
        
        // Payload
        message = try container.decode(Message.self)
    }

}

extension LIFXPacket: LIFXEncodable where Message: LIFXEncodable {
    
    public func encode(to encoder: LIFXEncoder) throws {
        var container = encoder.container()
        
        // Frame
        try container.encode(LIFXPacket.size)
        try container.encode(UInt16(0b0011_0100_0000_0000)) // Come back to this: origin, tagged, addressable, protocol
        try container.encode(source)
        
        // Frame address
        try container.encode(target)
        try container.encodeEmpty(bytes: 6)
        try container.encode(UInt8(0b0000_0000)) // Come back to this: reserved, ack_required, res_required
        try container.encode(sequence)
        
        // Protocol header
        try container.encodeEmpty(bytes: 8)
        try container.encode(Message.messageType)
        try container.encodeEmpty(bytes: 2)
        
        // Payload
        try container.encode(message)
    }
    
}

//        let bytes: [UInt8] = [
//            // Frame
//            0b0011_0001, // size: 16, 0x31
//            0b0000_0000, // size
//            0b0000_0000, // protocol
//            0b0011_0100, // (origin: 2, tagged: 1, addressable: 1, protocol: 12), 0x34
//
//            0b0000_0000, // source
//            0b0000_0000, // source
//            0b0000_0000, // source
//            0b0000_0000, // source
//
//            // Frame address
//            0b0000_0000, // target
//            0b0000_0000, // target
//            0b0000_0000, // target
//            0b0000_0000, // target
//
//            0b0000_0000, // target
//            0b0000_0000, // target
//            0b0000_0000, // target
//            0b0000_0000, // target
//
//            0b0000_0000, // reserved
//            0b0000_0000, // reserved
//            0b0000_0000, // reserved
//            0b0000_0000, // reserved
//
//            0b0000_0000, // reserved
//            0b0000_0000, // reserved
//            0b0000_0000, // more reserved, ack_required, res_required
//            0b0000_0000, // sequence
//
//            // Protocol header
//            0b0000_0000, // reserved
//            0b0000_0000, // reserved
//            0b0000_0000, // reserved
//            0b0000_0000, // reserved
//
//            0b0000_0000, // reserved
//            0b0000_0000, // reserved
//            0b0000_0000, // reserved
//            0b0000_0000, // reserved
//
//            0b0110_0110, // type (0x66, little endian),
//            0b0000_0000, // type
//            0b0000_0000, // reserved
//            0b0000_0000, // reserved
//
//            // Payload
//            0b0000_0000, // reserved
//            0b0101_0101, // 0x55 // hue
//            0b0101_0101, // 0x55 // hue
//            0b1111_1111, // 0xFF, // saturation
//
//            0b1111_1111, // 0xFF, // saturation
//            0b1111_1111, // 0xFF, // brightness
//            0b1111_1111, // 0xFF, // brightness
//            0b1010_1100, // 0xAC, // 3500 kelvin
//
//            0b0000_1101, // 0x0D, // 3500 kelvin
//            0b0000_0000, // 0x00 // 1024 ms
//            0b0000_0100, // 0x04 // 1024 ms
//            0b0000_0000, // 0x00 // 1024 ms
//
//            0b0000_0000 // 0x00 // 1024 ms
//        ]
