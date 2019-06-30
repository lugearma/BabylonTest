//
//  UIAlertController.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/30/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func basicErrorAlert(error: Error, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        print(error.localizedDescription)
        return basicAlert(errorMessage: error.localizedDescription, handler: handler)
    }
    
    static func basicAlert(errorMessage: String, handler:  ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: "Basic error alert title"), message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Error alert OK button"), style: .default, handler: handler))
        return alert
    }
}
