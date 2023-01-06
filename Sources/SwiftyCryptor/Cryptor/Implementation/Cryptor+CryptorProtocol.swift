import Foundation
import CryptoKit
import SwiftKeychainWrapper

extension Cryptor: CryptorProtocol {
    public func encrypt(value: String, with keyName: String) throws -> String {
        let encryptionKey = getSymmetricKey(ofName: keyName) ?? SymmetricKey(size: encryptionKeySize)
        let encryptionKeyData = encryptionKey.withUnsafeBytes({ body in
            return Data(body)
        })
        if let valueData = value.data(using: stringEncoding) {
            if let sealedBox = try? ChaChaPoly.seal(valueData, using: encryptionKey) {
                let encryptedValue = sealedBox.combined.base64EncodedString()
                KeychainWrapper.standard.set(encryptionKeyData, forKey: keyName)
                return encryptedValue
            } else {
                throw CryptorError.encryptionError(fromTo: "Data to SealedBox", cipher: "ChaChaPoly")
            }
        } else {
            throw CryptorError.encodingError(fromTo: "String to Data", encoding: "\(stringEncoding)")
        }
    }
    
    public func decrypt(value: String, with keyName: String) throws -> String {
        if let encryptionKey = getSymmetricKey(ofName: keyName) {
            if let encryptedValue = Data(base64Encoded: value) {
                if let sealedBox = try? ChaChaPoly.SealedBox(combined: encryptedValue),
                   let decryptedData = try? ChaChaPoly.open(sealedBox, using: encryptionKey) {
                    if let decryptedValue = String(data: decryptedData, encoding: stringEncoding) {
                        return decryptedValue
                    } else {
                        throw CryptorError.decodingError(fromTo: "Data to String", encoding: "\(stringEncoding)")
                    }
                } else {
                    throw CryptorError.decryptionError(fromTo: "Data to SealedBox", cipher: "ChaChaPoly")
                }
            } else {
                throw CryptorError.decodingError(fromTo: "Data to String", encoding: "base64")
            }
        } else {
            throw CryptorError.encryptionKeyMissing(keyLocation: "Keychain")
        }
    }
}
