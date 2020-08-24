//
//  RawPetsResponseObject.swift
//  Asurion-iOS-Demo
//
//  Created by Tyler Wells on 8/25/20.
//  Copyright © 2020 Tyler Wells. All rights reserved.
//

import Foundation
struct PetsRawResponse: Decodable {
    var pets: [Pet]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: APIKeys.Response.PetsResponse.self)
        self.pets = try values.decode([Pet].self, forKey: .pets)
    }
}
