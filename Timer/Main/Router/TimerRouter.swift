//
//  TimerRouter.swift
//  Timer
//
//  Created by Мехрафруз on 30.08.2021.
//  
//

import UIKit

final class TimerRouter {
    weak var viewController: UIViewController?
}

extension TimerRouter: TimerRouterInput {
    
    func show(_ error: Error) {
        let message: String = (error as? NetworkError)?.errorDescription ?? error.localizedDescription
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        viewController?.present(alertController, animated: true, completion: nil)
    }
}
