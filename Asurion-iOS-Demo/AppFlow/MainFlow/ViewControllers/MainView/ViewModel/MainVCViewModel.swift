//
//  MainVCViewModel.swift
//  Asurion-iOS-Demo
//
//  Created by Tyler Wells on 8/23/20.
//  Copyright © 2020 Tyler Wells. All rights reserved.
//

import Foundation

struct RawPetsResponse: Decodable {
    var pets: [Pet]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: APIKeys.Response.PetsResponse.self)
        self.pets = try values.decode([Pet].self, forKey: .pets)
    }
}

final class MainVCViewModel {
    //Listeners
    var onConfigUpdated: (() -> Void)?
    var onPetsUpdated: (() -> Void)?
    
    //Status Checks
    var networkIsBusy: Bool {return isFetchingPets || isFetchingConfig}
    fileprivate var isFetchingConfig: Bool = false
    fileprivate var isFetchingPets: Bool = false
    
    //Model Variables
    var config: AppConfiguration?
    var pets: [Pet]?
    
    func fetchConfig() {
        isFetchingConfig = true
        APISession(urlSession: .shared).getData(apiRoute: APIRoutes.getConfig) { [weak self] result in
            self?.isFetchingConfig = false
            switch result {
            case .success(let data):
                do {
                    self?.config = try JSONDecoder().decode(AppConfiguration.self, from: data)
                    self?.onConfigUpdated?()
                } catch {
                    
                }
            case .failure(_):
                return
            }
        }
    }
    
    func fetchPets() {
        print("fetching pets")
        isFetchingPets = true
        APISession(urlSession: .shared).getData(apiRoute: APIRoutes.getPets) { [weak self] result in
            self?.isFetchingPets = false
            switch result {
            case .success(let data):
                print("pets fetch successful")
                do {
                    self?.pets = try JSONDecoder().decode(RawPetsResponse.self, from: data).pets
                    self?.onPetsUpdated?()
                } catch {
                }
            case .failure(_):
                return
            }
        }
    }
}
