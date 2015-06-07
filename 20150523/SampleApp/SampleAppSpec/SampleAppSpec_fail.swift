import Foundation
import Quick
import Nimble

class NSDateの仕様_FAIL: QuickSpec {

    override func spec() {

        describe("等値演算子") {
            context("今と１分後について") {
                var 今: NSDate!
                var １分後: NSDate!

                beforeEach {
                    今 = NSDate()
                    １分後 = NSDate(timeInterval: 60.0, sinceDate: 今)
                }

                it("今と今は等しい") {
                    expect(今 == 今).to(beTrue())
                }

                it("今と１分後は等しい") {
                    expect(今 == １分後).to(beTrue())
                }
            }
        }
    }
}


class 配列の仕様_FAIL: QuickSpec {

    override func spec() {

        describe("関数count") {
            var 配列: [AnyObject]!

            context("空の配列の場合") {
                beforeEach { 配列 = [] }
                it("要素数は0") {
                    expect(count(配列)).to(equal(0))
                }
            }

            context("１つの要素を持つ配列の場合") {
                beforeEach { 配列 = ["hello"] }
                it("要素数は2") {
                    expect(count(配列)).to(equal(2))
                }
            }
        }
    }
}
