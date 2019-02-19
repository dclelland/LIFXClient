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
    
//    let listener: NWListener
    
    public init() {
//        self.connection = NWConnection(host: .ipv4(.broadcast), port: 56700, using: .udp)
        self.connection = NWConnection(host: .ipv4(IPv4Address("192.168.1.83")!), port: 56700, using: .udp)
//        self.connection = NWConnection(host: .ipv4(IPv4Address("255.255.255.0")!), port: 56700, using: .udp) // 192.168.0.255
        self.queue = DispatchQueue(label: "LIFXClient Queue")
        
//        self.listener = try! NWListener(using: .udp, on: 56700)
    }
    
    public func connect() {
        connection.stateUpdateHandler = { state in
            print("CONNECTION", state)
            switch state {
            case .ready:
                self.send()
            default:
                break
            }
        }
        connection.start(queue: queue)
        
//        listener.stateUpdateHandler = { state in
//            print("LISTENER", state)
//            switch state {
////            case .ready:
////                self.listener.
//            default:
//                break
//            }
//        }
//        listener.serviceRegistrationUpdateHandler = { change in
//            print("LISTENER", change)
//        }
//        listener.newConnectionHandler = { connection in
//            print("LISTENER", connection)
//        }
//        listener.start(queue: DispatchQueue(label: "LIFXClient Listener Queue"))
        
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
        
        
//        let bytes: [UInt8] = [
//            // Frame
//            0b0010_0100, // size: 16, 0x24
//            0b0000_0000, // size
//            0b0000_0000, // protocol
//            0b0011_0100, // (origin: 2, tagged: 1, addressable: 1 bit (always set to 1), protocol: 12), 0x34
//
//            0b1000_0000, // source (should probably be nonzero...?)
//            0b0100_0000, // source
//            0b0010_0000, // source
//            0b0001_0000, // source
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
//            0b0000_0010, // type (0x02, little endian),
//            0b0000_0000, // type
//            0b0000_0000, // reserved
//            0b0000_0000, // reserved
//        ]
        
//        let bytes: [UInt8] = [0x24, 0x00, 0x00, 0x34, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x65, 0x00, 0x00, 0x00]
        
        
        let data = try! LIFXEncoder().encode(Device.GetService())
        
//        connection.send(content: Data(bytes: bytes), completion: .contentProcessed { error in
//            print("SENT", error?.localizedDescription ?? "completed")
//        })
//
//        connection.receiveMessage { (content, context, isComplete, error) in
//            print("RECEIVED", content, context, isComplete, error)
//        }
    }
    
}
