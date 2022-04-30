//
//  Time.swift
//  Armageddon
//
//  Created by Денис on 26.04.2022.
//

import Foundation

// MARK: - Global variables
let time = Time()
var dateString = String()
var actualDate = Date()
var dateArray = [String]()

class Time {
    
    // MARK: - Properties
    let dateFormatter = DateFormatter()
    
    // MARK: - Methods
    func getData() {
        actualDate = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateArray.append(dateFormatter.string(from: actualDate))
        dateString = (dateFormatter.string(from: actualDate))
    }
    
    func addingDay(_ number: Int) {
        var dayComponent = DateComponents()
        let theCalendar = Calendar.current
        dayComponent.day = 1
        for _ in 0..<number {
        actualDate = theCalendar.date(byAdding: dayComponent, to: actualDate)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateArray.append(dateFormatter.string(from: actualDate))
        dateString = (dateFormatter.string(from: actualDate))
        }
    }
}
