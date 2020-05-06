//
//  AppError.swift
//  PlacesTest
//
//  Created by Sepandat Pourtaymour on 05/05/2020.
//  Copyright © 2020 Sepandat Pourtaymour. All rights reserved.
//

import Foundation

enum AppError: Error {
	case decodingError(type: String)
	case urlFormatError(url: String)
	case appError(error: Error)
	case downloadError(url: String)
}
