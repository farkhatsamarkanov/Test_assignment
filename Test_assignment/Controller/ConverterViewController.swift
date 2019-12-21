
import UIKit

class ConverterViewController: UIViewController {
    
    // MARK: Buttons
    
    @IBOutlet weak var imageToTurn: UIImageView!
    @IBAction func fromEURtoBTC(_ sender: UIButton) {
        view.endEditing(true)
        if convData.count != 0 {
            for i in convData {
                if i.name == "EUR" {
                    if currTextField.text! != "" {
                        BTCtextField.text = String(Double(currTextField.text!)!/i.price)
                    }
                }
            }
        }else{
            print("no data")
        }
    }
    @IBAction func fromUSDtoBTC(_ sender: UIButton) {
        view.endEditing(true)
        if convData.count != 0 {
            for i in convData {
                if i.name == "USD" {
                    if currTextField.text! != "" {
                        BTCtextField.text = String(Double(currTextField.text!)!/i.price)
                    }
                }
            }
        } else{
            print("no data")
        }
    }
    @IBAction func fromKZTtoBTC(_ sender: UIButton) {
        view.endEditing(true)
        if convData.count != 0 {
            for i in convData {
                if i.name == "KZT" {
                    if currTextField.text! != "" {
                        BTCtextField.text = String(Double(currTextField.text!)!/i.price)
                    }
                }
            }
        }else{
            print("no data")
        }
    }
    @IBOutlet weak var currTextField: UITextField!
    @IBOutlet weak var BTCtextField: UITextField!
    @IBAction func fromBTCtoEUR(_ sender: UIButton) {
        view.endEditing(true)
        if convData.count != 0 {
            for i in convData {
                if i.name == "EUR" {
                    if BTCtextField.text! != "" {
                        currTextField.text = String(Double(BTCtextField.text!)!*(i.price))
                    }
                }
            }
        }else{
            print("no data")
        }
    }
    @IBAction func fromBTCtoUSD(_ sender: UIButton) {
        view.endEditing(true)
        if convData.count != 0 {
            for i in convData {
                if i.name == "USD" {
                    if BTCtextField.text! != "" {
                        currTextField.text = String(Double(BTCtextField.text!)!*(i.price))
                    }
                }
            }
        }else{
            print("no data")
        }
    }
    @IBAction func fromBTCtoKZT(_ sender: UIButton) {
        view.endEditing(true)
        if convData.count != 0 {
            for i in convData {
                if i.name == "KZT" {
                    if BTCtextField.text! != "" {
                        currTextField.text = String(Double(BTCtextField.text!)!*(i.price))
                    }
                }
            }
        }else{
            print("no data")
        }
    }
    
    //MARK: Variables
    
    let realmOps = RealmOps()
    var convData : [BPIcached] = []
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(received(notif:)), name: Constants.notificationName, object: nil)
        currTextField.layer.borderColor = UIColor.lightGray.cgColor
        BTCtextField.layer.borderColor = UIColor.lightGray.cgColor
        currTextField.layer.borderWidth = 1.0
        BTCtextField.layer.cornerRadius = 6.0
        currTextField.layer.borderWidth = 1.0
        BTCtextField.layer.cornerRadius = 6.0
        imageToTurn.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
        configureTextField()
        configureTapGesture()
    }
    
    //MARK: Tap handling
    
    @objc func received(notif: Notification) {
        convData = realmOps.readBPI()
    }
    private func configureTapGesture () {
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(ConverterViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
}
extension ConverterViewController: UITextFieldDelegate {
    private func configureTextField () {
        currTextField.delegate = self
        BTCtextField.delegate = self
    }
}
