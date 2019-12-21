import UIKit
import Foundation
import Charts

//MARK: Class to change default x axis values on chart

@objc(LineChartFormatter)
public class LineChartFormatter: NSObject, IAxisValueFormatter
{
    func whatToShow (arrayOfDates: [String]) {
        arrayOfStrings.removeAll()
        for i in arrayOfDates {
            arrayOfStrings.append(i)
        }
    }
    var arrayOfStrings: [String] = []
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
  {
    return arrayOfStrings[Int(value)]
  }
}

