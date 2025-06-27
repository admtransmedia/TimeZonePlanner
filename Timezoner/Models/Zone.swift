//
//  Zone.swift
//  Timezoner
//
//  Created by Sergei Kriukov on 01.06.2022.
//

import Foundation
//TimeZone model
class Zone:Identifiable, Decodable {
    var identifier:String?
    var region:String?
    var cityOrCountry:String?
    var gmt:String?
}
