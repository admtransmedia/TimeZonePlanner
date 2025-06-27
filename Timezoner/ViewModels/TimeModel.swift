//
//  TimeModel.swift
//  Timezoner
//
//  Created by Sergei Kriukov on 01.06.2022.
//

import Foundation
class TimeModel:ObservableObject {
    //Is settings View showed
    @Published var settingsViewIsPresented = false
    //Array of timezones
    @Published var zones:[Zone] = [Zone]()
    //Is picker for new city showed
    @Published var newCityView = false
    //Date property for DataPicker
    @Published var date = Date()
    //Variable for searching in Picker View
    @Published var searchText = ""
    //List of filtered (after search) zones
    @Published var filteredZones:[Zone] = [Zone]()
    //Start and finish workday Date objects
    @Published var startWork = Date()
    @Published var finishWork = Date()
    //List of custon time zones
    @Published var userZonez:[Zone] = [Zone]()
    //Getting ;ist of actual timezones, custom timezones and saved worktime from device when app starts
    init () {
        getZonesList()
        userDefinedZones()
        readWorktime()
    }
    //Getting list of all actual time zones from device
    func getZonesList () {
        //getting list of all timezones
        var zonesList = TimeZone.knownTimeZoneIdentifiers
        // Creating new list of all timezones with reversed elements
        var reversedZonesList:[String] = [String]()
        var reversedElement = ""
        for index in zonesList {
            var element = index.components(separatedBy: "/")
            element.reverse()
            switch element.count {
            case 3:  reversedElement = "\(element[0])/\(element[1])/\(element[2])"
            case 2:  reversedElement = "\(element[0])/\(element[1])"
            default :  reversedElement = "\(element[0])"
            }
            reversedZonesList.append(reversedElement)
        }
        // Sort new list
        reversedZonesList.sort()
        //Remove the original list
        zonesList.removeAll()
        //Recreate original list after sorting with right identifiers
        for index in reversedZonesList {
            var element = index.components(separatedBy: "/")
            element.reverse()
            switch element.count {
            case 3:  reversedElement = "\(element[0])/\(element[1])/\(element[2])"
            case 2:  reversedElement = "\(element[0])/\(element[1])"
            default :  reversedElement = "\(element[0])"
            }
            zonesList.append(reversedElement)
        }
        //Loop through each timezone, create new Zone object and append to an array zones
        for index in zonesList {
            //New instance of Zone
            let indexZone = Zone()
            //Getting timezone identifiers
            indexZone.identifier = index
            //Getting GMT
            indexZone.gmt = TimeZone(identifier: index)?.abbreviation() ?? ""
            //Split identifier onto city, region, country
            let splitter = index.components(separatedBy: "/")
            //Getting region
            indexZone.region = splitter[0]
            //Check if there is a city or country
            if splitter.count == 2 {
                indexZone.cityOrCountry = (splitter[1])
            } else if splitter.count>2 {
                indexZone.cityOrCountry = "\(splitter[2]) \(splitter[1])"
            } else  {
                indexZone.cityOrCountry = splitter[0]
            }
            zones.append(indexZone)
        }
        //Adding Nur-Sultan city
        let nurSultan = Zone()
        nurSultan.identifier = "Asia/Almaty"
        nurSultan.gmt = "GMT+6"
        nurSultan.region = "Asia"
        nurSultan.cityOrCountry = "Nur_Sultan"
        zones.append(nurSultan)
    }
    //Search from actual time zones in Picker View
    func searchZones ()  {
        if searchText == "" {
            filteredZones = zones
        } else {
            filteredZones = zones.filter{$0.identifier?.localizedCaseInsensitiveContains(searchText) ?? true || $0.gmt?.localizedCaseInsensitiveContains(searchText) ?? true || $0.cityOrCountry?.localizedCaseInsensitiveContains(searchText) ?? true}
        }
    }
    //User defined timezones, from local JSON
    func userDefinedZones () {
        let path = Bundle.main.path(forResource: "manualzones", ofType: "json")
        if path != nil {
            let url = URL(fileURLWithPath: path!)
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                do {
                    let rezult = try decoder.decode([Zone].self, from: data)
                    userZonez = rezult
                } catch {
                    print("Error with JSON")
                }
            } catch {
                print("Error with URL")
            }
        }
    }
    //Save worktime
    func saveWorktime() {
        UserDefaults.standard.set(startWork, forKey: "startWork")
        UserDefaults.standard.set(finishWork, forKey: "finishWork")
    }
    //Read worktime
    func readWorktime() {
        if UserDefaults.standard.object(forKey: "startWork") != nil && UserDefaults.standard.object(forKey: "finishWork") != nil {
            startWork = UserDefaults.standard.object(forKey: "startWork") as! Date
            finishWork = UserDefaults.standard.object(forKey: "finishWork") as! Date
        } else {
            startWork = Date(timeIntervalSinceReferenceDate: 0)
            finishWork = Date(timeIntervalSinceReferenceDate: 36000)
        }
        
    }
}
