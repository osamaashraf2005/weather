//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Sam Ash on 8/29/24.
//

import Foundation
import CoreLocation
import Combine

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var weather: Weather?
    @Published var errorMessage: String?
    @Published var cityName: String = ""

    private let weatherService: WeatherServiceProtocol
    private let locationManager = CLLocationManager()

    //Making it public for test coverage
    let lastSearchedCityKey = "LastSearchedCity"

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func fetchWeather(for city: String) {
        // Save the last searched city
        UserDefaults.standard.set(city, forKey: lastSearchedCityKey)
        weatherService.getWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self?.weather = weather
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func fetchWeatherByCurrentLocation() {
        locationManager.requestLocation()
    }

    // Fetch weather for the last searched city or current location
    func fetchWeatherForLastSearchedCityOrCurrentLocation() {
        if let lastCity = UserDefaults.standard.string(forKey: lastSearchedCityKey) {
            fetchWeather(for: lastCity)
        } else {
            fetchWeatherByCurrentLocation()
        }
    }

    // CLLocationManagerDelegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let coordinates = Coord(lon: location.coordinate.longitude, lat: location.coordinate.latitude)
        
        weatherService.getWeather(by: coordinates) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self?.weather = weather
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = error.localizedDescription
    }
}
