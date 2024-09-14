//
//  WeatherViewModelTests.swift
//  Weather
//
//  Created by Sam Ash on 8/29/24.
//


import XCTest
import CoreLocation
@testable import Weather

final class WeatherViewModelTests: XCTestCase {
    
    var viewModel: WeatherViewModel!
    var mockWeatherService: MockWeatherService!
    
    override func setUp() {
        super.setUp()
        mockWeatherService = MockWeatherService()
        viewModel = WeatherViewModel(weatherService: mockWeatherService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockWeatherService = nil
        super.tearDown()
    }
    
    func testFetchWeatherForCitySuccess() {
        // Given
        let mockWeather = Weather(
                coord: Coord(lon: -0.1257, lat: 51.5085),
                weather: [WeatherDetail(id: 800, main: "Clear", description: "clear sky", icon: "01d")],
                base: "stations",
                main: Main(temp: 297.35, feelsLike: 297.63, tempMin: 294.8, tempMax: 297.4, pressure: 1017, humidity: 69, seaLevel: nil, grndLevel: nil),
                visibility: 10000,
                wind: Wind(speed: 2.42, deg: 239, gust: 1.72),
                clouds: Clouds(all: 9),
                dt: 1724954313,
                sys: Sys(type: 2, id: 2004688, country: "GB", sunrise: 1724906152, sunset: 1724954302),
                timezone: 7200,
                id: 2643743,
                name: "London",
                cod: 200
            )
        
        mockWeatherService.mockWeather = mockWeather
        
        // When
        viewModel.fetchWeather(for: "London")
        
        // Then
        print("Expected city name: London")
        print("Actual city name: \(String(describing: viewModel.weather?.name))")
        XCTAssertEqual(viewModel.weather?.name, "London")
        XCTAssertEqual(viewModel.weather?.main.temp, 297.35)
    }
    
    func testFetchWeatherForCityFailure() {
        // Given
        mockWeatherService.shouldReturnError = true
        
        // When
        viewModel.fetchWeather(for: "London")
        
        // Then
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertNil(viewModel.weather)
    }
    
    func testFetchWeatherByCurrentLocationSuccess() {
        // Given
        let mockWeather = Weather(
            coord: Coord(lon: 10.99, lat: 44.34),
            weather: [WeatherDetail(id: 800, main: "Clear", description: "clear sky", icon: "01d")],
            base: "stations",
            main: Main(temp: 297.35, feelsLike: 297.63, tempMin: 294.8, tempMax: 297.4, pressure: 1017, humidity: 69, seaLevel: nil, grndLevel: nil),
            visibility: 10000,
            wind: Wind(speed: 2.42, deg: 239, gust: 1.72),
            clouds: Clouds(all: 9),
            dt: 1724954313,
            sys: Sys(type: 2, id: 2004688, country: "IT", sunrise: 1724906152, sunset: 1724954302),
            timezone: 7200,
            id: 3163858,
            name: "London",
            cod: 200
        )
        
        mockWeatherService.mockWeather = mockWeather
        
        // When
        viewModel.locationManager(CLLocationManager(), didUpdateLocations: [CLLocation(latitude: 44.34, longitude: 10.99)])
        
        // Then
        XCTAssertEqual(viewModel.weather?.name, "London")
        XCTAssertEqual(viewModel.weather?.main.temp, 297.35)
    }
    
    func testFetchWeatherByCurrentLocationFailure() {
        // Given
        mockWeatherService.shouldReturnError = true
        
        // When
        viewModel.locationManager(CLLocationManager(), didUpdateLocations: [CLLocation(latitude: 44.34, longitude: 10.99)])
        
        // Then
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertNil(viewModel.weather)
    }
    
    func testFetchWeatherForLastSearchedCityOrCurrentLocation() {
        // Given
        let mockWeather = Weather(
            coord: Coord(lon: 10.99, lat: 44.34),
            weather: [WeatherDetail(id: 800, main: "Clear", description: "clear sky", icon: "01d")],
            base: "stations",
            main: Main(temp: 297.35, feelsLike: 297.63, tempMin: 294.8, tempMax: 297.4, pressure: 1017, humidity: 69, seaLevel: nil, grndLevel: nil),
            visibility: 10000,
            wind: Wind(speed: 2.42, deg: 239, gust: 1.72),
            clouds: Clouds(all: 9),
            dt: 1724954313,
            sys: Sys(type: 2, id: 2004688, country: "IT", sunrise: 1724906152, sunset: 1724954302),
            timezone: 7200,
            id: 3163858,
            name: "London",
            cod: 200
        )
        
        mockWeatherService.mockWeather = mockWeather
        
        // Simulate saving a city to UserDefaults
        UserDefaults.standard.set("Zocca", forKey: viewModel.lastSearchedCityKey)
        
        // When
        viewModel.fetchWeatherForLastSearchedCityOrCurrentLocation()
        
        // Then
        XCTAssertEqual(viewModel.weather?.name, "London")
        XCTAssertEqual(viewModel.weather?.main.temp, 297.35)
    }
}
