//
//  ViewController.swift
//  DailyQuotes
//
//  Created by Karan Bodar on 23/04/25.
//

import UIKit

struct APIQuote: Decodable {
    let content: String
    let author: String
}

class ViewController: UIViewController {

    // MARK: - IBOutlet -
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
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
    func fetchQuote(){
        let urlString = "https://api.quotable.io/random"
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
        do {
            let decodedQuote = try JSONDecoder().decode(APIQuote.self, from: data)
            print("Quote received: \(decodedQuote.content) — \(decodedQuote.author)")
                DispatchQueue.main.async {
                    self.quoteLabel.text = "“\(decodedQuote.content)”"
                    self.authorLabel.text = "- \(decodedQuote.author)"
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

