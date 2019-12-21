
//MARK: Structs to parse data from JSON

import Foundation

struct CurrentPrice: Decodable {
    var bpi: BPI
}

struct BPI: Decodable {
    var USD: Currency
    var GBP: Currency
    var EUR: Currency
}

struct Currency: Decodable {
    var description: String?
    var rate_float: Double?
}

// MARK: KZT

struct CurrentPriceKZT: Decodable {
    var bpi: BPIkzt
}
struct BPIkzt: Decodable {
    var KZT: Currency
}

// MARK: Historical

struct Historical: Decodable {
    var bpi: [String:Double]
}

// MARK: Transactions

struct Transaction: Decodable {
    var date : String
    var tid : Int
    var price : String
    var type: Int
    var amount : String
}

