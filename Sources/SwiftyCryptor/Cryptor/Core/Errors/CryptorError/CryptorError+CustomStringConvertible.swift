import Foundation

extension CryptorError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .encodingError:
            return "Connection Error"
        case .encryptionError:
            return "Encryption Error"
        case .decryptionError:
            return "Decryption Error"
        case .decodingError:
            return "Decoding Error"
        case .encryptionKeyMissing:
            return "Encryption Key Missing"
        }
    }
}
