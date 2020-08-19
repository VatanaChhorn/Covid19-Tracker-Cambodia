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
    @IBOutlet weak var stateImage: UIImageView!
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        //Setting up the state image
        if self.defaults.bool(forKey: Sources.Settings.switchingData) {
            stateImage.image = #imageLiteral(resourceName: "Global State")
        } else
        {
            stateImage.image = #imageLiteral(resourceName: "Counttry State")
        }
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.bool(forKey: Sources.Settings.switchingData) {
            //Call the local default data
            
            recoveredCases.text = String(defaults.integer(forKey: Sources.Userdefualts.globalRecovered))
            
            totalCases.text = String(defaults.integer(forKey: Sources.Userdefualts.globalConfirmed))
            
            todayCases.text = String(defaults.integer(forKey: Sources.Userdefualts.globalNewCases))
            
            deathCases.text = String(defaults.integer(forKey: Sources.Userdefualts.globalDeaths))
            
        }   else {
            
            //Call the local default data
            
            recoveredCases.text = String(defaults.integer(forKey: Sources.Userdefualts.recoveredCasesData))
            
            totalCases.text = String(defaults.integer(forKey: Sources.Userdefualts.newCasesData))
            
            todayCases.text = String(defaults.integer(forKey: Sources.Userdefualts.todayCasesData))
            
            deathCases.text = String(defaults.integer(forKey: Sources.Userdefualts.deathCasesData))
            
            
            
        }
    }
    
    //MARK: - Button functions
    @IBAction func dismissButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}



