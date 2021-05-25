//
//  WeatherCollectionViewCell.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 26/05/21.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelMinTemp: UILabel!
    @IBOutlet weak var labelMaxTemp: UILabel!
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var labelWindSpeed: UILabel!
    @IBOutlet weak var labelFeelsLike: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelRainChances: UILabel!
    
    
    
    func configureCell(list: List) {
        labelDate.text = list.dtTxt
        labelTemp.text = String(list.main.temp)
        labelMinTemp.text = String(list.main.tempMin)
        labelMaxTemp.text = String(list.main.tempMax)
        labelWeather.text = list.weather.first?.weatherDescription.rawValue
        labelWindSpeed.text = String(list.wind.speed)
        labelFeelsLike.text = String(list.main.feelsLike)
        labelHumidity.text = String(list.main.humidity)
        labelRainChances.text = String(list.rain?.the3H ?? 0)
    }
}
