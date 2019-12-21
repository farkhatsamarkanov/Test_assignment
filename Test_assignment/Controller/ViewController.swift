// Made by Farkaht Samarkanov
// for ChocoFamily test assignment

import UIKit
import Charts

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var firstScreenProvider: FirstScreenProvider?
    let realmOps = RealmOps()
    var bpis : [BPIcached] = []
    
    // MARK: Arrays for chart
    
    var xAxisYearArray: [String] = []
    var xAxisMonthArray: [String] = []
    var xAxisWeekArray: [String] = []
    var yearPricesArray: [Double] = []
    var monthPricesArray: [Double] = []
    var weekPricesArray: [Double] = []
    var activePrice : Double = 0.0
    var yearPricesEUR: [Double] = []
    var monthPricesEUR: [Double] = []
    var weekPricesEUR: [Double] = []
    var yearPricesKZT: [Double] = []
    var monthPricesKZT: [Double] = []
    var weekPricesKZT: [Double] = []
    var dataEntries: [ChartDataEntry] = []
    
    //MARK: UI elements
    
    @IBOutlet weak var amountOfCurrencyLabel: UILabel!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    @IBOutlet weak var mChart: LineChartView!
    @IBAction func refreshPickerView(_ sender: UIButton) {
        currencyPickerView.reloadAllComponents()
        firstScreenProvider?.reloadTimer()
    }
    @IBAction func ChangeChartData(_ sender: Any) {
        if bpis.count != 0 {
            let row = currencyPickerView.selectedRow(inComponent: 0)
            switch row {
            case 2:
                setChart(values: monthPricesKZT, xAxisValues: ["Week 1","Week 2","Week 3","Week 4"])
            case 1:
                setChart(values: monthPricesEUR, xAxisValues: ["Week 1","Week 2","Week 3","Week 4"])
            default:
                setChart(values: monthPricesArray, xAxisValues: ["Week 1","Week 2","Week 3","Week 4"])
                
            }
        } else {
            print("Couldn't get currency value")
            setChart(values: monthPricesArray, xAxisValues: ["Week 1","Week 2","Week 3","Week 4"])
        }
    }
    @IBAction func weekButtonTapped(_ sender: Any) {
        if bpis.count != 0 {
            let row = currencyPickerView.selectedRow(inComponent: 0)
            switch row {
            case 2:
                setChart(values: weekPricesKZT, xAxisValues: ["Day 1","Day 2","Day 3","Day 4","Day 5", "Day 6", "Day 7"])
            case 1:
                setChart(values: weekPricesEUR, xAxisValues: ["Day 1","Day 2","Day 3","Day 4","Day 5", "Day 6", "Day 7"])
            default:
                setChart(values: weekPricesArray, xAxisValues: ["Day 1","Day 2","Day 3","Day 4","Day 5", "Day 6", "Day 7"])
            }
        } else {
            print("Couldn't get currency value")
            setChart(values: weekPricesArray, xAxisValues: ["Day 1","Day 2","Day 3","Day 4","Day 5", "Day 6", "Day 7"])
        }
    }
    @IBAction func yearButtonTapped(_ sender: Any) {
        if bpis.count != 0 {
            let row = currencyPickerView.selectedRow(inComponent: 0)
            switch row {
            case 2:
                setChart(values: yearPricesKZT, xAxisValues: xAxisYearArray)
            case 1:
                setChart(values: yearPricesEUR, xAxisValues: xAxisYearArray)
            default:
                setChart(values: yearPricesArray, xAxisValues: xAxisYearArray)
            }
        } else {
            print("Couldn't get currency value")
            setChart(values: yearPricesArray, xAxisValues: xAxisYearArray)
        }
    }
    
    //MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bpis = realmOps.readBPI()
        yearPricesArray = realmOps.readMonthsAvgPrices()
        monthPricesArray = realmOps.readWeeksAvgPrices()
        weekPricesArray = realmOps.readDaysAvgPrices()
        xAxisYearArray = realmOps.readXAxisYear()
        xAxisMonthArray = realmOps.readXAxisMonth()
        xAxisWeekArray = realmOps.readXAxisDay()
        NotificationCenter.default.addObserver(self, selector: #selector(received(notif:)), name: Constants.notificationName, object: nil)
        firstScreenProvider = FirstScreenProvider()
        firstScreenProvider?.reloadTimer()
        setChart(values: yearPricesArray, xAxisValues: xAxisYearArray)
        recalculateDataForEUR()
        recalculateDataForKZT()
        currencyPickerView.reloadAllComponents()
        if bpis.count != 0 {
            for i in bpis {
                if i.name == "USD" {
                    amountOfCurrencyLabel.text = String(i.price)
                }
            }
        }
    }
    
    //MARK: Notification observer, refreshes the data
    
    @objc func received(notif: Notification) {
        bpis = realmOps.readBPI()
        yearPricesArray = realmOps.readMonthsAvgPrices()
        monthPricesArray = realmOps.readWeeksAvgPrices()
        weekPricesArray = realmOps.readDaysAvgPrices()
        xAxisYearArray = realmOps.readXAxisYear()
        xAxisMonthArray = realmOps.readXAxisMonth()
        xAxisWeekArray = realmOps.readXAxisDay()
        recalculateDataForEUR()
        recalculateDataForKZT()
        currencyPickerView.reloadAllComponents()
    }
    
    // MARK: PickerView settings
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bpis.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var a = ""
        if bpis.count != 0 {
            switch row {
            case 2:
                for i in bpis {
                    if i.name == "KZT" {
                        a = i.name
                    }
                }
            case 1:
                for i in bpis {
                    if i.name == "EUR" {
                        a = i.name
                    }
                }
            default:
                for i in bpis {
                    if i.name == "USD" {
                        a = i.name
                    }
                }
            }
        }
        return a
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var b = 0.0
        if bpis.count != 0 {
            switch row {
            case 2:
                for i in bpis {
                    if i.name == "KZT" {
                        b = i.price
                    }
                }
            case 1:
                for i in bpis {
                    if i.name == "EUR" {
                        b = i.price
                    }
                }
            default:
                for i in bpis {
                    if i.name == "USD" {
                        b = i.price
                    }
                }
            }
        }
        activePrice = b
        amountOfCurrencyLabel.text = String(activePrice)
    }
    
    //MARK: Data for chart
    
    func recalculateDataForKZT (){
        var rateKZT = 0.0
        var rateUSD = 0.0
        for item in bpis {
            if item.name == "USD" {
                rateUSD = item.price
            }
        }
        for item in bpis {
            if item.name == "KZT" {
                rateKZT = item.price
            }
        }
        let ratio = rateUSD/rateKZT
        let KZTarrayYear = yearPricesArray.map({ $0/ratio })
        yearPricesKZT.removeAll()
        for i in KZTarrayYear {
            yearPricesKZT.append(i)
        }
        let KZTarrayMonth = monthPricesArray.map({ $0/ratio })
        monthPricesKZT.removeAll()
        for i in KZTarrayMonth {
            monthPricesKZT.append(i)
        }
        let KZTarrayWeek = weekPricesArray.map({ $0/ratio })
        weekPricesKZT.removeAll()
        for i in KZTarrayWeek {
            weekPricesKZT.append(i)
        }
        
    }
    func recalculateDataForEUR (){
        var rateEUR = 0.0
        var rateUSD = 0.0
        for item in bpis {
            if item.name == "USD" {
                rateUSD = item.price
            }
        }
        for item in bpis {
            if item.name == "EUR" {
                rateEUR  = item.price
            }
        }
        let ratio = rateUSD/rateEUR
        let EURarrayYear = yearPricesArray.map({ $0/ratio })
        yearPricesEUR.removeAll()
        for i in EURarrayYear {
            yearPricesEUR.append(i)
        }
        let EURarrayMonth = monthPricesArray.map({ $0/ratio })
        monthPricesEUR.removeAll()
        for i in EURarrayMonth {
            monthPricesEUR.append(i)
        }
        let EURarrayWeek = weekPricesArray.map({ $0/ratio })
        weekPricesEUR.removeAll()
        for i in EURarrayWeek {
            weekPricesEUR.append(i)
        }
    }
    
    //MARK: Setting/refreshing chart
    
    func setChart(values: [Double], xAxisValues: [String]) {
        mChart.noDataText = "No data available!"
        dataEntries.removeAll()
        let formato: LineChartFormatter = LineChartFormatter()
        let xaxis:XAxis = XAxis()
        formato.whatToShow(arrayOfDates: xAxisValues)
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
            formato.stringForValue(Double(i), axis: xaxis)             // ругается, но без этого не работает :)
        }
        xaxis.valueFormatter = formato
        mChart.xAxis.valueFormatter = xaxis.valueFormatter
        
        let line1 = LineChartDataSet(entries: dataEntries, label: "Price")
        line1.colors = [NSUIColor.blue]
        line1.mode = .cubicBezier
        line1.cubicIntensity = 0.2
        
        let gradient = getGradientFilling()
        line1.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        line1.drawFilledEnabled = true
        
        let data = LineChartData()
        data.addDataSet(line1)
        mChart.data = data
        mChart.setScaleEnabled(false)
        mChart.drawGridBackgroundEnabled = false
        mChart.xAxis.drawAxisLineEnabled = false
        mChart.xAxis.axisMaxLabels = xAxisValues.count
        mChart.xAxis.drawGridLinesEnabled = false
        mChart.xAxis.avoidFirstLastClippingEnabled = true
        mChart.leftAxis.drawAxisLineEnabled = false
        mChart.leftAxis.drawGridLinesEnabled = false
        mChart.rightAxis.drawAxisLineEnabled = false
        mChart.rightAxis.drawGridLinesEnabled = false
        mChart.legend.enabled = false
        mChart.xAxis.enabled = true
        mChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        mChart.leftAxis.enabled = false
        mChart.rightAxis.enabled = false
        mChart.xAxis.drawLabelsEnabled = true
        mChart.data?.notifyDataChanged()
        mChart.notifyDataSetChanged()
        mChart.animate(xAxisDuration: 1.5)
    }
    
    
    // MARK: Creating gradient for filling space under the line chart
    
    private func getGradientFilling() -> CGGradient {
        let coloTop = UIColor(red: 141/255, green: 133/255, blue: 220/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 230/255, green: 155/255, blue: 210/255, alpha: 1).cgColor
        let gradientColors = [coloTop, colorBottom] as CFArray
        let colorLocations: [CGFloat] = [0.7, 0.0]
        return CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)!
    }
}

