//
//  CoronaVirusData.swift
//  Cambodia Covid19 Tracker
//
//  Created by Chhorn Vatana on 7/15/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import Foundation

struct CoronaVirusData: Codable {
    var Countries: [Countries]
}

struct Countries:  Codable{
    var NewConfirmed: Int
    var TotalConfirmed: Int
    var TotalDeaths:Int
    var TotalRecovered:Int
}

