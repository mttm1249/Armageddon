//
//  AsteroidDetailsModel.swift
//  Armageddon
//
//  Created by Денис on 26.04.2022.
//

import Foundation

// MARK: - CurrentAsteroidDetails
struct CurrentAsteroidDetails: Codable {
    let closeApproachDates: [CurrentCloseApproachDates]
   
    enum CodingKeys: String, CodingKey {
        case closeApproachDates = "close_approach_data"
    }
}

// MARK: - CloseApproachDatum
struct CurrentCloseApproachDates: Codable {
    let closeApproachDate, closeApproachDateFull: String
    let epochDateCloseApproach: Int
    let relativeVelocity: CurrentRelativeVelocity
    let missDistance: CurrentMissDistance
    let orbitingBody: String

    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }
}

// MARK: - MissDistance
struct CurrentMissDistance: Codable {
    let astronomical, lunar, kilometers, miles: String
}

// MARK: - RelativeVelocity
struct CurrentRelativeVelocity: Codable {
    let kilometersPerSecond, kilometersPerHour, milesPerHour: String

    enum CodingKeys: String, CodingKey {
        case kilometersPerSecond = "kilometers_per_second"
        case kilometersPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }
}


