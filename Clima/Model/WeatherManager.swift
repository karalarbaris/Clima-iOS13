import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFail(with error: Error)
}

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=d2ba5dfb7d4821a8e14a3fc0b41625f4&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(lat: CLLocationDegrees,lon: CLLocationDegrees) {
        let urlString = "\(weatherUrl)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            //            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    delegate?.didFail(with: error!)
                    return
                }
                if let safeData = data {
                    //                    let dataString = String(data: safeData, encoding: .utf8)
                    
                    if let weatherModel = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weatherModel)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        
        do {
            let decodeddata = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeddata.weather[0].id
            let temp = decodeddata.main.temp
            let name = decodeddata.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return weather
            
            
        } catch {
            print(error)
            delegate?.didFail(with: error)
            return nil
        }
        
        //        let data = WeatherData(name: weatherData[name])
    }
    
    
    
    
}
