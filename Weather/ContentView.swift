//
//  ContentView.swift
//  Weather
//
//  Created by Sam Ash on 8/29/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WeatherViewModel
        
    init() {
        // Injecting WeatherService into WeatherViewModel
        self.viewModel = WeatherViewModel(weatherService: WeatherService())
    }
    
    var body: some View {
        VStack {
            TextField("Enter city name", text: $viewModel.cityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                viewModel.fetchWeather(for: viewModel.cityName)
            }) {
                Text("Get Weather")
            }
            .padding()

            Button(action: {
                viewModel.fetchWeatherByCurrentLocation()
            }) {
                Text("Use Current Location")
            }
            .padding()

            if let weather = viewModel.weather {

                // Weather icon URL from the OpenWeatherMap API
                let iconUrl = "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "01d")@2x.png"

                // Asynchronously load and display the weather icon
                AsyncImage(url: URL(string: iconUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100) // Adjust the size as needed
                } placeholder: {
                   ProgressView() // Show a loading indicator while the image is being loaded
                }
                .padding()
                Text("Temperature in \(weather.name + " " + weather.sys.country): \(weather.main.temp)°C")
                Text("Description: \(weather.weather.first?.description ?? "N/A")")
                                    .font(.subheadline)
                                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchWeatherForLastSearchedCityOrCurrentLocation()
        }
    }
}


#Preview {
    ContentView()
}
