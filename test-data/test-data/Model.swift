//
//  Model.swift
//  test-data
//
//  Created by Macbook Pro on 10.04.2021.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let alt_description: String?
    let urls: [String: String]
}
