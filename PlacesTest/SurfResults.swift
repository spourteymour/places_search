//
//  SurfResults.swift
//  PlacesTest
//
//  Created by Sepandat Pourtaymour on 06/05/2020.
//  Copyright © 2020 Sepandat Pourtaymour. All rights reserved.
//

import Foundation

struct SurfResults: Codable {
	var results: [SurfLodge]
	
	enum CodingKeys: String, CodingKey {
		case results
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.results = try container.decode([SurfLodge].self, forKey: .results)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(results, forKey: .results)
	}
}
