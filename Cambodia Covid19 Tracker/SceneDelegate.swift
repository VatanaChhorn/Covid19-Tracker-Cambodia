//
//  SceneDelegate.swift
//  Cambodia Covid19 Tracker
//
//  Created by Chhorn Vatana on 7/9/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let defaults = UserDefaults.standard
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        //Set internet connection to false
        defaults.set(false, forKey: Sources.Userdefualts.checkInternetConnection)
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if let error = error {
                print("User did not grand permission: \(error)")
            }
        }
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("sceneDidEnterBackground")
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = "Covid19 Tracker Cambodia"
        content.subtitle = "Bring your mask every time you're going out!"
        content.body = "The last time you checked was \(defaults.integer(forKey: Sources.Userdefualts.newCasesData)) cases in total.\nDon't be panic, strictly follow recommendations of the local government and stay safe. ✨"
        
        var dateComp = DateComponents()
        dateComp.hour = 8
        dateComp.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Push local notification error: \(error)")
            }
        }
        
        
    }
    
}
