import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    
    //http isteklerine izin vermek için info.plist içindeki aşağıdaki bölümü bu projedeki gibi ayarlamak gerekiyor
    //App Transport Security Settings
    //Allow Arbitrary Loads -> YES
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func getRatesClicked(_ sender: Any) {
        //1. Request & Session
        //2. Response & Data
        //3. Parsing & JSON Serialization
        
        //Url yi tanımla
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=944fc3aacb3bcfd10a9822a6368ccb53&format=1")
        
        //session oluştur
        let session = URLSession.shared
        
        //task ile url yi çalıştır
        //Closure
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(self, animated: true, completion: nil)
            }
            else {
                if data != nil {
                    //2. Response & Data
                    
                    //Veriyi bir container'e deserialize ediyoruz
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //ASYNC
                        DispatchQueue.main.async {
                            //3. Parsing & JSON Serialization
                            //print(jsonResponse)
                            //print(jsonResponse["success"])
                            //print(jsonResponse["rates"])
                            
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                //print(rates)
                                
                                if let cad = rates["CAD"] as? Double {
                                    //print(cad)
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let tr = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(trßßß)"
                                }
                            }
                        }
                        
                    }
                    catch {
                        print("Error!")
                    }
                    
                }
            }
        }
        task.resume()
        
        
        
        
    }
}

