//
//  CustomActivityIndicator.swift
//  Armageddon
//
//  Created by Денис on 01.05.2022.
//

import UIKit

class RotatingCirclesView: UIView {
    
    let circle1 = UIView(frame: CGRect(x: 20, y: 20, width: 60, height: 60))
    let circle2 = UIView(frame: CGRect(x: 120, y: 20, width: 60, height: 60))
    
    let positions: [CGRect] = [CGRect(x: 30, y: 20, width: 60, height: 60), CGRect(x: 60, y: 15, width: 70, height: 70), CGRect(x: 110, y: 20, width: 60, height: 60), CGRect(x: 60, y: 25, width: 50, height: 50)]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        let color1   = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        let color2   = #colorLiteral(red: 0.004076097161, green: 0.4792365432, blue: 1, alpha: 1)
        
        translatesAutoresizingMaskIntoConstraints = false

        circle1.backgroundColor = color1.withAlphaComponent(0.9)
        circle1.layer.cornerRadius = circle1.frame.width / 2
        circle1.layer.zPosition = 2
        
        circle2.backgroundColor = color2.withAlphaComponent(0.9)
        circle2.layer.cornerRadius = circle2.frame.width / 2
        circle2.layer.zPosition = 1
        
        addSubview(circle1)
        addSubview(circle2)
    }
    
    func animate(_ circle: UIView, counter: Int) {
        var counter = counter
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: {
            circle.frame = self.positions[counter]
            circle.layer.cornerRadius = circle.frame.width / 2
            
            switch counter {
            case 1:
                if circle == self.circle1 { self.circle1.layer.zPosition = 2 }
            case 3:
                if circle == self.circle1 {self.circle1.layer.zPosition = 0 }
            default:
                break
            }
        }) { (completed) in
            switch counter {
            case 0...2:
                counter += 1
            case 3:
                counter = 0
            default:
                break
            }
            self.animate(circle, counter: counter)
        }
    }
}
