//
//  AsteroidsPresenter.swift
//  Armageddon
//
//  Created by Денис on 26.04.2022.
//

import Foundation

protocol AsteroidsPresentationLogic {
    func present(data: [NearEarthObject])
}

class AsteroidsPresenter {
    weak var viewController: AsteroidsViewController?
}

// MARK: - AsteroidsPresentationLogic
extension AsteroidsPresenter: AsteroidsPresentationLogic {
    
    func present(data: [NearEarthObject]) {
        let viewModelFullInfo = data.map { model -> AsteroidCellModel in
            let cellModelFullInfo = AsteroidCellModel(link: model.links.linksSelf,
                                                      name: model.name,
                                                      diametr: String(model.estimatedDiameter.meters.estimatedDiameterMax),
                                                      aproach: model.closeApproachData[0].closeApproachDate,
                                                      missDistanceKm: model.closeApproachData[0].missDistance.kilometers,
                                                      missDistanceLun: model.closeApproachData[0].missDistance.lunar,
                                                      isPotentiallyHazardousAsteroid: model.isPotentiallyHazardousAsteroid)
            return cellModelFullInfo
        }
        viewController?.load(data: viewModelFullInfo)
    }
}
