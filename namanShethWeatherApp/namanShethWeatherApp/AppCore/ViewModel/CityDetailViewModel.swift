//
//  CityDetailViewModel.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 24/05/21.
//

import UIKit

class CityDetailViewModel: NSObject {
    
    var apiService: NetworkManager?
    var weatherForeCast: Weather? {
        didSet {
            self.bindViewModelToController()
        }
    }

    var bindViewModelToController : (() -> ()) = {}

    required override init() {
        super.init()
        self.apiService = NetworkManager()
    }
    
    /// Function to call data
    func callForeCastData(latitude: String, loingitude: String) {
        apiService?.apiToGetWeatherForCast(lat: latitude, long: loingitude, completion: { [weak self]  (weatherObject) in
          guard self == self else { return }
            self?.weatherForeCast = weatherObject
        })
    }
}
