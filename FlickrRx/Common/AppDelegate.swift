//
//  AppDelegate.swift
//  FlickrRx
//
//  Created by Luis López on 8/8/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var mainWindow = UIWindow()
    private let router = AppCoordinator().strongRouter

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        router.setRoot(for: mainWindow)
        return true
    }
}

