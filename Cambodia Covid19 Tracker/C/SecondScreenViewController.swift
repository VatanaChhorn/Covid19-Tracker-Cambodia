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
    
    var coronaVirusManager = CoronaVirusManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            coronaVirusManager.delegate = self
        coronaVirusManager.getTheDataFromAPI()
 
    }
    
    @IBAction func dismissButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension SecondScreenViewController: CoronaVirusManagerDelegate
{
    func didUpdateTheCases(coronaVirusCases: CoronaVirusModel) {
        DispatchQueue.main.async {
                self.totalCases.text = coronaVirusCases.getTotalCases
                 self.todayCases.text = String(coronaVirusCases.totalNewCases)
                 self.recoveredCases.text = String(coronaVirusCases.totalRecovered)
                 self.deathCases.text = String(coronaVirusCases.totalDeath)
        }
    }
    
    
}
