//
//  MainVCViewModel.swift
//  Asurion-iOS-Demo
//
//  Created by Tyler Wells on 8/23/20.
//  Copyright © 2020 Tyler Wells. All rights reserved.
//

import Foundation

final class MainVCViewModel {
    
    //MARK: - Listeners
    var onConfigUpdated: (() -> Void)?
    var onPetsUpdated: (() -> Void)?
    
    //MARK: - Status Checks
    //TODO: Add Loader View
    var isNetworkBusy: Bool {return isFetchingPets || isFetchingConfig}
    fileprivate var isFetchingConfig: Bool = false
    fileprivate var isFetchingPets: Bool = false
    
    //MARK: - Model Variables
    var config: AppConfiguration?
    var pets: [Pet]?
    
    //MARK: - Networking
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
                    print(error)
                }
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    func fetchPets() {
        isFetchingPets = true
        APISession(urlSession: .shared).getData(apiRoute: APIRoutes.getPets) { [weak self] result in
            self?.isFetchingPets = false
            switch result {
            case .success(let data):
                do {
                    self?.pets = try JSONDecoder().decode(PetsRawResponse.self, from: data).pets
                    self?.onPetsUpdated?()
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error.description)
            }
        }
    }
}
