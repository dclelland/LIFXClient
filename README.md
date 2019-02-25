# LIFXClient

Swift client for the LIFX UDP protocol, based on PromiseKit and Apple's Network framework.

## Links

Documentation: https://lan.developer.lifx.com

## Todo

- Discovery issue (try Wireshark)
- Set up readme and publish

## Documentation

### Connection

Simple setup:

```swift
LIFXClient.connect(host: .ipv4(IPv4Address("192.168.1.4")!)).then { client in
    return client.light.setColor(color: .orange)
}
```

### API

```swift
client.device.getService()
client.device.getHostInfo()
client.device.getHostFirmware()
client.device.getWifiInfo()
client.device.getWifiFirmware()
client.device.getPower()
client.device.setPower(on: Bool)
client.device.getLabel()
client.device.setLabel(label: String)
client.device.getVersion()
client.device.getInfo()
client.device.getLocation()
client.device.setLocation(location: Data, label: String, updatedAt: Date)
client.device.getGroup()
client.device.setGroup(group: Data, label: String, updatedAt: Date)
client.device.echo(payload: Data)
```

```swift
client.light.get()
client.light.setColor(color: UIColor, kelvin: UInt16, duration: TimeInterval)
client.light.setWaveform(transient: Bool, color: UIColor, kelvin: UInt16, period: TimeInterval, cycles: Double, dutyCycle: Double, waveform: Waveform)
client.light.setWaveformOptional(transient: Bool, color: UIColor, kelvin: UInt16, period: TimeInterval, cycles: Double, dutyCycle: Double, waveform: Waveform, setHue: Bool, setSaturation: Bool, setBrightness: Bool, setKelvin: Bool)
client.light.getPower()
client.light.setPower(on: Bool, duration: TimeInterval)
client.light.getInfrared()
client.light.setInfrared(brightness: Double)
```

## Wishlist

- Sort out discovery issue: Apple's Network framework doesn't support UDP broadcast packets: https://forums.developer.apple.com/thread/104076
- macOS compatibility