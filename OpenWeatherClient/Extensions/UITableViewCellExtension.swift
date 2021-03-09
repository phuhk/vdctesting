//
//  UITableViewCellExtension.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import UIKit

extension UITableViewCell {
    
    static func reuseIdentifier() -> String {
        String(describing: self)
    }
}
