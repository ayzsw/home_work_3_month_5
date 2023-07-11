//
//  CharactersViewModel.swift
//  home_work_2_month_5
//
//  Created by Аяз on 10/7/23.
//

import Foundation

class CharactersViewModel {
    let networkService: NetworkService
    
    init() {
        self.networkService = NetworkService()
    }
    
    func fetchCharacters() async throws -> [Character] {
        try await networkService.fetchCharacter()
    }
}
