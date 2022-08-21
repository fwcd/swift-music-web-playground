struct MidiMessage: Hashable {
    let status: UInt8
    let data1: UInt8
    let data2: UInt8

    var statusKind: StatusKind? {
        StatusKind(rawValue: status / 16)
    }

    enum StatusKind: UInt8, Hashable {
        case noteOff = 0x8
        case noteOn = 0x9
        case polyphonicAftertouch = 0xa
        case controlChange = 0xb
        case programChange = 0xc
        case channelAftertouch = 0xd
        case pitchWheel = 0xe
    }
}
