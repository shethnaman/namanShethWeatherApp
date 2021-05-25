//
//  SettingViewController.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 26/05/21.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClearBookMarkCliekced(_ sender: Any) {
        DatabaseManager.shared.clearData()
    }
    
}
