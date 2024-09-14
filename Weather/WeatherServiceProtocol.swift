//
//  WeatherServiceProtocol.swift
//  Weather
//
//  Created by Sam Ash on 8/29/24.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeather(for city: String, completion: @escaping (Result<Weather, Error>) -> Void)
    func getWeather(by coordinates: Coord, completion: @escaping (Result<Weather, Error>) -> Void)
}
