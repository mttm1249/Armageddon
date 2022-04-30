//
//  AsteroidCell.swift
//  Armageddon
//
//  Created by Денис on 25.04.2022.
//

import UIKit
import Kingfisher

protocol CellDelegate: AnyObject {
    func didTapButton(with asteroidName: String)
    func deleteCell(from index: IndexPath)
}

class AsteroidCell: UITableViewCell {
    
    weak var delegate: CellDelegate?
    private var asteroidName: String = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var diametrLabel: UILabel!
    @IBOutlet weak var aproachLabel: UILabel!
    @IBOutlet weak var missDistanceLabel: UILabel!
    @IBOutlet weak var hazardLabel: UILabel!
    @IBOutlet weak var asteroidImage: UIImageView!
    
    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var cellTopImage: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    func setup(data: AsteroidCellModel) {
        let name = data.name
        let newName = name
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let diametr: Double = (data.diametr as NSString).doubleValue
        let distanceKm: Double = (data.missDistanceKm as NSString).doubleValue
        let distanceLun: Double = (data.missDistanceLun as NSString).doubleValue


        let dateString = data.aproach
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:dateString)!
        let format = date.getFormattedDate(format: "d, MMMM, yyyy")
            .replacingOccurrences(of: ",", with: " ")
            .replacingOccurrences(of: ".", with: " ")
        
        aproachLabel.text = "Подлетает \(format)"
        
        
        nameLabel.text = newName
        diametrLabel.text = "Диаметр: \(String(format: "%.0f", diametr)) м"
        
        let distanceString = numberFormatter.string(from: distanceKm as NSNumber)?
            .replacingOccurrences(of: ",", with: " ")
            .replacingOccurrences(of: ".", with: " ")
        
            switch filter.distanceOption {
            case "km":
                missDistanceLabel.text = "на расстояние \(distanceString!) км"
            case "lun":
                missDistanceLabel.text = "на расстояние \(String(format: "%.0f", distanceLun)) лунных орбит"
            default:
                missDistanceLabel.text = "на расстояние \(distanceString!) км"
        }
        
        switch diametr {
        case 0...299:
            let url = URL(string: "https://i.ibb.co/BN0L4gH/little-Asteroid.png")
            asteroidImage.loadingIndicator()
            asteroidImage.kf.setImage(with: url)
        case 300...850:
            let url = URL(string: "https://i.ibb.co/r3zZ3yM/medium-Asteroid.png")
            asteroidImage.loadingIndicator()
            asteroidImage.kf.setImage(with: url)
        default:
            let url = URL(string: "https://i.ibb.co/n7gM38B/huge-Asteroid.png")
            asteroidImage.loadingIndicator()
            asteroidImage.kf.setImage(with: url)
        }
        
        
        if data.isPotentiallyHazardousAsteroid == true {
            hazardLabel.textColor = .red
            hazardLabel.text = "опасен"
            cellTopImage.image = #imageLiteral(resourceName: "cellBackgroundRed")
        } else {
            hazardLabel.textColor = .black
            hazardLabel.text = "не опасен"
            cellTopImage.image = #imageLiteral(resourceName: "cellBackgroundGreen")
        }
        // Get asteroid name for UserDefaults
        asteroidName = data.name
    }
    
    
    @IBAction func destroyButtonTapped(_ sender: Any) {
        feedbackGenerator.impactOccurred()
        delegate?.didTapButton(with: asteroidName)
        let userDefaults = UserDefaults.standard
        if let text = nameLabel.text {
            userDefaults.appendToDestroyArray(by: text)
        }
        let index = self.indexPath
        delegate?.deleteCell(from: index!)
    }
}
