//
//  CoronaVirusManager.swift
//  Cambodia Covid19 Tracker
//
//  Created by Chhorn Vatana on 7/15/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import Foundation
import UIKit

protocol CoronaVirusManagerDelegate {
    func didUpdateTheCases (coronaVirusCases: CoronaVirusModel)
}

struct CoronaVirusManager {
    
    var delegate: CoronaVirusManagerDelegate?
    
    let apiURL = "https://api.covid19api.com/summary"

    func getTheDataFromAPI() -> Void {
        performReqeust(apiURL: apiURL)
    }
    
    func performReqeust(apiURL: String) -> Void {
        
        if let url = URL(string: apiURL)
        {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, respond, error) in
                if error != nil
                {
                    print("error block 1: \(error!)")
                    return
                }
                if let safeData = data
                {
                   if let casesOverview =  self.parseJSON(coronavirusData: safeData)
                   {
                    self.delegate?.didUpdateTheCases(coronaVirusCases: casesOverview)
                   }
                    
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(coronavirusData: Data ) -> CoronaVirusModel? {
        let decoder = JSONDecoder()
        do
        {
            let decodedData = try decoder.decode(CoronaVirusData.self, from: coronavirusData)
            
            let totalCases = decodedData.Countries[28].TotalConfirmed
            let recoveredCases = decodedData.Countries[28].TotalRecovered
            let totalDealths = decodedData.Countries[28].TotalDeaths
            let newCasesToday = decodedData.Countries[28].NewConfirmed
            
            
            let coronaVirusModel = CoronaVirusModel(totalCases: totalCases, totalRecovered: recoveredCases, totalDeath: totalDealths, totalNewCases: newCasesToday)
           
            return coronaVirusModel
            
        }
        catch
        {
            print("error block 2: \(error)")
            return nil

        }
    }
}

