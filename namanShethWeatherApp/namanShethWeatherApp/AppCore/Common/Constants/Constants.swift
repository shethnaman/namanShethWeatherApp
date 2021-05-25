//
//  Constants.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 16/05/21.
//

import Foundation

struct Constants {
    static let cityTableViewCell = "CityNameTableViewCell"
    static let apiURL = "http://api.openweathermap.org/data/2.5/"
    static let apiKey = "fae7190d7e6433ec3a45285ffcf55c86"
    static let coreDataEntitiy = "CityBookMarked"
    static let locationResult = "LocationSearchTableViewController"
    static let weatherCell = "WeatherCollectionViewCell"
   
}

/// getDate to make operation for date related
///
/// - Parameter time: String value of time
/// - Returns: Date object
func getDate(time: Int) -> String {
    let timeInterval = TimeInterval(time)
    // create NSDate from Double (NSTimeInterval)
    let myNSDate = Date(timeIntervalSince1970: timeInterval)
    
    let dateFormater = DateFormatter()
    dateFormater.dateStyle = .full
    dateFormater.timeStyle = .full
    return dateFormater.string(from: myNSDate)
}
