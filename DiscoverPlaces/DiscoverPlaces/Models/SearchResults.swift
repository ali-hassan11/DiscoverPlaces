//
//  SearchResults.swift
//  DiscoverPlaces
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 AHApps. All rights reserved.
//

struct Response: Decodable {
    let results: [Result]
    let next_page_token: String?
}

struct Result: Decodable {
    let name: String
    let photos: [Photo]?
}

struct Photo: Decodable {
    let photo_reference: String
    let height: Int
    let width: Int
}
