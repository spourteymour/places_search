//
//  Interceptor.swift
//  PlacesTest
//
//  Created by Sepandat Pourtaymour on 06/05/2020.
//  Copyright © 2020 Sepandat Pourtaymour. All rights reserved.
//

import CoreLocation
import UIKit
import MapKit
import Kingfisher

class Interactor: NSObject {
	var controller: ViewController?
		
	func didTapOnRadiusSelector() {
		let alertController = UIAlertController(title: "Set call details", message: "Add your information", preferredStyle: .alert)
		
		alertController.addTextField(configurationHandler: { textfield in
			textfield.placeholder = "Radius"
			textfield.keyboardType = .numberPad
			textfield.text = "\(self.controller?.currentRadius ?? 1000)"
		})
		
		alertController.addTextField(configurationHandler: { textfield in
			textfield.placeholder = "Keyword"
			textfield.keyboardType = .alphabet
			textfield.text = "\(self.controller?.keyword ?? "surf")"
		})

		let saveAction = UIAlertAction(title: "OK", style: .default) { alert in
			if let radiusTextField = alertController.textFields?[0], let intValue = radiusTextField.text?.intValue {
				self.controller?.currentRadius = intValue
			}

			if let keywordTextField = alertController.textFields?[1], let keywork = keywordTextField.text {
				self.controller?.keyword = keywork
			}
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

		alertController.addAction(saveAction)
		alertController.addAction(cancelAction)

		controller?.present(alertController, animated: true, completion: nil)
	}
	
	func checkLocationAuthorization() {
		controller?.locationManager.delegate = self
		controller?.locationManager.requestWhenInUseAuthorization()
	}

}

extension Interactor: MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		let identifier = "myGeotification"
		
		if let surfAnnotation = annotation as? SurfLodge {
			var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
			
			if annotationView == nil {
				annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
				annotationView?.canShowCallout = true
				
				if let imageURL = URL(string: surfAnnotation.icon)  {
					KingfisherManager.shared.retrieveImage(with: imageURL) { result in
						// Do something with `result`
						switch result {
						case .success(let imageResult):
							DispatchQueue.main.async {
								annotationView?.leftCalloutAccessoryView = UIImageView(image: imageResult.image)
							}
						default:
							break
						}
					}
				}
			} else {
				annotationView?.annotation = annotation
			}
			
			return annotationView
		}
		
		return nil
	}
}

extension Interactor: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .authorizedAlways, .authorizedWhenInUse: controller?.updateUserTracking(true)
		default: controller?.updateUserTracking(false)
		}
	}
}
