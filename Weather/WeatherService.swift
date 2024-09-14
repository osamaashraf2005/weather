//
//  WeatherService.swift
//  Weather
//
//  Created by Sam Ash on 8/29/24.
//

import Foundation

class WeatherService: WeatherServiceProtocol {
    private let apiKey = "3c52f35f5cd60c9b7f65be7b49b0c477"
    
    func getWeather(for city: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        print("Requesting URL: "+urlString)
        performRequest(urlString: urlString, completion: completion)
    }
    
    func getWeather(by coordinates: Coord, completion: @escaping (Result<Weather, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.lat)&lon=\(coordinates.lon)&appid=\(apiKey)"
        print("Requesting URL: "+urlString)
        performRequest(urlString: urlString, completion: completion)
    }
    
    
//    For now I'm skipping the Geo-coder API since it's the same as other requests
//    fun getGeocode(by coordinates: String, completion: @escaping (Result<Weather, Error>) -> Void) {
//    }
    
    private func performRequest(urlString: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            print("Respone is here")
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
