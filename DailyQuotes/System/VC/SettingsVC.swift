//
//  SettingsVC.swift
//  DailyQuotes
//
//  Created by Karan Bodar on 06/06/25.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet var backGround: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: - IBAction -
    @IBAction func clickBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func switchTheme(_ sender: UISwitch) {
        if sender.isOn {
            self.backGround.backgroundColor = .systemOrange
        } else {
            self.backGround.backgroundColor = .systemBackground
        }
//        overrideUserInterfaceStyle = sender.isOn ? .dark : .light
    }
    
    

}
