//
//  AddCityViewController.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 24/05/21.
//

import UIKit
import MapKit

///Protocol to add map pin from tableView delegate
protocol addAnotationCity {
    func addAnotationAt(indexPath: IndexPath, array: [CityElement])
}

class AddCityViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationSearchView: LocationSearchTableViewController?
    var selectedPin: MKPlacemark? = nil
    var resultSearchController: UISearchController? = nil
    let locationManager = CLLocationManager()
    var addCityModel: AddCityViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        locationSearchView = storyBoard.instantiateViewController(withIdentifier: Constants.locationResult) as? LocationSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchView)
        resultSearchController?.searchResultsUpdater = self
        resultSearchController?.searchBar.delegate = self
        navigationItem.searchController = resultSearchController
        locationSearchView?.anotationDelegate = self
        addCityModel = AddCityViewModel()
    }
}

// MARK: SearchBar deleagate
extension AddCityViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        if !text.isEmpty {
            let resultArray = locationSearchView?.arrOfCity.filter({ (CityElement) in
                CityElement.name.contains(text)
            })
            locationSearchView?.arrOfCity = resultArray ?? []
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        locationSearchView?.getUpdatedData()
        
    }
}

// MARK: MapviewDelegate
extension AddCityViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
}

extension AddCityViewController: addAnotationCity {
    func addAnotationAt(indexPath: IndexPath, array: [CityElement]) {
        let place = MKPointAnnotation()
        place.title = array[indexPath.row].name
        place.coordinate = CLLocationCoordinate2D(latitude: Double(array[indexPath.row].lat)!, longitude: Double(array[indexPath.row].lon)!)
        mapView.addAnnotation(place)
        mapView.reloadInputViews()
    
        addCityModel?.saveDataInLocal(city: array[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
