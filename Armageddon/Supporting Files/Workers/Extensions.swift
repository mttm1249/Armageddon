//
//  Extensions.swift
//  Armageddon
//
//  Created by Денис on 25.04.2022.
//

import UIKit

// MARK: Activate vibration
let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)

// Working with shadows
extension UIView {
    func applyShadow(shadowRadius: CGFloat) {
        layer.cornerRadius = shadowRadius
        layer.masksToBounds = false
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.20
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}

// MARK: AsteroidsViewController - CellDelegate Methods
extension AsteroidsViewController: CellDelegate {
    // Set up indexPath for delete rows
    func deleteCell(from index: IndexPath) {
        deleteAsteroidCell(with: index)
    }
    
    // Getting asteroids name for UserDefaults
    func didTapButton(with asteroidName: String) {
        print("\(asteroidName)")
    }
}

// MARK: - UserDefaults
extension UserDefaults {
    func appendToDestroyArray(by string: String) {
        let userDefaults = UserDefaults.standard
        var strings: [String] = userDefaults.stringArray(forKey: "destroy") ?? []
        strings.append(string)
        userDefaults.set(strings, forKey: "destroy")
    }
}

// MARK: - UIResponder + UITableViewCell

// Getting indexPath for delete rows
extension UIResponder {
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }
    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}

// MARK: - DateFormatter
extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
       dateformat.locale = Locale(identifier: "ru_RU")

        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

// MARK: - Images activity indicator
extension UIImageView {
    func loadingIndicator() {
        var kf = self.kf
        kf.indicatorType = .activity
    }
}

// MARK: - AsteroidsViewController: UITableViewDelegate
extension AsteroidsViewController: UITableViewDelegate {}
