//
//  WDAlert.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/25.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

class WDAlert: NSObject {
 
    class func alert(title: String, message: String?, dismissTitle: String, inViewController viewController: UIViewController?, withDismissAction dismissAction: (() -> Void)?) {

        DispatchQueue.main.async {

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let action: UIAlertAction = UIAlertAction(title: dismissTitle, style: .default) { action in
                if let dismissAction = dismissAction {
                    dismissAction()
                }
            }
            alertController.addAction(action)
   
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func alertSorry(message: String?, inViewController viewController: UIViewController?, withDismissAction dismissAction: @escaping () -> Void) {
        alert(title: NSLocalizedString("Sorry", comment: ""), message: message, dismissTitle: NSLocalizedString("OK", comment: ""), inViewController: viewController, withDismissAction: dismissAction)
    }
    
    class func alertSorry(message: String?, inViewController viewController: UIViewController?) {
        alert(title: NSLocalizedString("Sorry", comment: ""), message: message, dismissTitle: NSLocalizedString("OK", comment: ""), inViewController: viewController, withDismissAction: nil)
    }

}
