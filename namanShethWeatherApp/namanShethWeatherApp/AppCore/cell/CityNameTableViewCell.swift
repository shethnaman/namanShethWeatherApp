//
//  CityNameTableViewCell.swift
//  namanShethWeatherApp
//
//  Created by Naman Sheth on 23/05/21.
//

import UIKit

class CityNameTableViewCell: UITableViewCell {

    @IBOutlet weak var labelCityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// configureCell
    ///
    /// - Parameters item: holds data of  City type
    func configureCell(item: CityElement) {
        labelCityName.text = item.name
    }
    
    /// configureCell
    ///
    /// - Parameters item: holds data of  City type
    func configureHomeCell(item: CityBookMarked) {
        labelCityName.text = item.name
    }
    

}
