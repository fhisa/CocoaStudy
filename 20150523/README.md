# テスティングフレームワークに入門してみた - Swift編

[「テスティングフレームワークに入門してみた - Swift編」slideshare](http://www.slideshare.net/hisakunifujimoto/testing-framework-for-swift)

## SampleApp

XCTestとQuickの動作確認・資料作成用に作ったiOSアプリのプロジェクトです。３つのターゲットがあります。

* SampleApp - プロジェクト生成時のままで中身は空
* SampleAppTests - XCTestで書いたNSDateクラスの単体テスト
* SampleAppSpec - [Quick](https://github.com/Quick/Quick)で書いたNSDateクラスの振舞い記述

Swift用のテスティングフレームワークに入門することが目的のプロジェクトなので、下の２つのターゲットが肝となっています。
