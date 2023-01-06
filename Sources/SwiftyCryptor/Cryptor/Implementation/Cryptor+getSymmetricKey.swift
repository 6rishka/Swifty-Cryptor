import Foundation
import SwiftKeychainWrapper
import CryptoKit

extension Cryptor {
    func getSymmetricKey(ofName keyName: String) -> SymmetricKey? {
        guard let encryptionKeyData = KeychainWrapper.standard.data(forKey: keyName) else { return nil }
        return SymmetricKey(data: encryptionKeyData)
    }
}
    
