import UIKit

class QuoteDetailViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var typeLAbel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    let dateFormatter = formatter()
    var transaction: transactionCached?
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let quote = transaction {
            amountLabel.text = "\(quote.amount) BTC"
            if quote.type == 0 {
                typeLAbel.text  = "purchase"
                typeLAbel.textColor = UIColor.green
            }  else {
                typeLAbel.text  = "sale"
                typeLAbel.textColor = UIColor.red
            }
            rateLabel.text = "\(quote.price) $"
            if let a = Double(quote.price) {
                if let b = Double(quote.amount) {
                    priceLabel.text = "\(a*b) $"
                }
            }
            idLabel.text = "\(quote.tid)"
            dateLabel.text = "\(dateFormatter.formatDate(unixDate: quote.date))"
        }
    }
}

