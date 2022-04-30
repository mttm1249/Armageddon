//
//  NetworkManager.swift
//  Armageddon
//
//  Created by Денис on 26.04.2022.
//

import Foundation

class NetworkManager {
    
    // MARK: - Properties
    var errorMessage = String()
    let decoder = JSONDecoder()
    
    // MARK: - URL
    var asteroidUrl = URLComponents(string: "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(dateString)")
    
    // MARK: - ApiKey
    let apiKey = URLQueryItem(name: "api_key", value: "ldm3J4dVdlgkJN8VnPibZU6ygxfDwEhBlHlUXVgQ")
    
    func getAsteroidUrl() -> URL? {
        asteroidUrl?.queryItems?.append(apiKey)
        return asteroidUrl?.url
    }
    
    // MARK: - Object
    var asteroids = [NearEarthObject]()
    
    // MARK: - Network
    
    // Parsing for AsteroidsViewController
    func getResults(from url: URL, completion: @escaping () -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            self.updateResultsAsteoid(data)
            
            completion()
        }.resume()
    }
    
    fileprivate func updateResultsAsteoid(_ data: Data) {
        decoder.dateDecodingStrategy = .iso8601
        do {
            let rawFeed = try decoder.decode(Asteroids.self, from: data)
            time.addingDay(2)
            for date in dateArray {
                asteroids.append(contentsOf: rawFeed.nearEarthObjects[date] ?? [])
            }
        } catch let decodeError as NSError {
            errorMessage += "Decoder error: \(decodeError.localizedDescription)"
            return
        }
    }
    
    // Parsing for DetailsViewController
    func loadJson(fromURLString urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }
}
