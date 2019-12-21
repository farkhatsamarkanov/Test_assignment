//MARK: Class to provide First ViewController with data

import Foundation
class FirstScreenProvider {
    let networkDataFetcher = NetworkDataFetcher()
    let realmOps = RealmOps()
    var webResponseDict : [String:Double] = [:]
    var webResponseKeys : [String] = []
    var webResponseValues : [Double] = []
    var monthsArray : [Double] = []
    var weeksArray : [Double] = []
    var daysArray : [Double] = []
    var xAxisArrayYear : [String] = []
    var xAxisArrayMonth : [String] = []
    var xAxisArrayWeek : [String] = []
    let df = DateFormatter()
    let urlStringUSDEUR = "https://api.coindesk.com/v1/bpi/currentprice.json"
    let urlStringKZT = "https://api.coindesk.com/v1/bpi/currentprice/KZT.json"
    let userInfo = ["key":"value"]
    
    private var timer: Timer?
    
    private func sendNotification() {
        NotificationCenter.default.post(name: Constants.notificationName, object: nil, userInfo: userInfo)
    }
    
    func makeEndDate() -> String {
        let dayComp = DateComponents(day: -365)
        let date = Calendar.current.date(byAdding: dayComp, to: Date())
        self.df.dateFormat = "yyyy-MM-dd"
        if let resDate = date {
            let result = df.string(from: resDate)
            return result
        }
        else {
            return "Error making date"
        }
    }
    
    
    func makeURLtoHist() -> String {
        let currentDate = Date()
        self.df.dateFormat = "yyyy-MM-dd"
        let endURL = "\(df.string(from: currentDate))"
        
        let startURL = makeEndDate()
        let urlHist = "https://api.coindesk.com/v1/bpi/historical/close.json?start=\(startURL)&end=\(endURL)"
        
        return urlHist
    }
    
    func findAvgDays (arrayOfDoubles: [Double]) -> [Double] {
        var arrayDaily : [Double] = []
        for index in 358...((arrayOfDoubles.count)-1) {
            arrayDaily.append(arrayOfDoubles[index])
        }
        return arrayDaily
    }
    
    
    func findAvgWeeks (arrayOfDoubles: [Double]) -> [Double] {
        var arrayWeekly : [Double] = []
        
        var sum1w : Double = 0
        for index in 337...343 {
            sum1w += arrayOfDoubles[index]
        }
        arrayWeekly.append(Double(sum1w/7))
        
        var sum2w : Double = 0
        for index in 344...350 {
            sum2w += arrayOfDoubles[index]
        }
        arrayWeekly.append(Double(sum2w/7))
        
        var sum3w : Double = 0
        for index in 351...357 {
            sum3w += arrayOfDoubles[index]
        }
        arrayWeekly.append(Double(sum3w/7))
        
        var sum4w : Double = 0
        for index in 358...((arrayOfDoubles.count)-1) {
            sum4w += arrayOfDoubles[index]
        }
        arrayWeekly.append(Double(sum4w/7))
        return arrayWeekly
    }
    
    func findAvgMonths(arrayOfDoubles: [Double]) -> [Double] {
        var arrayOfMonthsAvg : [Double] = []
        
        var sum1m : Double = 0
        for index in 0...30 {
            sum1m += arrayOfDoubles[index]
        }
        arrayOfMonthsAvg.append(Double(sum1m/31))
        
        var sum2m : Double = 0
        for index in 31...58 {
            sum2m += arrayOfDoubles[index]
        }
        arrayOfMonthsAvg.append(Double(sum2m/28))
        
        var sum3m : Double = 0
        for index in 59...89 {
            sum3m += arrayOfDoubles[index]
        }
        arrayOfMonthsAvg.append(Double(sum3m/31))
        
        var sum4m : Double = 0
        for index in 90...119 {
            sum4m += arrayOfDoubles[index]
        }
        arrayOfMonthsAvg.append(Double(sum4m/30))
        
        var sum5m : Double = 0
        for index in 120...150 {
            sum5m += arrayOfDoubles[index]
        }
        arrayOfMonthsAvg.append(Double(sum5m/31))
        
        var sum6m : Double = 0
        for index in 151...180 {
            sum6m += arrayOfDoubles[index]
        }
        arrayOfMonthsAvg.append(Double(sum6m/30))
        
        var sum7m : Double = 0
        for index in 181...211 {
            sum7m += arrayOfDoubles[index]
        }
        arrayOfMonthsAvg.append(Double(sum7m/31))
        
        var sum8m : Double = 0
        for index in 212...242 {
            sum8m += arrayOfDoubles[index]
        }
        arrayOfMonthsAvg.append(Double(sum8m/31))
        
        var sum9m : Double = 0
        for index in 243...272 {
            sum9m += arrayOfDoubles[index]
        }
        arrayOfMonthsAvg.append(Double(sum9m/30))
        
        var sum10m : Double = 0
        for index in 273...303 {
            sum10m += arrayOfDoubles[index]
        }
        arrayOfMonthsAvg.append(Double(sum10m/31))
        
        var sum11m : Double = 0
        for index in 304...333 {
            sum11m += arrayOfDoubles[index]
        }
        arrayOfMonthsAvg.append(Double(sum11m/30))
        
        var sum12m : Double = 0
        for index in 334...((arrayOfDoubles.count)-1) {
            sum12m += arrayOfDoubles[index]
        }
        arrayOfMonthsAvg.append(Double(sum12m/31))
        return arrayOfMonthsAvg
    }
    
    func findAxisNamesWeek (arrayOfDates: [String]) -> [String] {
        var arrayDatesDaily : [String] = []
        for index in 358...((arrayOfDates.count)-1) {
            arrayDatesDaily.append(arrayOfDates[index])
        }
        return arrayDatesDaily
    }
    
    func findAxisNamesMonth (arrayOfDates: [String]) -> [String] {
        var arrayDatesWeekly : [String] = []
        for index in stride(from: 340, to: 362, by: 7) {
            var bufferString = arrayOfDates[index]
            bufferString.removeLast(3)
            bufferString.append(contentsOf: " Week \(((index-340)/7)+1)")
            arrayDatesWeekly.append(bufferString)
        }
        return arrayDatesWeekly
    }
    
    func findAxisNamesYear (arrayOfDates: [String]) -> [String] {
        var arrayDatesMonthly : [String] = []
        for index in stride(from: 15, to: 346, by: 30) {
            var bufferString = arrayOfDates[index]
            bufferString.removeLast(3)
            arrayDatesMonthly.append(bufferString)
        }
        return arrayDatesMonthly
    }
    
    init() {
        self.generateUEK()
    }
    
    func reloadTimer() {
        sendNotification()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            self.generateUEK()
        }
    }
    
    func generateUEK () {
        self.networkDataFetcher.fetchData(urlString: self.urlStringUSDEUR) { (webResponse) in
            self.webResponseDict["USD"] = webResponse.bpi.USD.rate_float
            self.webResponseDict["EUR"] = webResponse.bpi.EUR.rate_float
        }
        
        //    MARK: DISCLAIMER:
        //    MARK: API coindesk.com не дает информации о том, как достать цены биткоина в USD, EUR и KZT
        //    MARK: в одном запросе, поэтому пришлось делать два
        
        
        self.networkDataFetcher.fetchKZT(urlString: self.urlStringKZT) { (webResponse) in
            self.webResponseDict["KZT"] = webResponse.bpi.KZT.rate_float
        }
        
        self.networkDataFetcher.fetchHist(urlString: self.makeURLtoHist()) { (webResponse) in
            let dictKeyInc = webResponse.bpi.sorted(by: <)
            self.webResponseValues = dictKeyInc.map({ $0.value })
            self.webResponseKeys = dictKeyInc.map({ $0.key })
            if self.webResponseValues.count <= 365 {
                self.monthsArray = self.findAvgMonths(arrayOfDoubles: self.webResponseValues)
                self.weeksArray = self.findAvgWeeks(arrayOfDoubles: self.webResponseValues)
                self.daysArray = self.findAvgDays(arrayOfDoubles: self.webResponseValues)
                self.xAxisArrayYear = self.findAxisNamesYear(arrayOfDates: self.webResponseKeys)
                self.xAxisArrayMonth = self.findAxisNamesMonth(arrayOfDates: self.webResponseKeys)
                self.xAxisArrayWeek = self.findAxisNamesWeek(arrayOfDates: self.webResponseKeys)
            }
            DispatchQueue.main.async {
                self.realmOps.saveMonthAvgPrices(array: self.monthsArray)
                self.realmOps.saveWeekAvgPrices(array: self.weeksArray)
                self.realmOps.saveDayAvgPrices(array: self.daysArray)
                self.realmOps.saveXAxisYear(array: self.xAxisArrayYear)
                self.realmOps.saveXAxisMonth(array: self.xAxisArrayMonth)
                self.realmOps.saveXAxisDay(array: self.xAxisArrayWeek)
                self.realmOps.saveBPI(bpiDict: self.webResponseDict)
                self.sendNotification()
            }
        }
    }
}
