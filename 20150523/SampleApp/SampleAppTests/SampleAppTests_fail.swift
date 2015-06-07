import Foundation
import XCTest

class NSDateTestsFail: XCTestCase {

    var 今: NSDate!
    var １分後: NSDate!

    override func setUp() {
        super.setUp()
        今 = NSDate()
        １分後 = NSDate(timeInterval: 60.0, sinceDate: 今)
    }

    func test_等値演算子() {
        XCTAssertTrue(今 == 今)
        XCTAssertTrue(今 == １分後)
    }
}


class ArrayTestsFail: XCTestCase {

    var 空の配列: [AnyObject] = []
    var 要素１つの配列: [AnyObject] = ["hello"]

    func test_count() {
        XCTAssertEqual(count(空の配列), 0)
        XCTAssertEqual(count(要素１つの配列), 2)
    }
}