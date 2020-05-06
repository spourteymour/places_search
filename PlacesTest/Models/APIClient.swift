//
//  APIClient.swift
//  PlacesTest
//
//  Created by Sepandat Pourtaymour on 05/05/2020.
//  Copyright © 2020 Sepandat Pourtaymour. All rights reserved.
//

import Foundation
import CoreLocation

class APIClient {
	static func performFetch(coordinate: CLLocationCoordinate2D, radius: Int, keyword: String, completion: @escaping APIResponse<Data>) {
		let baseUrlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
		var components = URLComponents(string: baseUrlString)
		var queryItems = [URLQueryItem]()
		queryItems.append(URLQueryItem(name: "location", value: "\(coordinate.latitude),\(coordinate.longitude)"))
		queryItems.append(URLQueryItem(name: "radius", value: "\(radius)"))
		
		//TODO: I added this because adding the keyboard surf wouldn't return anything, so I added this so if we don't provide any information, we don't add anything
		if !keyword.isEmpty {
			queryItems.append(URLQueryItem(name: "keyword", value: keyword))
		}
		queryItems.append(URLQueryItem(name: "type", value: "lodging"))
		queryItems.append(URLQueryItem(name: "key", value: KeyManager.placesAPIKey))
		components?.queryItems = queryItems
	
		guard let url = components?.url else { return }
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let data = data {
				completion(.success(data))
			} else {
				if let error = error {
					completion(.failure(.appError(error: error)))
				} else {
					completion(.failure(.downloadError(url: url.absoluteString)))
				}
			}
		}.resume()
	}
	
	static func fetchPlaces(coordinate: CLLocationCoordinate2D, radius: Int, keyword: String, completion: @escaping APIResponse<SurfResults>) {
		performFetch(coordinate: coordinate, radius: radius, keyword: keyword) { (result) in
			switch result {
			case .success(let data):
				do {
					let lodgers = try JSONDecoder().decode(SurfResults.self, from: data)
					completion(.success(lodgers))
				} catch {
					completion(.failure(.appError(error: error)))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
