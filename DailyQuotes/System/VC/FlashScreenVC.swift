//
//  FlashScreenVC.swift
//  DailyQuotes
//
//  Created by Karan Bodar on 24/04/25.
//

import UIKit

class FlashScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController")
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    

    

}
