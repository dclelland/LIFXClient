//
//  LIFXClient.swift
//  LIFXClient
//
//  Created by Daniel Clelland on 20/02/19.
//

import Foundation
import Network
import PromiseKit

public class LIFXClient: LIFXConnection {
    
    var device: LIFXDevice {
        return LIFXDevice(connection: connection, source: source)
    }
    
    var light: LIFXLight {
        return LIFXLight(connection: connection, source: source)
    }
    
}

public class LIFXDevice: LIFXConnection {
    
//    - getService
//    - getHostInfo
//    - getHostFirmware
//    - getWifiInfo
//    - getWifiFirmware
//    - getPower
//    - setPower
//    - getLabel
//    - setLabel
//    - getVersion
//    - getInfo
//    - getLocation
//    - setLocation
//    - getGroup
//    - setGroup
//    - echo
    
}

public class LIFXLight: LIFXConnection {
    
//    - get
//    - getColor
//    - getWaveform
//    - getWaveformOptional
//    - getPower
//    - getPower
//    - getInfrared
//    - getInfrared
    
}
