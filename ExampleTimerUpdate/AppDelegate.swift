//
//  AppDelegate.swift
//  ExampleTimerUpdate
//
//  Created by Ivan Kramarchuk on 26.04.17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var timer: Timer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        timer = Timer.scheduledTimer(timeInterval: 4, target:self, selector: #selector(AppDelegate.update_data), userInfo: nil, repeats: true)

        return true
    }
    
    func update_data()
    {
        Alamofire.request("https://time.is/Moscow").responseJSON { response in
            if let contentType = response.response?.allHeaderFields["Expires"] as? String {
                print("Date: \(contentType)")
                let dataDict:[String: String] = ["date": contentType]
                NotificationCenter.default.post(name: Notification.Name("update_new_date"), object: nil, userInfo: dataDict)
            }
        }
    }
    
    func create_labels(view: UIView, text: String, show_buttons : Bool) -> (UILabel, UILabel, UIButton?, UIButton?)
    {
        let yy : CGFloat = 70
        let header_label = UILabel(frame: CGRect(x: 0, y: yy, width: UIScreen.main.bounds.width, height: 40))
        header_label.text = text
        header_label.textAlignment = NSTextAlignment.center
        header_label.backgroundColor = UIColor.green
        view.addSubview(header_label)
        let time_label = UILabel(frame: CGRect(x: 0, y: yy+40, width: UIScreen.main.bounds.width, height: 40))
        time_label.layer.backgroundColor = UIColor.blue.cgColor
        time_label.textAlignment = NSTextAlignment.center
        time_label.textColor = UIColor.white
        view.addSubview(time_label)
        if (show_buttons)
        {
            let button1 = UIButton(frame: CGRect(x: 0, y: yy+80, width: UIScreen.main.bounds.width, height: 40))
            button1.setTitle("Goto screen 1", for: UIControlState.normal)
            button1.setTitleColor(UIColor.black, for: UIControlState.normal)
            view.addSubview(button1)
            let button2 = UIButton(frame: CGRect(x: 0, y: yy+120, width: UIScreen.main.bounds.width, height: 40))
            button2.setTitle("Goto screen 2", for: UIControlState.normal)
            button2.setTitleColor(UIColor.black, for: UIControlState.normal)
            view.addSubview(button2)
            return (header_label, time_label, button1, button2)
        }
        else
        {
            return (header_label, time_label, nil, nil)
        }
    }

    func animate_update(view : UILabel)
    {
        view.layer.backgroundColor = UIColor.red.cgColor
        UIView.animate(withDuration: 3.0, animations: {
            view.layer.backgroundColor = UIColor.blue.cgColor
        })
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ExampleTimerUpdate")
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

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

