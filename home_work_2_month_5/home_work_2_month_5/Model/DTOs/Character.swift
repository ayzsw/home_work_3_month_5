//
//  Character.swift
//  home_work_2_month_5
//
//  Created by Аяз on 4/7/23.
//

import Foundation

struct Characters: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
}
