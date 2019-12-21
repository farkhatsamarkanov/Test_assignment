import Foundation
class formatter {
    let dateFormatter = DateFormatter()
    func formatDate(unixDate: String) -> String{
        var localDate = ""
        if let timeResult = Double(unixDate) {
            let date = Date(timeIntervalSince1970: timeResult)
            dateFormatter.timeStyle = DateFormatter.Style.short
            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeZone = .current
            localDate = dateFormatter.string(from: date)
        }
        return localDate
    }
}
