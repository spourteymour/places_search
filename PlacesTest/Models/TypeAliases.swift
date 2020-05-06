//
//  TypeAliases.swift
//  PlacesTest
//
//  Created by Sepandat Pourtaymour on 05/05/2020.
//  Copyright © 2020 Sepandat Pourtaymour. All rights reserved.
//

import Foundation

typealias APIResponse<T: Codable> = (Result<T, AppError>)->()
