//
//  SecondScreenViewController.swift
//  Cambodia Covid19 Tracker
//
//  Created by Chhorn Vatana on 7/14/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import UIKit

class SecondScreenViewController: UIViewController {
    @IBOutlet weak var totalCases: UILabel!
    @IBOutlet weak var todayCases: UILabel!
    @IBOutlet weak var recoveredCases: UILabel!
    @IBOutlet weak var deathCases: UILabel!
    let defaults = UserDefaults.standard
   
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call the default data
        recoveredCases.text = String(defaults.integer(forKey: Sources.Userdefualts.recoveredCasesData))
        
        totalCases.text = String(defaults.integer(forKey: Sources.Userdefualts.newCasesData))
        
        todayCases.text = String(defaults.integer(forKey: Sources.Userdefualts.todayCasesData))
        
        deathCases.text = String(defaults.integer(forKey: Sources.Userdefualts.deathCasesData))
        
        
    }
    
    //MARK: - Button functions
    @IBAction func dismissButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
    
    

