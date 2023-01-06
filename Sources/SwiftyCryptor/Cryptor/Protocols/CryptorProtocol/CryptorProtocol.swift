import Foundation
import CryptoKit

public protocol CryptorProtocol {
    func encrypt(value: String, with keyName: String) throws -> String
    func decrypt(value: String, with keyName: String) throws -> String
}
