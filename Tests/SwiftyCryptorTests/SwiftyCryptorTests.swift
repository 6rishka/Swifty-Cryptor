    import XCTest
    @testable import SwiftyCryptor

    final class SwiftyCryptorTests: XCTestCase {
        func testExample() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.
            let cryptor: CryptorProtocol = Cryptor()
            let secret = "secret"
            do {
                // Encrypt plain text
                let encryptedSecret = try cryptor.encrypt(value: secret)
                
                // Decrypt encrypted text
                let decryptedSecret = try cryptor.decrypt(value: encryptedSecret)
                XCTAssertEqual(secret, decryptedSecret)
            } catch {
                // Handle CryptorError
                XCTAssertTrue(false)
            }
        }
    }
