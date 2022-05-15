//
//  AppDelegate.swift
//  Timer
//
//  Created by Мехрафруз on 30.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let context = TimerContext()
        let container = TimerContainer.assemble(with: context)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController =  UINavigationController(rootViewController: container.viewController)
        window?.makeKeyAndVisible()
        return true
    }
    
    
}

