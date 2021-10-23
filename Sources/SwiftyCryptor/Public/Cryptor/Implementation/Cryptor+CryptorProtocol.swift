//
//  Cryptor+CryptorProtocol.swift
//  SwiftyCryptor
//
//  Created by Greg Charyszczak on 13/09/2021.
//  Copyright © 2021 Greg Charyszczak. All rights reserved.
//
//    The MIT License (MIT)
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import Foundation
import CryptoKit
import SwiftKeychainWrapper

extension Cryptor: CryptorProtocol {
    public func encrypt(value: String, with keyName: String) throws -> String {
        let encryptionKey = SymmetricKey(size: encryptionKeySize)
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
        if let encryptionKeyData = KeychainWrapper.standard.data(forKey: keyName) {
            let encryptionKey = SymmetricKey(data: encryptionKeyData)
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
