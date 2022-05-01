//
//  File.swift
//  Armageddon
//
//  Created by Денис on 26.04.2022.
//

import Foundation
import UIKit

protocol AsteroidsBuisnessLogic {
    func fetchAsteroids()
}

class AsteroidsInteractor {
    var presenter: AsteroidsPresentationLogic?
}

// MARK: - AsteroidsBuisnessLogic
extension AsteroidsInteractor: AsteroidsBuisnessLogic {

    func fetchAsteroids() {
        let network = NetworkManager()
        var response = [NearEarthObject]()
        network.getResults(from: network.getAsteroidUrl()!) {
            DispatchQueue.main.async {
                response = network.asteroids
                self.presenter?.present(data: response)
            }
        }
    }
}

