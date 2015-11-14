//: # Swiftによる関数型プログラミング超入門

//: ## 総和・総乗

//: ### ループと代入を使った手続き的なプログラム

func sum_l(n: Int) -> Int {
    var accumulator = 0
    for i in 1...n { accumulator += i }
    return accumulator
}

func prod_l(n: Int) -> Int {
    var accumulator = 1
    for i in 1...n { accumulator *= i }
    return accumulator
}

sum_l(10)
prod_l(10)

//: ### 再帰呼出を使ったFPの香り漂うプログラム

func sum_r(n: Int) -> Int {
    return n == 0 ? 0 : n + sum_r(n - 1)
}

func prod_r(n: Int) -> Int {
    return n == 0 ? 1 : n * prod_r(n - 1)
}

sum_r(10)
prod_r(10)

//: ## 総和・総乗の抽象化

//: ### 総和・総乗のパターンを抽象化した関数 reduce

typealias IntCombinator = (Int, Int) -> Int

func reduce_r(n: Int, initial: Int, combine: IntCombinator) -> Int
{
    if n == 0 {
        return initial
    } else {
        return combine(
            n,
            reduce_r(n - 1, initial: initial, combine: combine))
    }
}

//: ### 関数reduceを使って総和・総乗を計算してみよう:

//: ふたつの整数の和算・乗算をする関数を定義:
func add2(n: Int, m: Int) -> Int { return n + m }
func mul2(n: Int, m: Int) -> Int { return n * m }

reduce_r(10, initial: 0, combine: add2)
reduce_r(10, initial: 1, combine: mul2)

//: 無名関数(関数リテラル)を直接渡す:
reduce_r(10, initial: 0, combine: { $0 + $1 })
reduce_r(10, initial: 1, combine: { $0 * $1 })

//: Ruby風シンタックスシュガー:
reduce_r(10, initial: 0) { $0 + $1 }
reduce_r(10, initial: 1) { $0 * $1 }

//: Swiftでは `+` や `-` も関数なので引数に渡せます:
reduce_r(10, initial: 0, combine: +)
reduce_r(10, initial: 1, combine: *)


//: (注) 上で定義した sum_r, prod_r, reduce_r は、nの値の大きさに比例してスタックを食い潰す実装なので、
//: 現実世界のプログラムで使ってはいけません。
//: SequenceTypeプロトコルのreduceを使うようにしましょう！

(1...10).reduce(0, combine: +)
(1...10).reduce(1, combine: *)


//: ## SequenceTypeの使用例

struct Person {
    let name: String
    let age: Int
    let sex: Sex
    enum Sex { case Male, Female, Others }
}

let BABYMETAL: [Person] = [
    Person(name: "中元すず香", age: 17, sex: .Female),
    Person(name: "菊地最愛", age: 16, sex: .Female),
    Person(name: "水野由結", age: 16, sex: .Female),
    Person(name: "青山英樹", age: 29, sex: .Male),
    Person(name: "BOH", age: 33, sex: .Male),
    Person(name: "大村孝佳", age: 31, sex: .Male),
    Person(name: "藤岡幹大", age: 34, sex: .Male),
]

//: BABYMETALの女性の名前
BABYMETAL
    .filter { $0.sex == .Female }
    .map { $0.name }

//: BABYMETAL全員の平均年齢
Float(BABYMETAL
    .map { $0.age }
    .reduce(0, combine: +)) / Float(BABYMETAL.count)
