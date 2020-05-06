//
//  ViewController.swift
//  PlacesTest
//
//  Created by Sepandat Pourtaymour on 05/05/2020.
//  Copyright © 2020 Sepandat Pourtaymour. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

	var interactor = Interactor()
	var datasource = DataSource()
	var viewProperties = ViewProperties()
	
	var locationManager = CLLocationManager()
	
	var currentRadius = 1500
	var keyword = "surf"
	
	var results: SurfResults? {
		didSet {
			datasource.updateViewWithResults()
		}
	}
	
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var updateResultsBarItem: UIBarButtonItem!
	@IBOutlet weak var userLocateButton: UIButton!
	
	var dataSource: DataSource?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		interactor.controller = self
		datasource.controller = self
		mapView.delegate = interactor
		locationManager.delegate = interactor
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		interactor.checkLocationAuthorization()
	}
	
	@IBAction func selectRadius(_ sender: Any) {
		interactor.didTapOnRadiusSelector()
	}
	
	@IBAction func updateResults(_ sender: Any) {
		let userCoord = mapView.userLocation.coordinate
		datasource.updateSurfList(coordinate: userCoord, radius: currentRadius, keyword: keyword)
	}
	
	@IBAction func updateUserLocation(_ sender: Any) {
		mapView.zoomToUserLocation()
	}
	
	func updateUserTracking(_ isAuthorized: Bool) {
		updateResultsBarItem.isEnabled = isAuthorized
		mapView.showsUserLocation = isAuthorized
		
		if isAuthorized {
			mapView.setUserTrackingMode(.follow, animated: true)
		} else {
			mapView.setUserTrackingMode(.none, animated: true)
		}
	}
	
	deinit {
		viewProperties.waitingView.stopAnimating()
		interactor.controller = nil
		datasource.controller = nil
		
	}
}
