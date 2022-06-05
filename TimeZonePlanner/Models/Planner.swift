//
//  Planner.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 01.06.2022.
//

import Foundation
//Planner model. 
class Planner:Identifiable {
    var name:String = ""
    var cities:[City] = [City]()
    
}
class City:Identifiable {
    var cityName:String = ""
    var cityId:String = ""
}
