//
//  SurfLodge.swift
//  PlacesTest
//
//  Created by Sepandat Pourtaymour on 05/05/2020.
//  Copyright © 2020 Sepandat Pourtaymour. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class SurfLodge: NSObject, Codable {
	var name: String
	var isOpen: Bool
	var coordinates: CLLocationCoordinate2D
	var rating: Float
	var icon: String

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.name = try container.decode(String.self, forKey: .name)
		self.icon = try container.decode(String.self, forKey: .icon)
		
		let geometry = try container.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
		let location = try geometry.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
		let lat = try location.decode(Double.self, forKey: .lat)
		let lon = try location.decode(Double.self, forKey: .lng)
		self.coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
		
		self.rating = (try? container.decode(Float.self, forKey: .rating)) ?? -1

		self.isOpen = (try? container.nestedContainer(keyedBy: OpeningHoursKeys.self, forKey: .opening_hours).decode(Bool.self, forKey: .open_now)) ?? false
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		var geometry = container.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
		var location = geometry.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
		var openingTimes = container.nestedContainer(keyedBy: OpeningHoursKeys.self, forKey: .opening_hours)

		try container.encode(name, forKey: .name)
		try container.encode(icon, forKey: .icon)
		try container.encode(rating, forKey: .rating)

		try location.encode(coordinates.latitude, forKey: .lat)
		try location.encode(coordinates.longitude, forKey: .lng)

		try openingTimes.encode(isOpen, forKey: .open_now)
	}
	
	enum GeometryKeys: String, CodingKey {
		case location
	}
	
	enum LocationKeys: String, CodingKey {
		case lat
		case lng
	}
	
	enum OpeningHoursKeys: String, CodingKey {
		case open_now
	}
	
	enum CodingKeys: String, CodingKey {
		case name,opening_hours,open_now,rating, icon,geometry,location,lat,lng
	}
}

extension SurfLodge: MKAnnotation {
	var coordinate: CLLocationCoordinate2D {
		return self.coordinates
	}
	
	var title: String? {
		return name
	}
	
	var subtitle: String? {
		var ratingString = "Rating"
		
		if self.rating == -1 {
			//Rating not available
			ratingString += " Not Available"
		} else {
			ratingString += ": \(rating)"
		}
		
		let openString = isOpen ? "Yes" : "No"
		
		ratingString += " | Is Open: \(openString)"
		
		return ratingString
	}
}
