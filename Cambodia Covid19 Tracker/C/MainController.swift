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
    let source = Sources()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        coronaVirusManager.delegate = self
          coronaVirusManager.getTheDataFromAPI()
    }
    
    
    @IBAction func learnMoreButtonClicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: source.learnMoreLink)!)
    }
    @IBAction func liveUpdateButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: source.secondSreenSegue, sender: self)
        
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

