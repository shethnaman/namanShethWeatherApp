//
//  HomeViewController.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 22/05/21.
//

import MapKit
import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var filterdata = [CityBookMarked]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    private var cellIdentifier = Constants.cityTableViewCell
    private var isSearchBarInUsed = false
    var homeModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeModel = HomeViewModel()
        self.homeModel?.bindViewModelToController = {
            self.updateTableViewDataSource()
        }
        self.homeModel?.fetchDataFromLocal()
    }
    
    func updateTableViewDataSource() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: SearchBar 
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let cityObject = homeModel?.cityObject, !searchText.isEmpty {
            let resultArray =  cityObject.filter({ (city) in
                (city.name?.contains(searchText) ?? false)
            })
            filterdata = resultArray
        } else {
            self.homeModel?.fetchDataFromLocal()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearchBarInUsed = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchBarInUsed = false
        searchBar.text = ""
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }
}

// MARK: TableView Datasource and Delegate
extension HomeViewController: UITableViewDataSource {
    /// Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchBarInUsed {
            return filterdata.count
        } else {
            return homeModel?.cityObject.count ?? 0
        }
    }
    
    /// cell for rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CityNameTableViewCell, let cityModel = homeModel?.cityObject else {
            return UITableViewCell()
        }
        if isSearchBarInUsed {
            cell.configureHomeCell(item: filterdata[indexPath.row])
        } else {
            cell.configureHomeCell(item: cityModel[indexPath.row])
        }
        
        return cell
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        guard let cityDetail = storyBoard.instantiateViewController(withIdentifier: "CityDetailViewController") as? CityDetailViewController  else { return }
        if isSearchBarInUsed {
            cityDetail.cityObject = filterdata[indexPath.row]
            self.navigationController?.pushViewController(cityDetail, animated: true)
        } else {
            cityDetail.cityObject = homeModel?.cityObject[indexPath.row]
            self.navigationController?.pushViewController(cityDetail, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete), let cityArray = homeModel?.cityObject, !isSearchBarInUsed {
            homeModel?.cityObject.remove(at: indexPath.row)
            homeModel?.deleteData(cityObject: cityArray[indexPath.row])
            self.homeModel?.fetchDataFromLocal()
        } else {
            homeModel?.deleteData(cityObject: filterdata[indexPath.row])
            self.homeModel?.fetchDataFromLocal()
            self.isSearchBarInUsed = false
            self.searchBarCancelButtonClicked(searchBar)
        }
    }
}


