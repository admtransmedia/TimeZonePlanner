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
 
    init() {
       readPlanners()
    }
    
    
     func generateNewPlanner () {
        let newPlanner = Planner()
        newPlanner.name = "New Planner"
    //     newPlanner.cities.append("America/Denver")
         planners.append(newPlanner)
         savePlanners()
    }
//    func generateNewCity (planIndex:Int) {
//        planners[planIndex].cities.append("America/Denver")
//    }
    
    
    
   func savePlanners () {
       
//       let amount = planners.count
//       UserDefaults.standard.set(amount, forKey: "Amount")
//       for index in 0..<amount {
//           UserDefaults.standard.set(planners[index].name, forKey: "\(index)")
//           UserDefaults.standard.set(planners[index].cities, forKey: "\(index)cities")
//       }
//
    }
    
    func readPlanners() {
//        planners.removeAll()
//        let amount = UserDefaults.standard.integer(forKey: "Amount")
//        for index in 0..<amount {
//            let storedPlanner = Planner()
//            storedPlanner.name = UserDefaults.standard.string(forKey: "\(index)")!
//            storedPlanner.cities = UserDefaults.standard.array(forKey: "\(index)cities") as? [String] ?? [String]()
//            planners.append(storedPlanner)
//        }
    }
}
