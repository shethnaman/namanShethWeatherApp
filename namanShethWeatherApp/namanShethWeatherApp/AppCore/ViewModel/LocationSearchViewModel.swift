//
//  LocationSearchViewModel.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 25/05/21.
//

import UIKit

class LocationSearchViewModel: NSObject {

    
    func getCityDate() -> [CityElement] {
        guard let url = Bundle.main.url(forResource: "city.list", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return []
        }
        do {
            let cityList = try JSONDecoder().decode(Array<CityElement>.self, from: data)
            return cityList
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
