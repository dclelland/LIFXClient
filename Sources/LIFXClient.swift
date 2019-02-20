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
//        self.connection = NWConnection(host: .ipv4(.broadcast), port: 56700, using: .udp)
        self.connection = NWConnection(host: .ipv4(IPv4Address("192.168.1.83")!), port: 56700, using: .udp)
        self.queue = DispatchQueue(label: "LIFXClient Queue")
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
    }
    
    public func send() {
        let message = Light.SetColor(color: Light.HSBK(hue: 0x0000, saturation: 0xFFFF, brightness: 0xFFFF, kelvin: 0x0DAC), duration: 1024)
        let packet = LIFXPacket(message: message)
        let data = try! LIFXEncoder.encode(packet)
        
        print("DATA", [UInt8](data))
        
        connection.send(content: data, completion: .contentProcessed { error in
            print("SENT", error?.localizedDescription ?? "completed")
        })

        connection.receiveMessage { (content, context, isComplete, error) in
            print("RECEIVED", content, context, isComplete, error)
        }
    }
    
}
