//
//  CoronaVirusModel.swift
//  Cambodia Covid19 Tracker
//
//  Created by Chhorn Vatana on 7/15/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import Foundation

struct CoronaVirusModel {
    let totalCases: Int
    let totalRecovered: Int
    let totalDeath: Int
    let totalNewCases: Int
    
    var getTotalCases: String
    {
        return String(totalCases)
    }
    
}
