//
//  LIFXMessage.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 19/02/19.
//

import Foundation

public typealias LIFXCodableMessage = LIFXMessage & LIFXCodable

public typealias LIFXDecodableMessage = LIFXMessage & LIFXDecodable

public typealias LIFXEncodableMessage = LIFXMessage & LIFXEncodable

public protocol LIFXMessage {
    
    static var messageSize: UInt16 { get }
    
    static var messageType: UInt16 { get }
    
}

public struct LIFXAcknowledgement: LIFXDecodableMessage {
    
    public static let messageSize: UInt16 = 0
    
    public static let messageType: UInt16 = 45
    
    public init(from decoder: LIFXDecoder) throws { }
    
}
