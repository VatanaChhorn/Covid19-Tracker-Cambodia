//
//  ViewController.swift
//  Cambodia Covid19 Tracker
//
//  Created by Chhorn Vatana on 7/9/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var totalCasesLabel: UILabel!
    
    var coronaVirusManager = CoronaVirusManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        coronaVirusManager.delegate = self
          coronaVirusManager.getTheDataFromAPI()
    }
    
    
    @IBAction func learnMoreButtonClicked(_ sender: UIButton) {
    }
    @IBAction func liveUpdateButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "performSecondScreen", sender: self)
        
    }
    
    
    }


    
extension MainController: CoronaVirusManagerDelegate
{
    func didUpdateTheCases(coronaVirusCases: CoronaVirusModel) {
        DispatchQueue.main.async {
            self.totalCasesLabel.text = coronaVirusCases.getTotalCases
        
        }
    }
    
    
}

