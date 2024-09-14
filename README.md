# weather
This project is a simple Weather App built using SwiftUI and the MVVM (Model-View-ViewModel) architecture pattern. The app fetches weather data for a specified city or automatically based on the user's current location using the OpenWeatherMap API. The project also includes unit tests to ensure the core functionalities are working as expected.

Features

- Search Weather by City: Users can search for weather data by entering a city name.
- Fetch Weather by Current Location: The app requests the user's location and fetches weather data for their current location.
- Weather Icon Display: Displays the appropriate weather icon based on the current weather condition.
- Auto-fetch Last Searched City: The app saves the last searched city and automatically fetches its weather data on app launch.
- Dependency Injection: Used for injecting dependencies into the ViewModel to improve testability and modularity.
- Unit Tests: Includes unit tests to verify the functionality of fetching weather data by city and location.

Architecture

The app is built using the MVVM (Model-View-ViewModel) architecture pattern, which promotes a clear separation of concerns and makes the code more modular and testable.

Components:

1. Model: Represents the data structures used in the app, such as ‘Weather’, ‘Coord’, ‘Main’, ‘Wind’, etc.
2. ViewModel: 'WeatherViewModel' handles the business logic, fetching data from the weather service, and preparing data for the view.
3. View: The UI built using SwiftUI, displaying weather information to the user.

Setup and Installation

1. Clone the repository: 
git clone https://github.com/osamaashraf2005/weather.git

2. Open the project in Xcode:
   - Open 'Weather.xcodeproj' in Xcode.

3. Dependencies:
   - Note: I did not use any CocoaPods dependencies or other package managers for simplicity purposes. All code is written using native Swift and SwiftUI.

4. OpenWeatherMap API Key:
   - I hardcoded the OpenWeatherMap Key in the Service

5. Run the app:
   - Build and run the app on the simulator or a physical device.

Usage

- Search for Weather: Enter a city name in the search bar and tap "Get Weather" to fetch the weather data for that city.
- Use Current Location: Tap the "Use Current Location" button to fetch weather data for your current location.
- Auto-fetch Last Searched City: The app will automatically fetch weather data for the last searched city on launch.

Unit Testing

The project includes unit tests to ensure the reliability of core functionalities. The tests cover:

1. Fetching weather data by city.
2. Fetching weather data based on the current location.
3. Handling errors during weather data fetching.
4. Fetching weather data for the last searched city or the current location on app launch.

Note on Testing

Due to a shortage of time, the unit tests were implemented but not executed. We recommend running the tests to ensure that the core functionalities behave as expected.

Running Tests:

1. Open the Test Navigator in Xcode (Command + 6).
2. Select the test cases and run them individually or all at once.
3. Verify that all tests pass.

Acknowledgements

- OpenWeatherMap: for providing the weather API.
