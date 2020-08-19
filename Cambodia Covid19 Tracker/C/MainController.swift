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
    @IBOutlet weak var religionButton: UIButton!
    
    var coronaVirusManager = CoronaVirusManager()
    let source = Sources()
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        coronaVirusManager.delegate = self
        coronaVirusManager.getTheDataFromAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Checking the button background Image
        if self.defaults.bool(forKey: Sources.Settings.switchingData) {
            religionButton.setBackgroundImage(#imageLiteral(resourceName: "GlobalButton"), for: UIControl.State.normal)
        } else
        {
            religionButton.setBackgroundImage(#imageLiteral(resourceName: "Region Column"), for: UIControl.State.normal)
        }
        
        //Declare delegate and call the functions
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0)  {
            if self.defaults.bool(forKey: Sources.Userdefualts.checkInternetConnection) == true {
                let alert = UIAlertController(title: "Connection Failed 🤯", message: "The Internet connection appears to be offline.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Understood", style: .default, handler:  { (action) in
                    self.view.alpha = 1
                }))
                self.view.alpha = 0.2
                self.present(alert, animated: true, completion: nil)
                print("Triggered")
            }
        }
        
        //Display the defualtData to the Screen
        if defaults.bool(forKey: Sources.Settings.switchingData) {
            self.totalCasesLabel.text = String(defaults.integer(forKey: Sources.Userdefualts.globalConfirmed))
        }   else {
            self.totalCasesLabel.text = String(UserDefaults.standard.integer(forKey: Sources.Userdefualts.newCasesData))
        }
    }
    
    //MARK: - Button Functions
    @IBAction func learnMoreButtonClicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: source.learnMoreLink)!)
    }
    
    @IBAction func liveUpdateButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: source.secondSreenSegue, sender: self)
        
    }
    
    @IBAction func switchingDataButtonClicked(_ sender: UIButton) {
        defaults.set(!defaults.bool(forKey: Sources.Settings.switchingData), forKey: Sources.Settings.switchingData)
        if defaults.bool(forKey: Sources.Settings.switchingData) {
            self.totalCasesLabel.text = String(defaults.integer(forKey: Sources.Userdefualts.globalConfirmed))
            religionButton.setBackgroundImage(#imageLiteral(resourceName: "GlobalButton"), for: UIControl.State.normal)
        }   else {
            self.totalCasesLabel.text = String(UserDefaults.standard.integer(forKey: Sources.Userdefualts.newCasesData))
            religionButton.setBackgroundImage(#imageLiteral(resourceName: "Region Column"), for: UIControl.State.normal)
        }
    }
}


//MARK: - Delegate extensions
extension MainController: CoronaVirusManagerDelegate
{
    func didUpdateTheCases(coronaVirusCases: CoronaVirusModel) {
        DispatchQueue.main.async {
            
            if self.defaults.bool(forKey: Sources.Settings.switchingData) {
                self.totalCasesLabel.text = String(coronaVirusCases.globalTotalCases)
            } else {
                self.totalCasesLabel.text = String(coronaVirusCases.getTotalCases)
            }
            
            // Setup local data to Userdefault
            if ( coronaVirusCases.totalNewCases != self.defaults.integer(forKey: Sources.Userdefualts.todayCasesData) ) || ( coronaVirusCases.totalCases != self.defaults.integer(forKey: Sources.Userdefualts.newCasesData))
            {   
                self.defaults.set(coronaVirusCases.totalCases, forKey: Sources.Userdefualts.newCasesData)
                self.defaults.set(coronaVirusCases.totalRecovered, forKey: Sources.Userdefualts.recoveredCasesData)
                self.defaults.set(coronaVirusCases.totalNewCases, forKey: Sources.Userdefualts.todayCasesData)
                self.defaults.set(coronaVirusCases.totalDeath, forKey: Sources.Userdefualts.deathCasesData)
            }
            
            // Setup global data to UserDefault
            if ( coronaVirusCases.globalNewcases != self.defaults.integer(forKey: Sources.Userdefualts.globalNewCases) ) || ( coronaVirusCases.globalTotalCases != self.defaults.integer(forKey: Sources.Userdefualts.globalConfirmed))
            {
                self.defaults.set(coronaVirusCases.globalTotalCases, forKey: Sources.Userdefualts.globalConfirmed)
                self.defaults.set(coronaVirusCases.globalNewcases, forKey: Sources.Userdefualts.globalNewCases)
                self.defaults.set(coronaVirusCases.globalDeath, forKey: Sources.Userdefualts.globalDeaths)
                self.defaults.set(coronaVirusCases.globalRecoveredCases, forKey: Sources.Userdefualts.globalRecovered)
            }
        }
    }
}

