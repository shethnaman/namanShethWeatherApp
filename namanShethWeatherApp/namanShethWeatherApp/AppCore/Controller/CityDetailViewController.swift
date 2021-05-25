//
//  CityDetailViewController.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 24/05/21.
//

import UIKit

class CityDetailViewController: UIViewController {

    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var labelSunrise: UILabel!
    @IBOutlet weak var labelSunset: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var cityObject: CityBookMarked?
    private var cityDetailModel: CityDetailViewModel?
    private let collectionViewCellIdentifier = Constants.weatherCell
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ForeCast Every 3 hour"
        self.labelCityName.text = cityObject?.name
        self.cityDetailModel = CityDetailViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let cityLat = cityObject?.lat ?? ""
        let cityLon = cityObject?.lon ?? ""
        self.latitude.text = cityLat
        self.longitude.text = cityLon
        self.cityDetailModel?.bindViewModelToController = {
            self.updateTableViewDataSource()
        }
        self.cityDetailModel?.callForeCastData(latitude: cityLat, loingitude: cityLon)
        self.labelSunrise.text = getDate(time: cityDetailModel?.weatherForeCast?.city.sunrise ?? 0)
        self.labelSunset.text = getDate(time: cityDetailModel?.weatherForeCast?.city.sunset ?? 0)
    }
    
    func updateTableViewDataSource() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: CollectionView Datasource and Delegate
extension CityDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityDetailModel?.weatherForeCast?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath as IndexPath) as? WeatherCollectionViewCell, let weather = cityDetailModel?.weatherForeCast else { return UICollectionViewCell() }
        cell.configureCell(list: weather.list[indexPath.row])
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = .cyan
        } else {
            cell.backgroundColor = .yellow
        }
        
        return cell
    }
    
}

extension CityDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
          return CGSize(width: 300, height: 300)
       }
}
