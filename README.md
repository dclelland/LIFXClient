# LIFXClient

Swift client for the LIFX UDP protocol

## Links

Documentation: https://lan.developer.lifx.com

## Todo

- Review whether some requests should just be synchronous `send` calls
- Figure out cycles and skew ratios (only pulse waveforms have skew ratios)
- Figure out the string/data padding stuff (strings come back with \0\0\0 on the end)
- Tidy up errors
- Discovery issue (try Wireshark)
- Review how `source` and `tagged`/`target` are set
- Set up readme and publish
- macOS compatibility
    - Will need Color typealias for NSColor
