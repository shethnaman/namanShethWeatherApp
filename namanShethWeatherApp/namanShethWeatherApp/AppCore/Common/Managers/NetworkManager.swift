//
//  NetworkManager.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 16/05/21.
//

import Foundation

class NetworkManager {
    
    private let forecast = "forecast?"
    private let units = "metric"
    private let latString = "lat="
    private let lonString = "&lon="
    private let appidString = "&appid="
    private let unitsMetric = "&units=metric"
    
    /// apiToGetWeatherForCast is to call api
    ///
    /// - Parameters:
    ///   - lat: String varible
    ///   - long: String variable
    ///   - completion: escaping clouser for Weather
    func apiToGetWeatherForCast(lat: String, long: String, completion : @escaping (Weather) -> ()) {
        let url = Constants.apiURL + forecast + latString + lat + lonString + long + appidString + Constants.apiKey + unitsMetric
        let finalUrl = URL(string: url)
        guard let getUrl = finalUrl else { return }
        URLSession.shared.dataTask(with: getUrl) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let serverData = try decoder.decode(Weather.self, from: data)
               completion(serverData)
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
}
