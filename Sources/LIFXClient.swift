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
        connection.send(content: Data(bytes: [0x00]), completion: .contentProcessed { error in
            print("SENT", error)
        })
        
        connection.receiveMessage { (content, context, isComplete, error) in
            print("RECEIVED", content, context, isComplete, error)
        }
    }
    
}
