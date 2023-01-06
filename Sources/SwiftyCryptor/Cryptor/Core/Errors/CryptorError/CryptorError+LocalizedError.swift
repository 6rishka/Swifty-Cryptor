import Foundation

extension CryptorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .encodingError(let fromTo, let encoding):
            return "Could not encode \(fromTo) using \(encoding)"
        case .encryptionError(let encryptionType, let cipher):
            return "Could not encrypt \(encryptionType) using \(cipher)"
        case .decryptionError(let decryptionType, let cipher):
            return "Could not encrypt \(decryptionType) using \(cipher)"
        case .decodingError(let fromTo, let encoding):
            return "Could not decode \(fromTo) using \(encoding)"
        case .encryptionKeyMissing(let keyLocation):
            return "Could not find encryption key in \(keyLocation)"
        }
    }
}
