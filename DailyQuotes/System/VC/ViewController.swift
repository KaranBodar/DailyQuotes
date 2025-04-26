//
//  ViewController.swift
//  DailyQuotes
//
//  Created by Karan Bodar on 23/04/25.
//

import UIKit
import Alamofire

struct APIQuote: Decodable {
    let quote: String
    let author: String
    init(dic: NSDictionary) {
        self.quote = (dic["quote"] as? String) ?? ""
        self.author = (dic["author"] as? String) ?? ""
    }
}

var favoriteQuotes: [(quote: String, author: String)] = []

class ViewController: UIViewController {

    // MARK: - IBOutlet -
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    // MARK: - Variables -
    var quotes: [Quotes] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fetchQuote()
        
    }
    
    
    
    // MARK: - IBAction -
    @IBAction func newQuote(_ sender: UIButton){
        self.fetchQuote()
     
        print(self.quoteLabel)
    }
    @IBAction func saveQuote(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure you want to save this quote?", message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel) { (_) in
            if let quoteText = self.quoteLabel.text, let authorText = self.authorLabel.text {
                var quote = self.quoteLabel.text ?? ""
                var auther = self.authorLabel.text ?? ""
                DataModel.shared.setUserData(content: quote, auther: auther)
            }
        }
        let cancle = UIAlertAction(title: "Cancle", style: .destructive)
        alert.addAction(ok)
        alert.addAction(cancle)
        self.present(alert, animated: true)
        
    }
    @IBAction func viewFavorites(_ sender: UIButton){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FavouriteQuoteVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Functions -
    func fetchQuote(){
        let apiUrl = AF.request(URL(string: "https://api.api-ninjas.com/v1/quotes?X-Api-Key=BWCr7iqbKCe4m0lX6rNd5g==ajCFASecm2vdDC1t")!, method: .get)
                apiUrl.responseJSON { comData in
                    let comData1 = comData.result
                    switch comData1 {
                    case .success(let value):
                        if let jsonData = value as? NSArray{
                            for i in jsonData {
                                if let jsonDic = i as? NSDictionary{
                                    let apiQuote = APIQuote(dic: jsonDic)
                                    UIView.transition(with: self.quoteLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                                            self.quoteLabel.text = "“\(apiQuote.quote)”"
                                        }, completion: nil)
                                    UIView.transition(with: self.authorLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                                        self.authorLabel.text = "- \(apiQuote.author)"
                                    }, completion: nil)
                                    print(jsonDic)
                                }
                            }
                        }
                    case.failure(let apiArr):
                        print(apiArr.localizedDescription)
                    }
                }

    }
}

