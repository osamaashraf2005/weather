//
//  MockWeatherService.swift
//  Weather
//
//  Created by Sam Ash on 8/29/24.
//


import Foundation
import Combine

@testable import Weather
class MockWeatherService: WeatherServiceProtocol {
    var shouldReturnError = false
    var mockWeather: Weather?
    
    func getWeather(for city: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1, userInfo: nil)))
        } else {
            if let mockWeather = mockWeather {
                completion(.success(mockWeather))
            } else {
                completion(.failure(NSError(domain: "MockNoData", code: -1, userInfo: nil)))
            }
        }
    }
    
    func getWeather(by coordinates: Coord, completion: @escaping (Result<Weather, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1, userInfo: nil)))
        } else {
            if let mockWeather = mockWeather {
                completion(.success(mockWeather))
            } else {
                completion(.failure(NSError(domain: "MockNoData", code: -1, userInfo: nil)))
            }
        }
    }
}
