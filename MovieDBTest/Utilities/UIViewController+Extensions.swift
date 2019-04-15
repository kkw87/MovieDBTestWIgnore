//
//  UIViewController+Extensions.swift
//  MovieDBTest
//
//  Created by Kevin Wang on 4/14/19.
//  Copyright © 2019 Kevin Wang. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWith(title: String, bodyMessage message : String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}
