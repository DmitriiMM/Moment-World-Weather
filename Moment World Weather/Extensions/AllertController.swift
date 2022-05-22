//
//  AllertController.swift
//  Moment World Weather
//
//  Created by Дмитрий Мартынов on 21.03.2022.
//

import Foundation
import UIKit

extension ViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, complitionHandler: @escaping (String) -> Void) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["Tyumen", "Moscow", "Munich", "London", "Washington"]
            tf.placeholder = cities.randomElement()
        }
        
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                complitionHandler(city)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        
        present(ac, animated: true, completion: nil)
    }
}
