//
//  LocationSearchTableViewController.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 25/05/21.
//

import UIKit
import MapKit

class LocationSearchTableViewController: UIViewController {

    @IBOutlet weak var tableViewOfCity: UITableView!
    var addCityView: AddCityViewController?
    var anotationDelegate: addAnotationCity?
    private let cellIdentifier = Constants.cityTableViewCell
    private var locationSearchModel : LocationSearchViewModel?
    var arrOfCity = [CityElement]() {
        didSet {
            tableViewOfCity.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSearchModel = LocationSearchViewModel()
        tableViewOfCity.tableFooterView = UIView()
        getUpdatedData()
    }
    
    func getUpdatedData() {
        arrOfCity = locationSearchModel?.getCityDate() ?? []
    }
}

// MARK: TableView Datasource and Delegate
extension LocationSearchTableViewController: UITableViewDataSource {
    /// Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfCity.count
    }
    
    /// cell for rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CityNameTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(item: arrOfCity[indexPath.row])
        return cell
    }
}

extension LocationSearchTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        anotationDelegate?.addAnotationAt(indexPath: indexPath, array: arrOfCity)
    }
}

