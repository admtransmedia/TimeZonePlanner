//
//  PlannerModel.swift
//  Timezoner
//
//  Created by Sergei Kriukov on 02.06.2022.
//

import Foundation

class PlannerModel:ObservableObject {
    //Array of planners
    @Published var planners:[Planner] = [Planner]()
    //Variable for updating views
    @Published var updateView = 0
    // Read planners from User default when app starts
    init() {
        readPlanners()
    }
    //Generating new planner
    func generateNewPlanner () {
        let newPlanner = Planner()
        newPlanner.name = "New List"
        planners.append(newPlanner)
        savePlanners()
    }
    //Save planners to Userdefaults
    func savePlanners () {
        let amount = planners.count
        UserDefaults.standard.set(amount, forKey: "Amount")
        for index in 0..<amount {
            UserDefaults.standard.set(planners[index].name, forKey: "\(index)")
            let amountCity = planners[index].cities.count
            UserDefaults.standard.set(amountCity, forKey: "\(index)amountCity")
            for indexCity in 0..<amountCity {
                UserDefaults.standard.set(planners[index].cities[indexCity].cityId, forKey: "\(index)cityId\(indexCity)")
                UserDefaults.standard.set(planners[index].cities[indexCity].cityName, forKey: "\(index)cityName\(indexCity)")
            }
        }
    }
    //Read planners from userdefaults
    func readPlanners() {
        planners.removeAll()
        let amount = UserDefaults.standard.integer(forKey: "Amount")
        for index in 0..<amount {
            let storedPlanner = Planner()
            storedPlanner.name = UserDefaults.standard.string(forKey: "\(index)")!
            let amountCity = UserDefaults.standard.integer(forKey: "\(index)amountCity")
            for indexCity in 0..<amountCity {
                let storedCity = City()
                storedCity.cityId = UserDefaults.standard.string(forKey: "\(index)cityId\(indexCity)")!
                storedCity.cityName = UserDefaults.standard.string(forKey: "\(index)cityName\(indexCity)")!
                storedPlanner.cities.append(storedCity)
            }
            planners.append(storedPlanner)
        }
    }
}
