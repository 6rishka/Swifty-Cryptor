import Foundation

public extension CryptorProtocol {
    private static var globalEncryptionKeyName: String {
        return "GlobalEncryptionKey"
    }
    
    func encrypt(value: String) throws -> String {
        return try encrypt(value: value, with: Self.globalEncryptionKeyName)
    }
    
    func decrypt(value: String) throws -> String {
        return try decrypt(value: value, with: Self.globalEncryptionKeyName)
    }
}
