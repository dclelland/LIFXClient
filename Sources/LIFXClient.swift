//
//  LIFXClient.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 18/02/19.
//

import Foundation
import Network
import PromiseKit

public struct LIFXClient {
    
    let source: UInt32
    
    let connection: NWConnection
    let queue: DispatchQueue
    
    public init(address: IPv4Address = .broadcast, source: UInt32 = 0) {
        self.source = source
        self.connection = NWConnection(host: .ipv4(address), port: 56700, using: .udp)
        self.queue = DispatchQueue(label: "LIFXClient Queue")
    }
    
    public func connect() {
        connection.stateUpdateHandler = { state in
            if state == .ready {
                let packet = LIFXPacket(source: self.source, response: true, message: Light.SetColor(color: Light.HSBK(hue: 0x3333, saturation: 0xFFFF, brightness: 0xFFFF, kelvin: 3500), duration: 1000))
                print(packet)
                self.request(packet).done { (response: LIFXPacket<Light.State>) in
                    print(response)
                }.catch { error in
                    print(error)
                }
            }
        }
        connection.start(queue: queue)
    }
    
}

extension LIFXClient {
    
    public func send<Request: LIFXEncodableMessage>(_ packet: LIFXPacket<Request>) -> Promise<Void> {
        return firstly {
            return connection.send(try LIFXEncoder.encode(packet))
        }
    }
    
    public func receive<Response: LIFXDecodableMessage>(_ type: Response.Type) -> Promise<LIFXPacket<Response>> {
        return connection.receive().map { data in
            return try LIFXDecoder.decode(LIFXPacket<Response>.self, data: data)
        }
    }
    
    public func request<Request: LIFXEncodableMessage, Response: LIFXDecodableMessage>(_ packet: LIFXPacket<Request>) -> Promise<LIFXPacket<Response>> {
        return firstly {
            return connection.request(try LIFXEncoder.encode(packet))
        }.map { data in
            return try LIFXDecoder.decode(LIFXPacket<Response>.self, data: data)
        }
    }
    
}
