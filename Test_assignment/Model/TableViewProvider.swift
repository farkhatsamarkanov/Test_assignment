//MARK: Class to provide Table View with data
import Foundation

class TableViewProvider {
    let networkDataFetcher = NetworkDataFetcher()
    let realmOps = RealmOps()
    let userInfo = ["key":"value"]
    let urlString = "https://www.bitstamp.net/api/transactions/"
    var transArray : [Transaction] = []
    private var timer: Timer?
    private func sendNotification() {
        NotificationCenter.default.post(name: Constants.tableViewNotification, object: nil, userInfo: userInfo)
    }
    init() {
        self.generateUEK()
    }
    func reloadTimer() {
        sendNotification()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { timer in
            self.generateUEK()
        }
    }
    func generateUEK () {
        self.networkDataFetcher.fetchTransaction(urlString: self.urlString) { (webResponse) in
            self.transArray = webResponse
            DispatchQueue.main.async {
                self.realmOps.saveTransactions(transArray: self.transArray)
                self.sendNotification()
            }
        }
    }
}
