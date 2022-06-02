//
//  PlannerModel.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 02.06.2022.
//

import Foundation

class PlannerModel:ObservableObject {
    //Array of planners
    @Published var planners:[Planner] = [Planner]()
    
     func generateNewPlanner () {
        let newPlanner = Planner()
        newPlanner.name = "New Planner"
         newPlanner.cities.append("America/Denver")
         planners.append(newPlanner)
    }
    
}
