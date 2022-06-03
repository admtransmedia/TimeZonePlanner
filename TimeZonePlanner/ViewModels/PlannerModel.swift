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
    @Published var updateView = 0
    
     func generateNewPlanner () {
        let newPlanner = Planner()
        newPlanner.name = "New Planner"
    //     newPlanner.cities.append("America/Denver")
         planners.append(newPlanner)
    }
//    func generateNewCity (planIndex:Int) {
//        planners[planIndex].cities.append("America/Denver")
//    }
}
