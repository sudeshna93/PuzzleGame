//
//  AppDelegate.swift
//  PuzzleGame
//
//  Created by Consultant on 11/16/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit
import CoreData
import FacebookCore
import FacebookShare

let FBSDKAppDelegate = ApplicationDelegate.shared
typealias FBSDKSettings = Settings

enum FBConstants {
    static let appID = "2712561765477602"
}

class dummy: ScoreViewProtocol {
    func update() { }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /*To post-process the results from actions that require to switch to the native Facebook app or Safari, such as Facebook Login or Facebook Dialogs,we need to connect AppDelegate class to the FBSDKApplicationDelegate object.
    */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FBSDKSettings.appID = FBConstants.appID
        FBSDKAppDelegate.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didSignOut), name: .signout, object: nil)
    
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool{
        let source = options[.sourceApplication] as? String
        let annotation = options[.annotation]
        
        return FBSDKAppDelegate.application(app, open: url, sourceApplication: source, annotation: annotation)
       // return FBSDKAppDelegate.application(app, open: url, options: options)
    }
    
    @objc
    func didSignOut() {
        AccessToken.current = nil
        
        //immediately send them back to the signin screen
        let root = window?.rootViewController as! UINavigationController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyboard.instantiateViewController(identifier: "ShareViewController")
        root.setViewControllers([signInVC], animated: true)
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "PuzzleGame")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

//    // MARK: - Core Data Saving support
//    
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

}

