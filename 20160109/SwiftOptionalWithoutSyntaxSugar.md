slidenumbers: true
autoscale: true

# [fit] 構文糖衣なしで<br>Swiftのオプショナルを<br>使うとどうなるか？

<br>
### 2016年1月9日
### 藤本尚邦 / Cocoa勉強会(関東) #76

---
# 自己紹介

- 藤本尚邦 (@fhisa)
- [https://github.com/fhisa](https://github.com/fhisa)
- フリーランスプログラマー
- RubyCocoaフレームワーク原作者
- Mac開発歴、薄く長く約25年
- iOS開発歴、約1年

![](https://farm3.staticflickr.com/2949/15476722862_40e6f37f4f_z_d.jpg)

---
#Agenda

- オプショナルおさらい
- 変数の宣言
- 構文糖衣なしでオプショナル
- オプショナル使いこなしの注意点
- まとめ

---
#オプショナルおさらい

普通の型に"`?`"または"`!`"の１文字を付けて型宣言するとオプショナルになります。見た目はそれだけの違いですが、この２つは全く別の型です。<br>

~~~swift
var absolutelyInt: Int // Int型
~~~

~~~swift
var maybeInt: Int?  // Optional<Int>型
var probablyInt: Int!  // 暗黙のOptional<Int>型
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

**豊富な構文糖衣(Syntax Sugar)**を持っている。

オプショナルが他の`enum`で定義された型と違うのはこの一点です。

~~~swift
var maybeArray: [Int]? // Optional Type
var probablyArray: [Int]! // Implicitly Unwrapped Optional Type

if let array = maybeArray { ... } else { ... } // Optional Binding
let x = maybeArray?.count  // Optional Chaining
let x = maybeArray!  // Forced Unwrapping
let x = probablyArray.count   // Implicitly Forced Unwrapping
let x = maybeArray ?? [1,2,3]  // Nil Coalescing Operator
~~~

---
#構文糖衣なしでオプショナル

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

Without Syntax-Sugar:<br>

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

Without Syntax-Sugar:<br>

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

Without Syntax-Sugar:<br>

~~~swift
let x = ({ Void -> Optional<Int> in
    switch maybeArray {
    case .None: return .None
    case .Some(let array): return array.count
    }
})()
~~~

---
#Forced Unwrapping

~~~swift
let x = maybeArray!  // Forced Unwrapping
~~~

Without Syntax-Sugar:<br>

~~~swift
let x = ({ Void -> Int in
    switch maybeArray {
    case .None: fatalError("unexpectedly found nil ...")
    case .Some(let array): return array.count
    }
})()
~~~

---
#Nil Coalescing Operator

~~~swift
let x = maybeArray ?? [1,2,3]  // Nil Coalescing Operator
~~~

Without Syntax-Sugar:<br>

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
- 強制アンラップ・キャストは値がnilならバグのときのみ使う
- "`?`"や"`??`"を積極的に使うとコードの可読性が増す

~~~swift
if let delegate = delegate { delegate.smoeMethod() } // 冗長
delegate?.someMethod() // 簡潔・可読性良し
~~~

^
IBアウトレットが"!"付き型で宣言されている理由:
インスタンス生成時には値が不定なのでオプショナル型にする必要があるが
ビューコントローラがリソースからロード完了した時点では初期化されていて
nilでないことがほぼ自明だから

^
例えばストーリボードからビューコントローラのインスタンスを得る場合など、
名前のタイポなどのバグがなくリソースも正しく設定されていれば、
正しいインスタンスが返ってくるはず。
なので as! で強制キャストすればよい。それで落ちたらそれはバグ。
結果の値はオプショナルにする必要がない。

---
#まとめ

- 普通の型とオプショナル型は見た目以上に異なる
- オプショナルは`enum`で定義された単なる型
- Swiftプログラミングではオプショナルが頻出
- 構文糖衣なしでのオプショナルのプログラムは苦痛
- だからたくさん構文糖衣があるんだよ
- オプショナルをきちんと理解して良いSwiftプログラムを書こう

---
# 参考文献

- [The Swift Programming Language (Swift 2.1) https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/)

---
# [fit] **Thank you!**
![](https://farm3.staticflickr.com/2949/15476722862_40e6f37f4f_z_d.jpg)

### 2016年1月9日
### 藤本尚邦 / Cocoa勉強会(関東) #76
