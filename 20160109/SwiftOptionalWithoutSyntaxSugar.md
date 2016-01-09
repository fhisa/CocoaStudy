slidenumbers: true
autoscale: true

# [fit] 糖衣構文なしで<br>Swiftのオプショナルを<br>使うとどうなるか？

<br>
### 2016年1月9日
### 藤本尚邦 / Cocoa勉強会(関東) #76

---
# 自己紹介

- 藤本尚邦 (@fhisa)
- [https://github.com/fhisa](https://github.com/fhisa)
- フリーランスプログラマー
- 主な作品: [RubyCocoa](https://github.com/rubycocoa/rubycocoa), [SwiftyLayout](https://github.com/fhisa/SwiftyLayout)
- Mac開発歴、薄く長く約25年
- iOS開発歴、約1年

![](https://farm3.staticflickr.com/2949/15476722862_40e6f37f4f_z_d.jpg)

---
#Agenda

- オプショナルおさらい
- 糖衣構文なしでオプショナル
- オプショナル使いこなしの注意点
- まとめ

---
#オプショナルおさらい

普通の型に"`?`"または"`!`"の１文字を付けて型宣言するとオプショナルになります。見た目はたった１文字の違いですが、普通の型とオプショナル型はまったくの別物です。

~~~swift
var absolutelyInt: Int // 普通の型
~~~

~~~swift
var maybeInt: Int?  // オプショナル型
var probablyInt: Int!  // 暗黙のオプショナル型
~~~

---
#オプショナルおさらい

オプショナルはおおよそ以下のように定義された普通の `enum` です[^1]:

~~~swift
enum Optional<Wrapped> {
    case None
    case Some(Wrapped)
}
~~~

[^1]:この発表で不要な情報は省いています

^
"The Swift Programming Language"の"Swift Tour"の Generics について説明しているところで、
enum の Generics の例として、Optional もどきが取り上げられています。

---
#オプショナルおさらい

オプショナルが他の`enum`で定義された型と違うのは
**豊富な糖衣構文[^2]**を持っている。この一点です。

~~~swift
var maybeArray: [Int]? // Optional Type
var probablyArray: [Int]! // Implicitly Unwrapped Optional Type
if let array = maybeArray { ... } else { ... } // Optional Binding
let x = maybeArray?.count  // Optional Chaining
let x = maybeArray!  // Forced Unwrapping
let x = probablyArray.count   // Implicitly Forced Unwrapping
let x = maybeArray ?? [1,2,3]  // Nil Coalescing Operator
let x = someObject as? [Int]  // Type Cast Operator
let x = someObject as! [Int]  // Forced Type Cast Operator
~~~

[^2]:英語では Syntax Sugar あるいは Syntactic Sugar

---
#糖衣構文なしでオプショナル

- 変数の宣言
- Optional Binding
- Optional Chaining
- Forced Unwrapping
- Nil Coalescing Operator

---
#変数の宣言

~~~swift
var maybeInt: Int?
var maybeArray: [Int]?
~~~

糖衣構文なしだと<br>

~~~swift
var maybeInt: Optional<Int>
var maybeArray: Optional<Array<Int>>
~~~

---
#Optional Binding

~~~swift
if let array = maybeArray {
    IF-CLAUSE
} else {
    ELSE-CLAUSE
}
~~~

糖衣構文なしだと<br>

~~~swift
switch maybeArray {
case .Some(let array):
    IF-CLAUSE
case .None:
    ELSE-CLAUSE
}
~~~

---
#Optional Chaining

~~~swift
let x = maybeArray?.count  // Optional Chaining
~~~

糖衣構文なしだと<br>

~~~swift
let x = ({ Void -> Optional<Int> in
    switch maybeArray {
    case .None: return .None
    case .Some(let array): return array.count
    }
})()
~~~

^
maybeArrayは無名関数の引数にするのもありです。
countも引数にしたかったのですが、インスタンスメソッドを
値として扱う方法がわかりませんでした(調べる時間がなかった)

---
#Forced Unwrapping

~~~swift
let x = maybeArray!  // Forced Unwrapping
~~~

糖衣構文なしだと<br>

~~~swift
let x = ({ Void -> Int in
    switch maybeArray {
    case .None: fatalError("unexpectedly found nil ...")
    case .Some(let array): return array
    }
})()
~~~

---
#Nil Coalescing Operator

~~~swift
let x = maybeArray ?? [1,2,3]  // Nil Coalescing Operator
~~~

糖衣構文なしだと<br>

~~~swift
let x = ({ (arg:[Int]) -> [Int] in
    switch maybeArray {
    case .None: return arg
    case .Some(let array): return array
    }
})([1, 2, 3])
~~~

---
#オプショナル使いこなしの注意点

- "`?`"付きで型宣言するのが基本
- "`!`"付き型宣言は明確な理由がなければ使わない
- 強制アンラップ・キャストは、値がnilならバグのときのみ使う
- "`?`"や"`??`"を積極的に使うとコードの可読性が増す

~~~swift
if let delegate = delegate { delegate.someMethod() } // 冗長
delegate?.someMethod() // 簡潔・可読性良し
~~~

^
IBアウトレットが"!"付き型で宣言されている理由:
- インスタンス生成時には値が不定なのでオプショナル型にする必要がある
- プログラマはインターフェースビルダで接続することにより初期化している
- ビューコントローラがリソースからロード完了した時点で初期化されていることは自明
- 初期化されていなければバグ(接続ミス、名前変更など)なので落とした方がいい

^
as! の使いどころ:
- 例えばストーリボードからビューコントローラのインスタンスを得る場合
- プグラム内でストーリーボードのファイル名、インスタンス化のIDなどは文字列で指定する
- ファイル名・ID名が間違っていてロードできない場合nilを返す
- それは実質プログラムのバグ(名前を間違えている)なので落とした方がいい

---
#まとめ

- 普通の型とオプショナル型は見た目以上に異なる
- オプショナルは`enum`で定義された単なる型
- Swiftプログラミングではオプショナルが重要
- 糖衣構文なしでのオプショナルのプログラムは地獄
- だからたくさん糖衣構文があるんだよ
- オプショナルをきちんと理解して良いSwiftプログラムを書こう

---
# 参考文献

- [The Swift Programming Language (Swift 2.1) https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/)

---
# [fit] **Thank you!**
![](https://farm3.staticflickr.com/2949/15476722862_40e6f37f4f_z_d.jpg)

### 2016年1月9日
### 藤本尚邦 / Cocoa勉強会(関東) #76
