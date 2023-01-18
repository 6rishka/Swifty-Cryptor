# Swifty-Cryptor

SwiftyCryptor is an encryption/decryption library for iOS applications, that helps you securely encrypt/decrypt the data.

SwiftyCryptor delivers a secure data encryption/decryption features contained inside the `Cryptor` class which provides an easy-to-use interface (defined in `CryptorProtocol`) for encrypting and decrypting the data.

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

- `main` branch keeps the newest major - stable release.
- `stable` branch keeps the newest minor - stable release.
- `beta` branch keeps the newest minor - beta release.

## Installation

#### Swift Package Manager

- In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency.
- Paste the package repository URL `https://github.com/grikshka/Swifty-Cryptor` and click Next.
- For Rules, select Version - Up to Next Major - `1.0.0`.
- Select your target projects and click Finish.

#### Swift Package

```
.package(name: "SwiftyCryptor", url: "https://github.com/grikshka/Swifty-Cryptor/", from: "1.0.0")
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

## Development

### Release strategy

#### Resolving the latest version number

- If the latest release of this library is a `stable release` with a version number `X¹.X².X³` then the latest version number of this library is the `X¹.X².X³`.
- If the latest release of this library is a `beta release` with a version number `betaX¹.X².X³-Xⁿ` then the latest version number of this library is the `X¹.X².X³` part of it.
- (Rare case) It may also happen that there is another release of this library being in active development but it does not have a beta or a stable release yet - lets call such a release a `pre release`. If there is one or more `pre releases`, each of them should be developed in a separate branch named `vX¹.X².X³` where `X¹.X².X³` is the version number of the pre release. In this case, the latest version number of the library is a version number of the pre release with the highest `X¹.X².X³` number.

#### Establishing the next version number

- If the changes you want to apply are considered minor - increment the third section of the latest version number by 1. So if the latest version number of the library is `X¹.X².X³`, your version number will be `X¹.X².X³+1`
- If the changes you want to apply are considered major - increment the second section of the latest version number by 1 and set the next parts of the version number to 0. So if the latest version number of the library is `X¹.X².X³`, your version number will be `X¹.X²+1.0`
- If the changes you want to apply drastically change the way the library works - increment the first section of the latest version number by 1 and set the next parts of the version number to 0. So if the latest version number of the library is `X¹.X².X³`, your version number will be `X¹+1.0.0`

#### Preparing a new release

- Branch out from the `stable` branch and create a new branch named `vX¹.X².X³` where `X¹.X².X³` is a version number of your new release.
- Apply all the changes and commit them to the `vX¹.X².X³` branch that you created.
- Create a Pull Request from the `vX¹.X².X³` branch that you created, to the `beta` branch.
  - (Only if the latest release was a `beta release` or a `pre release`) Before merging the Pull Request you must ensure that the latest release already has a `stable release`.
  - (Only if the latest release was a `beta release` or a `pre release`) If the latest release does not have a stable release yet, then you have to wait for it before merging your Pull Request.
  - (Only if the latest release was a `beta release` or a `pre release`) If the previous release does have a stable release now, then merge a `stable` branch into the `vX¹.X².X³` branch that you created and resolve the merge conflicts if there are any.

#### Beta testing (optional)

- Once your Pull Request is merged, create a new beta release from the `beta` branch and name it `betaX¹.X².X³-0`
- If there will be any issues with your beta release, then repeat following steps until you resolve them (otherwise skip this step):
  - Apply fixes and push them to the `vX¹.X².X³` branch that you created.
  - Create a Pull Request from the `vX¹.X².X³` branch that you created, to the `beta` branch.
  - Once your Pull Request is merged, create a new beta release from the `beta` branch and name it `betaX¹.X².X³-Xⁿ` where the fourth section of the release number - `Xⁿ` - should be incremented from your previous beta release.

#### Making a new release

- Once the `beta` branch contains the working version of the library with all your changes applied to it, create a Pull Request from the `beta` branch to the `stable` branch.
- Once your Pull Request is merged, create a new release from the `stable` branch and name it `X¹.X².X³` where `X¹.X².X³` is a version number of your release.
