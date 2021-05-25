//
//  HomeViewModel.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 24/05/21.
//

import UIKit

class HomeViewModel: NSObject {
    var cityObject = [CityBookMarked]() {
        didSet {
            self.bindViewModelToController()
        }
    }

    var bindViewModelToController : () -> () = {}
    
    func fetchDataFromLocal() {
        cityObject = DatabaseManager.shared.fetchDataFromCoreData()
    }
    
    func deleteData(cityObject: CityBookMarked) {
        DatabaseManager.shared.deleteDataFromCoreData(cityObject: cityObject)
    }
}
