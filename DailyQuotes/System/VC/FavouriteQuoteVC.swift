//
//  FavouriteQuoteVC.swift
//  DailyQuotes
//
//  Created by Karan Bodar on 24/04/25.
//

import UIKit

struct FavouriteQuote {
    var quote: String
    var author: String
}
class FavouriteQuoteVC: UIViewController {

    // MARK: - IBOutlets -
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables -
    var details: Quotes?
    var savedQuotes: [Quotes] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setTableView()
        self.tableView.reloadData()
        print(DataModel.shared.getUserData())
    }
    
    @IBAction func clickHome(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension FavouriteQuoteVC: UITableViewDelegate, UITableViewDataSource {
    
    func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "FavouriteQuoteCell", bundle: nil), forCellReuseIdentifier: "FavouriteQuoteCell")
        self.savedQuotes = DataModel.shared.getUserData()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteQuoteCell", for: indexPath) as! FavouriteQuoteCell
        let quote = savedQuotes[indexPath.row]
        cell.contentSaveLabel?.text = quote.content
        cell.authrSaveLabel?.text = quote.auther
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let userDelete = self.savedQuotes[indexPath.row]
            DataModel.shared.deleteUserData(content: userDelete.content!, auther: userDelete.auther!)
            self.savedQuotes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
