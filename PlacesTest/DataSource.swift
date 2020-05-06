//
//  DataSource.swift
//  PlacesTest
//
//  Created by Sepandat Pourtaymour on 06/05/2020.
//  Copyright © 2020 Sepandat Pourtaymour. All rights reserved.
//

import Foundation
import CoreLocation

class DataSource: NSObject {
	var controller: ViewController?
	
	func updateViewWithResults() {
			self.controller?.mapView.annotations.forEach {
				self.controller?.mapView.removeAnnotation($0)
			}
			
			guard let surfPlaces = self.controller?.results?.results else { return }
		
			surfPlaces.forEach {
				self.controller?.mapView.addAnnotation($0)
			}
	}

	func updateSurfList(coordinate: CLLocationCoordinate2D, radius: Int, keyword: String) {
		if let navVC = controller?.navigationController {
			controller?.viewProperties.waitingView.animate(in: navVC.view)
		} else if let viewController = controller {
			viewController.viewProperties.waitingView.animate(in: viewController.view)
		}
		APIClient.fetchPlaces(coordinate: coordinate, radius: radius, keyword: keyword, completion: { (result) in
			switch result {
			case .success(let surfs):
				DispatchQueue.main.async {
					self.controller?.viewProperties.waitingView.stopAnimating()
					self.controller?.results = surfs
				}
			default:
				//TODO: Report some sort of error
				break
			}
		})
	}

}
