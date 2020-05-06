//
//  String+Extensions.swift
//  PlacesTest
//
//  Created by Sepandat Pourtaymour on 05/05/2020.
//  Copyright © 2020 Sepandat Pourtaymour. All rights reserved.
//

import Foundation

extension String {
	var intValue: Int? {
		return NumberFormatter().number(from: self)?.intValue
	}
}
