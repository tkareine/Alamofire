import Alamofire
import XCTest

class SSLCertificateValidationTestCase: XCTestCase {
    func testSSLCertificateCommonNameValidation() {
        let URL = "https://dwellingofduels.net/"  // had to be some unfortunate site to serve as an example, sorry

        let requestHeadExpectation = expectationWithDescription("HEAD \(URL)")

        Alamofire.request(.HEAD, URL).response { (request, response, _, error) in
            requestHeadExpectation.fulfill()

            XCTAssertNotNil(request, "request should not be nil")
            XCTAssertNil(response, "response should be nil")
            XCTAssertNotNil(error, "error should not be nil")
            XCTAssertEqual(error!.code, NSURLErrorServerCertificateUntrusted, "error should be NSURLErrorDomain Code -1202 'The operation couldn’t be completed'")
        }

        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
}
