//
//  NWConnection+Extensions.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 20/02/19.
//

import Foundation
import Network
import PromiseKit

extension NWConnection {
    
    internal func connect(queue: DispatchQueue) -> Promise<NWConnection> {
        return Promise { resolver in
            self.stateUpdateHandler = { state in
                switch state {
                case .setup:
                    break
                case .waiting(let error):
                    resolver.reject(error)
                case .preparing:
                    break
                case .ready:
                    resolver.fulfill(self)
                case .failed(let error):
                    resolver.reject(error)
                case .cancelled:
                    break
                }
            }
            self.start(queue: queue)
        }
    }
    
}

extension NWConnection {
    
    internal func send(_ data: Data) -> Promise<Void> {
        return Promise { resolver in
            self.send(content: data, completion: .contentProcessed { error in
                switch error {
                case .none:
                    resolver.fulfill(())
                case .some(let error):
                    resolver.reject(error)
                }
            })
        }
    }
    
    internal func receive() -> Promise<Data> {
        return Promise { resolver in
            self.receiveMessage { (data, context, isComplete, error) in
                switch (data, error) {
                case (.some(let data), _):
                    resolver.fulfill(data)
                case (_, .some(let error)):
                    resolver.reject(error)
                default:
                    fatalError("Invalid response")
                }
            }
        }
    }
    
    internal func request(_ data: Data) -> Promise<Data> {
        return when(fulfilled: send(data), receive()).map { _, data in
            return data
        }
    }
    
}
