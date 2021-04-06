import Foundation

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=d2ba5dfb7d4821a8e14a3fc0b41625f4&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            //            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
//                    let dataString = String(data: safeData, encoding: .utf8)
                    
                    parseJSON(weatherData: safeData)
                }
            }
            //4. Start the task
            task.resume()
        }
    
    }
    
    func parseJSON(weatherData: Data) {
        
        let decoder = JSONDecoder()
        
        
        do {
            let decodeddata = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodeddata.main.temp)
            print(decodeddata.weather.description)
            print(decodeddata.weather[0].id)
            let id = decodeddata.weather[0].id
            print(getConditionName(weatherId: id))
        } catch {
            print(error)
        }
        
//        let data = WeatherData(name: weatherData[name])
    }
    
    func getConditionName(weatherId: Int) -> String{
        switch weatherId {
        case 200..<300: //Thunderstorm
            return "cloud.bolt"
        case 300..<400: //Drizzle
            return "cloud.drizzle"
        case 500..<600: //Rain
            return "cloud.rain"
        case 600..<700: //Snow
            return "cloud.snow"
        case 700..<800: //Atmosphere
            return "tornado"
        case 800: //Clear
            return "sun.max"
        case 801...804: //Cloud
            return "sun.max"
        default:
            return "cloud"
        }
    }
    
    
}
