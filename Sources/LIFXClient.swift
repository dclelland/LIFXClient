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
            0b0011_0001, // 0x31
            0b0000_0000,
            0b0000_0000,
            0b0011_0100, // 0x34
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0110_0110, // 0x66,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0000_0000,
            0b0101_0101, // 0x55
            0b0101_0101, // 0x55
            0b1111_1111, // 0xFF,
            0b1111_1111, // 0xFF,
            0b1111_1111, // 0xFF,
            0b1111_1111, // 0xFF,
            0b1010_1100, // 0xAC,
            0b0000_1101, // 0x0D,
            0b0000_0000,
            0b0000_0100, // 0x04
            0b0000_0000,
            0b0000_0000
        ]
//        connection.send(content: Data(bytes: bytes), completion: .contentProcessed { error in
//            print("SENT", error)
//        })
//
//        connection.receiveMessage { (content, context, isComplete, error) in
//            print("RECEIVED", content, context, isComplete, error)
//        }
    }
    
}
