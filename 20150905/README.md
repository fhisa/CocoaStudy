# iOS/Macアプリ開発の<br>AutoLayoutプログラミング<br>について考えてみた

Cocoa勉強会(関東) #74 2015/09/05

## スライド



## サンプルアプリ

レイアウト制約に警告のないサンプル:
* [LayoutSampleWithoutCode](https://github.com/fhisa/CocoaStudy/tree/master/20150905/LayoutSampleWithoutCode) - ストーリーボードで制約を定義
* [LayoutSampleWithCode](https://github.com/fhisa/CocoaStudy/tree/master/20150905/LayoutSampleWithCode) - 素のNSLayoutConstraintで制約を定義
* [LayoutSampleWithFSC](https://github.com/fhisa/CocoaStudy/tree/master/20150905/LayoutSampleWithFSC) - FormulaStyleConstraint(後述)を使って制約を定義
* [LayoutSampleWithCartography](https://github.com/fhisa/CocoaStudy/tree/master/20150905/LayoutSampleWithCartography) - Cartography(後述)を使って制約を定義

レイアウト制約に理由不明の警告が発生するサンプル:
* [SquareSampleWithoutCode](https://github.com/fhisa/CocoaStudy/tree/master/20150905/SquareSampleWithoutCode) - ストーリーボードで制約を定義
* [SquareSampleWithFSC](https://github.com/fhisa/CocoaStudy/tree/master/20150905/SquareSampleWithFSC) - FormulaStyleConstraintを使ったプログラムで制約を定義

## FormulaStyleConstraint フレームワーク

レイアウト制約を数式のように定義できる機能を実装したSwift用のフレームワーク(自作)
https://github.com/fhisa/FormulaStyleConstraint

すでに誰かが作って公開していそうなアイディアだと思ったけど、作る楽しみを失いたくなかったので調べる前に自作してみた。

## Cartography フレームワーク

FormulaStyleConstraintと同様に、レイアウト制約を数式風に定義できる機能を実装したSwift用のフレームワーク
https://github.com/robb/Cartography

FormulaStyleConstraint を作ったあとに調べて見つけた似たような発想のフレームワーク。

### FormulaStyleConstraint と Cartography の相違

* FormulaStyleConstraintは、等式・不等式で制約を定義する機能のみでシンプル
* Cartographyは、ブロックの中に等式・不等式で制約を定義するDSLになっている
* Cartographyには、単純な制約の定義だけでなく、XcodeのGUIでできるような整列(align)などの拡張機能がある
* 名前が長過ぎでダサいのが前者、名前がシンプルでかっこいいのが後者
