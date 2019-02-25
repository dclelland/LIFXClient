//
//  LIFXMessage.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 19/02/19.
//

import Foundation

public protocol LIFXDecodableMessage: LIFXMessage, LIFXDecodable { }

public protocol LIFXEncodableMessage: LIFXMessage, LIFXEncodable {
    
    associatedtype Response: LIFXDecodableMessage
    
}

public protocol LIFXMessage {
    
    static var messageSize: UInt16 { get }
    
    static var messageType: UInt16 { get }
    
}
