//MARK: Objects for saving in Realm DB

import Foundation
import RealmSwift

class BPIcached: Object {
    @objc dynamic var name = ""
    @objc dynamic var price: Double = 0
}

class MonthsCached: Object {
    @objc dynamic var price: Double = 0
}

class WeeksCached: Object {
    @objc dynamic var price: Double = 0
}

class DaysCached: Object {
    @objc dynamic var price: Double = 0
}

class xAxisYearCached: Object {
    @objc dynamic var date: String = ""
}

class xAxisMonthCached: Object {
    @objc dynamic var date: String = ""
}

class xAxisDayCached: Object {
    @objc dynamic var date: String = ""
}

class transactionCached: Object {
    @objc dynamic var date = ""
    @objc dynamic var tid = 0
    @objc dynamic var price = ""
    @objc dynamic var type = 0
    @objc dynamic var amount = ""
}


