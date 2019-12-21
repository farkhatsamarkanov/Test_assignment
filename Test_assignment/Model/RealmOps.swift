//MARK: Realm database methods class

import Foundation
import RealmSwift
class RealmOps {
    
    // MARK: Save to Realm functions
    
    func saveXAxisDay (array : [String]) {
        do {
            let realm = try! Realm()
            try realm.write {
                let result = realm.objects(xAxisDayCached.self)
                realm.delete(result)
                let xAxisesDayRealm = xAxisDayConverter(arrayOfDates: array)
                for i in xAxisesDayRealm {
                    realm.add(i)
                }
            }
        } catch {
            print("Error while writing to Realm: \(error)")
        }
    }
    
    func saveXAxisMonth (array : [String]) {
        do {
            let realm = try! Realm()
            try realm.write {
                let result = realm.objects(xAxisMonthCached.self)
                realm.delete(result)
                let xAxisesMonthRealm = xAxisMonthConverter(arrayOfDates: array)
                for i in xAxisesMonthRealm {
                    realm.add(i)
                }
            }
        } catch {
            print("Error while writing to Realm: \(error)")
        }
    }
    
    func saveXAxisYear (array : [String]) {
        do {
            let realm = try! Realm()
            try realm.write {
                let result = realm.objects(xAxisYearCached.self)
                realm.delete(result)
                let xAxisesYearRealm = xAxisYearConverter(arrayOfDates: array)
                for i in xAxisesYearRealm {
                    realm.add(i)
                }
            }
        } catch {
            print("Error while writing to Realm: \(error)")
        }
    }
    
    func saveDayAvgPrices (array : [Double]) {
        do {
            let realm = try! Realm()
            try realm.write {
                let result = realm.objects(DaysCached.self)
                realm.delete(result)
                let daysAvgRealm = daysAvgConverter(arrayOfPrices: array)
                for i in daysAvgRealm {
                    realm.add(i)
                }
            }
        } catch {
            print("Error while writing to Realm: \(error)")
        }
    }
    
    func saveWeekAvgPrices (array : [Double]) {
        do {
            let realm = try! Realm()
            try realm.write {
                let result = realm.objects(WeeksCached.self)
                realm.delete(result)
                let weeksAvgRealm = weeksAvgConverter(arrayOfPrices: array)
                for i in weeksAvgRealm {
                    realm.add(i)
                }
            }
        } catch {
            print("Error while writing to Realm: \(error)")
        }
    }
    
    func saveMonthAvgPrices (array : [Double]) {
        do {
            let realm = try! Realm()
            try realm.write {
                let result = realm.objects(MonthsCached.self)
                realm.delete(result)
                let monthsAvgRealm = monthsAvgConverter(arrayOfPrices: array)
                for i in monthsAvgRealm {
                    realm.add(i)
                }
            }
        } catch {
            print("Error while writing to Realm: \(error)")
        }
    }
    
    func saveBPI(bpiDict : [String:Double]) {
        do {
            let realm = try! Realm()
            
            try realm.write {
                let result = realm.objects(BPIcached.self)
                
                realm.delete(result)
                
                
                let bpisRealm = bpiConverter(webResponseDict: bpiDict)
                for i in bpisRealm {
                    realm.add(i)
                }
            }
        } catch {
            print("Error while writing to Realm: \(error)")
        }
    }
    
    func saveTransactions (transArray : [Transaction]) {
        do {
            let realm = try! Realm()
            try realm.write {
                let result = realm.objects(transactionCached.self)
                realm.delete(result)
                let transactionsInRealm = transactionConverter(arrayOfTransactions: transArray)
                for i in transactionsInRealm {
                    realm.add(i)
                }
            }
        } catch {
            print("Error while writing to Realm: \(error)")
        }
    }
    
    // MARK: Read from Realm functions
    
    func readXAxisDay() -> [String] {
        var bpis: [String] = []
        do {
            let realm = try Realm()
            let result = realm.objects(xAxisDayCached.self)
            bpis = reversedXAxisDayConverter(listOfCachedData: result)
            
        } catch {
            print("Error while reading data from Realm: \(error)")
        }
        return bpis
    }
    
    func readXAxisMonth() -> [String] {
        var bpis: [String] = []
        do {
            let realm = try Realm()
            let result = realm.objects(xAxisMonthCached.self)
            bpis = reversedXAxisMonthConverter(listOfCachedData: result)
            
        } catch {
            print("Error while reading data from Realm: \(error)")
        }
        return bpis
    }
    
    func readXAxisYear() -> [String] {
        var bpis: [String] = []
        do {
            let realm = try Realm()
            let result = realm.objects(xAxisYearCached.self)
            bpis = reversedXAxisYearConverter(listOfCachedData: result)
            
        } catch {
            print("Error while reading data from Realm: \(error)")
        }
        return bpis
    }
    
    func readDaysAvgPrices() -> [Double] {
        var bpis: [Double] = []
        do {
            let realm = try Realm()
            let result = realm.objects(DaysCached.self)
            bpis = reversedDaysAvgConverter(listOfCachedData: result)
            
        } catch {
            print("Error while reading data from Realm: \(error)")
        }
        return bpis
    }
    
    func readWeeksAvgPrices() -> [Double] {
        var bpis: [Double] = []
        do {
            let realm = try Realm()
            let result = realm.objects(WeeksCached.self)
            bpis = reversedWeeksAvgConverter(listOfCachedData: result)
            
        } catch {
            print("Error while reading data from Realm: \(error)")
        }
        return bpis
    }
    
    func readMonthsAvgPrices() -> [Double] {
        var bpis: [Double] = []
        do {
            let realm = try Realm()
            let result = realm.objects(MonthsCached.self)
            bpis = reversedMonthsAvgConverter(listOfCachedData: result)
            
        } catch {
            print("Error while reading data from Realm: \(error)")
        }
        return bpis
    }
    
    func readBPI() -> [BPIcached] {
        var bpis: [BPIcached] = []
        do {
            let realm = try Realm()
            let result = realm.objects(BPIcached.self)
            
            for item in result {
                let bpiRealm = item
                bpis.append(bpiRealm)
            }
            
        } catch {
            print("Error while reading data from Realm: \(error)")
        }
        return bpis
    }
    
    func readTransactions() -> [transactionCached] {
        var transactions: [transactionCached] = []
        do {
            let realm = try Realm()
            let result = realm.objects(transactionCached.self)
            for transaction in result {
                let transModel = transaction
                transactions.append(transModel)
            }
        } catch {
            print("Error while reading data from Realm: \(error)")
        }
        return transactions
    }
    
    // MARK: Realm converter functions
    
    func xAxisYearConverter (arrayOfDates: [String]) -> [xAxisYearCached] {
        var xAxisesYearRealm: [xAxisYearCached] = []
        for date in arrayOfDates {
            let xAxisYearRealm = xAxisYearCached()
            xAxisYearRealm.date = date
            xAxisesYearRealm.append(xAxisYearRealm)
        }
        return xAxisesYearRealm
    }
    
    func xAxisMonthConverter (arrayOfDates: [String]) -> [xAxisMonthCached] {
        var xAxisesMonthRealm: [xAxisMonthCached] = []
        for date in arrayOfDates {
            let xAxisMonthRealm = xAxisMonthCached()
            xAxisMonthRealm.date = date
            xAxisesMonthRealm.append(xAxisMonthRealm)
        }
        return xAxisesMonthRealm
    }
    
    func xAxisDayConverter (arrayOfDates: [String]) -> [xAxisDayCached] {
        var xAxisesDayRealm: [xAxisDayCached] = []
        for date in arrayOfDates {
            let xAxisDayRealm = xAxisDayCached()
            xAxisDayRealm.date = date
            xAxisesDayRealm.append(xAxisDayRealm)
        }
        return xAxisesDayRealm
    }
    
    func daysAvgConverter (arrayOfPrices: [Double]) -> [DaysCached] {
        var daysAvgRealm: [DaysCached] = []
        for price in arrayOfPrices {
            let dayAvgRealm = DaysCached()
            dayAvgRealm.price = price
            daysAvgRealm.append(dayAvgRealm)
        }
        return daysAvgRealm
    }
    
    func weeksAvgConverter (arrayOfPrices: [Double]) -> [WeeksCached] {
        var weeksAvgRealm: [WeeksCached] = []
        for price in arrayOfPrices {
            let weekAvgRealm = WeeksCached()
            weekAvgRealm.price = price
            weeksAvgRealm.append(weekAvgRealm)
        }
        return weeksAvgRealm
    }
    
    func monthsAvgConverter (arrayOfPrices: [Double]) -> [MonthsCached] {
        var monthsAvgRealm: [MonthsCached] = []
        for price in arrayOfPrices {
            let monthAvgRealm = MonthsCached()
            monthAvgRealm.price = price
            monthsAvgRealm.append(monthAvgRealm)
        }
        return monthsAvgRealm
    }
    
    func bpiConverter (webResponseDict: [String:Double]) -> [BPIcached] {
        var bpisRealm: [BPIcached] = []
        for bpi in webResponseDict {
            let bpiRealm = BPIcached()
            bpiRealm.name = bpi.key
            bpiRealm.price = bpi.value
            bpisRealm.append(bpiRealm)
        }
        return bpisRealm
    }
    
    // MARK: Reversed realm converters
    
    func reversedXAxisYearConverter(listOfCachedData: Results<xAxisYearCached>) -> [String] {
        var bpisRealm: [String] = []
        for bpi in listOfCachedData {
            bpisRealm.append(bpi.date)
        }
        return bpisRealm
    }
    
    func reversedXAxisMonthConverter(listOfCachedData: Results<xAxisMonthCached>) -> [String] {
        var bpisRealm: [String] = []
        for bpi in listOfCachedData {
            bpisRealm.append(bpi.date)
        }
        return bpisRealm
    }
    
    func reversedXAxisDayConverter(listOfCachedData: Results<xAxisDayCached>) -> [String] {
        var bpisRealm: [String] = []
        for bpi in listOfCachedData {
            bpisRealm.append(bpi.date)
        }
        return bpisRealm
    }
    
    func reversedDaysAvgConverter (listOfCachedData: Results<DaysCached>) -> [Double] {
        var bpisRealm: [Double] = []
        for bpi in listOfCachedData {
            bpisRealm.append(bpi.price)
        }
        return bpisRealm
    }
    
    func reversedWeeksAvgConverter (listOfCachedData: Results<WeeksCached>) -> [Double] {
        var bpisRealm: [Double] = []
        for bpi in listOfCachedData {
            bpisRealm.append(bpi.price)
        }
        return bpisRealm
    }
    
    func reversedMonthsAvgConverter (listOfCachedData: Results<MonthsCached>) -> [Double] {
        var bpisRealm: [Double] = []
        for bpi in listOfCachedData {
            bpisRealm.append(bpi.price)
        }
        return bpisRealm
    }
    
    func transactionConverter (arrayOfTransactions: [Transaction]) -> [transactionCached] {
        var transactionsRealm: [transactionCached] = []
        for transaction in arrayOfTransactions {
            let transactionRealm = transactionCached()
            transactionRealm.date = transaction.date
            transactionRealm.tid = transaction.tid
            transactionRealm.price = transaction.price
            transactionRealm.type = transaction.type
            transactionRealm.amount = transaction.amount
            transactionsRealm.append(transactionRealm)
        }
        return transactionsRealm
    }
    
}


