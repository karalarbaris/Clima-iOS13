
struct WeatherManager {
    let weatherUrl = "http://api.openweathermap.org/data/2.5/weather?appid=d2ba5dfb7d4821a8e14a3fc0b41625f4&units=metric"
    
    func fetchWeather(cityName: String) -> String {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        return urlString
    }
    
    
}
