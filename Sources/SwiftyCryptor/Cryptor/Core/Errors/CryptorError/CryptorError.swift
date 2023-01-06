import Foundation

public enum CryptorError: Error {
    case encodingError(fromTo: String, encoding: String)
    case encryptionError(fromTo: String, cipher: String)
    case decryptionError(fromTo: String, cipher: String)
    case decodingError(fromTo: String, encoding: String)
    case encryptionKeyMissing(keyLocation: String)
}
