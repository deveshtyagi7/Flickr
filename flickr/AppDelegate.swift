//
//  AppDelegate.swift
//  flickr
//
//  Created by Devesh Tyagi on 18/04/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do{
            let realm = try Realm()
        } catch {
            print("Error when initilising new realm ,\(error)")
        }
        
       
        
        return true
    }

    
    private func splashcreen(){
        let launchScreenVC = UIStoryboard.init(name: "LaunchScreen", bundle: nil)
        let rootVC = launchScreenVC.instantiateViewController(identifier: "SplashScreen")
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(dismissSplashController), userInfo: nil, repeats: false)
        
        
    }
    @objc func dismissSplashController(){
         let mainVC = UIStoryboard.init(name: "Main", bundle: nil)
         let rootVC = mainVC.instantiateViewController(identifier: "MainController")
         self.window?.rootViewController = rootVC
         self.window?.makeKeyAndVisible()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
      
    }

    


}

