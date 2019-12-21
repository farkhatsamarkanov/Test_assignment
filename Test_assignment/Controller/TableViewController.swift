import UIKit
import AnimatableReload

class TableViewController: UITableViewController {
    
    //MARK: Variables
    
    var transactionArray : [transactionCached]  = []
    var tableViewProvider : TableViewProvider?
    let dateFormatter = formatter()
    let realmOps = RealmOps()
    
    @IBAction func refreshTable(_ sender: UIButton) {
        tableViewProvider?.reloadTimer()
        AnimatableReload.reload(tableView: tableView, animationDirection: "right")
    }
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionArray = realmOps.readTransactions()
        NotificationCenter.default.addObserver(self, selector: #selector(received(notif:)), name: Constants.tableViewNotification, object: nil)
        tableViewProvider = TableViewProvider()
        tableViewProvider?.reloadTimer()
        AnimatableReload.reload(tableView: tableView, animationDirection: "right")
    }
    @objc func received(notif: Notification) {
        transactionArray = realmOps.readTransactions()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if transactionArray.count > 500 {
            transactionArray.removeSubrange(499..<transactionArray.count)
            return transactionArray.count
        } else {
            return transactionArray.count
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "funkyCellIdentifier", for: indexPath) as! TableViewCell
        let transaction = transactionArray[indexPath.row]
        if transaction.type == 0 {
            cell.typeLabel.text = "PURCHASE"
            cell.typeLabel.textColor = UIColor.green
        }  else {
            cell.typeLabel.text = "SALE"
            cell.typeLabel.textColor = UIColor.red
        }
        cell.amountLabel.text = transaction.amount
        cell.dateLabel.text = "\(dateFormatter.formatDate(unixDate: transaction.date))"
        return cell
    }
    
    //MARK: Preparing for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetail" else {
            return
        }
        if let transDetail = segue.destination as? QuoteDetailViewController {
            if let cell = sender as? TableViewCell {
                if let indexPath = tableView.indexPath(for: cell) {
                    let transaction = transactionArray[indexPath.row]
                    transDetail.transaction = transaction
                }
            }
        }
    }
    
}
