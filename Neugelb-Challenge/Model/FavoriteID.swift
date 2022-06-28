//
//  FavoriteID.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 25.06.2022.
//

import Foundation
struct ID: Codable {
    let results: [FavoriteMovie]
}
// MARK: - Result
struct FavoriteMovie: Codable {
    let id: Int
}
