//
//  LIFXClient.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 18/02/19.
//

import Foundation
import Network

public struct LIFXClient {
    
    let connection: NWConnection
    let queue: DispatchQueue
    
    public init() {
        self.connection = NWConnection(host: .ipv4(.broadcast), port: 56700, using: .udp)
        self.queue = DispatchQueue(label: "LIFXClient Queue")
    }
    
    public func connect() {
        connection.stateUpdateHandler = { state in
            switch state {
            case .ready:
                self.send()
            default:
                break
            }
        }
        connection.start(queue: queue)
    }
    
    public func send() {
        let bytes: [UInt8] = [
            // Frame
            0b0011_0001, // size: 16, 0x31
            0b0000_0000, // size
            0b0000_0000, // protocol
            0b0011_0100, // (origin: 2, tagged: 1, addressable: 1, protocol: 12), 0x34
            
            0b0000_0000, // source
            0b0000_0000, // source
            0b0000_0000, // source
            0b0000_0000, // source
            
            // Frame address
            0b0000_0000, // target
            0b0000_0000, // target
            0b0000_0000, // target
            0b0000_0000, // target
            
            0b0000_0000, // target
            0b0000_0000, // target
            0b0000_0000, // target
            0b0000_0000, // target
            
            0b0000_0000, // reserved
            0b0000_0000, // reserved
            0b0000_0000, // reserved
            0b0000_0000, // reserved
            
            0b0000_0000, // reserved
            0b0000_0000, // reserved
            0b0000_0000, // more reserved, ack_required, res_required
            0b0000_0000, // sequence
            
            // Protocol header
            0b0000_0000, // reserved
            0b0000_0000, // reserved
            0b0000_0000, // reserved
            0b0000_0000, // reserved
            
            0b0000_0000, // reserved
            0b0000_0000, // reserved
            0b0000_0000, // reserved
            0b0000_0000, // reserved
            
            0b0110_0110, // type (0x66, little endian),
            0b0000_0000, // type
            0b0000_0000, // reserved
            0b0000_0000, // reserved
            
            // Payload
            0b0000_0000, // reserved
            0b0101_0101, // 0x55 // hue
            0b0101_0101, // 0x55 // hue
            0b1111_1111, // 0xFF, // saturation
            
            0b1111_1111, // 0xFF, // saturation
            0b1111_1111, // 0xFF, // brightness
            0b1111_1111, // 0xFF, // brightness
            0b1010_1100, // 0xAC, // 3500 kelvin
            
            0b0000_1101, // 0x0D, // 3500 kelvin
            0b0000_0000, // 0x00 // 1024 ms
            0b0000_0100, // 0x04 // 1024 ms
            0b0000_0000, // 0x00 // 1024 ms
            
            0b0000_0000 // 0x00 // 1024 ms
        ]
        
        let bytes2: [UInt8] = [0x31, 0x00, 0x00, 0x34, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x00, 0x00, 0x00, 0x00, 0x55, 0x55, 0xFF, 0xFF, 0xFF, 0xFF, 0xAC, 0x0D, 0x00, 0x04, 0x00, 0x00]
//        connection.send(content: Data(bytes: bytes), completion: .contentProcessed { error in
//            print("SENT", error)
//        })
//
//        connection.receiveMessage { (content, context, isComplete, error) in
//            print("RECEIVED", content, context, isComplete, error)
//        }
    }
    
}
