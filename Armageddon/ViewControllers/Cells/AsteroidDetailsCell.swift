//
//  AsteroidDetailsCell.swift
//  Armageddon
//
//  Created by Денис on 30.04.2022.
//

import UIKit

class AsteroidDetailsCell: UITableViewCell {
    @IBOutlet weak var approachDateFullLabel: UILabel!
    @IBOutlet weak var relativeVelocityLabel: UILabel!
    @IBOutlet weak var missDistanceLabel: UILabel!
    @IBOutlet weak var orbitingBodyLabel: UILabel!
    
    func setup(data: CurrentCloseApproachDates) {
        let speed: Double = (data.relativeVelocity.kilometersPerHour as NSString).doubleValue
        let distanceKm: Double = (data.missDistance.kilometers as NSString).doubleValue
        
        // Set up converted information
        approachDateFullLabel.text = "Дата максимального сближения с землей: \(data.closeApproachDateFull)"
        relativeVelocityLabel.text = "Скорость относительно земли: \(String(format: "%.0f", speed)) км/час"
        missDistanceLabel.text = "Расстояние до земли: \(String(format: "%.0f", distanceKm)) км"
        orbitingBodyLabel.text = "Летит вокруг орбиты: \(data.orbitingBody)"
    }
}
