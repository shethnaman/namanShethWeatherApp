//
//  AddCityViewModel.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 24/05/21.
//

import UIKit

class AddCityViewModel: NSObject {
    

    func saveDataInLocal(city: CityElement) {
        if !DatabaseManager.shared.checkIfCityExist(type: city.name) {
            DatabaseManager.shared.saveDataInCoreData(with: city)
        }
    }

}
