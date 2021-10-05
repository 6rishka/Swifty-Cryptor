# Swifty-Cryptor
SwiftyCryptor is an encryption/decryption library for iOS applications, that helps you securely encrypt/decrypt the data.

SwiftyCryptor delivers a secure data encryption/decryption features contained inside the ```Cryptor``` class which provides an easy-to-use interface (defined in ```CryptorProtocol```) for encrypting and decrypting the data.

SwiftyCryptor uses ChaCha20-Poly1305 cipher with a symmetric key of size 256 bits, that is securely stored in Keychain.

## Language
Swift

## Supported Platforms

- iOS

## Supported Platforms Versions

#### iOS
```
iOS 13.0 +
```

## Branches & Releases

- ``` main ``` branch keeps the newest major - stable release.
- ``` stable ``` branch keeps the newest minor - stable release.
- ``` beta ``` branch keeps the newest minor - beta release.

## Installation

#### Swift Package Manager
- In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency.
- Paste the package repository URL ```https://github.com/schemabuoi/Swifty-Cryptor``` and click Next.
- For Rules, select Version - Up to Next Major - ``` 1.0.0 ```.
- Select your target projects and click Finish.

#### Swift Package
```
.package(name: "SwiftyCryptor", url: "https://github.com/schemabuoi/Swifty-Cryptor/", from: "1.0.0")
```

## Dependencies
- [SwiftKeychainWrapper](https://github.com/jrendel/SwiftKeychainWrapper)

## Usage
```swift
import SwiftyCryptor

let cryptor: CryptorProtocol = Cryptor()
let secret = "secret"
do {
    // Encrypt plain text
    let encryptedSecret = try cryptor.encrypt(value: secret)
    
    // Decrypt encrypted text
    let decryptedSecret = try cryptor.decrypt(value: encryptedSecret)
} catch let error as CryptorError {
    // Handle CryptorError
} catch let error {
    // Fallback error
}
```
