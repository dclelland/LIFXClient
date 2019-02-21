# LIFXClient

Swift client for the LIFX UDP protocol

## Links

Documentation: https://lan.developer.lifx.com

## Todo

- Review whether some requests should just be synchronous `send` calls
- Figure out cycles and skew ratios (only pulse waveforms have skew ratios)
- Tidy up errors
- Discovery issue (try Wireshark)
- Review how `source` and `tagged`/`target` are set
- Set up readme and publish
- macOS compatibility
    - Will need Color typealias for NSColor
- Add documentation and publish release
