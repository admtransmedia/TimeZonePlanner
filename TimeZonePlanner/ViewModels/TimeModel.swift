//
//  TimeModel.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 01.06.2022.
//

import Foundation
class TimeMOdel: ObservableObject {
    @Published var zones:[String] = [String]()
    
    init() {
        getTimeZonesList()
    }
    func getTimeZonesList() {
           //String path
        let urlString = "https://worldtimeapi.org/api/timezone"
        // create an URL object
        let url = URL(string: urlString)
        //Check if nil
        guard url != nil else {
            print("Error with urlString")
            return
        }
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        DispatchQueue.main.async {
            let dataTask = session.dataTask(with: request) { data, response, error in
                if error != nil {
                   
                    print("Cannot get data")
                    return
                } else {
                //Decode
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: [])
                    self.zones = result as! [String]
                   
                } catch {
                  
                    print("Cannot decode")
                    return
                }
            }
            }
            dataTask.resume()
        }
       
        
           
       }

    
    
    
}
