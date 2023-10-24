//
//  Appdelegate.swift
//  TestTimer
//
//  Created by Neo Hsu on 2023/10/19.
//

import UIKit
import CoreData
import CoreLocation
//import UserNotifications
import BackgroundTasks
import SwiftUI
class AppDelegate: NSObject,  UIApplicationDelegate, ObservableObject {
    let taskIdentifier = "com.sequent.TestTimer.refresh"
    @AppStorage("backgroundtask") var tasks: Int = 0
    
    func application(_ applicatiown: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        register()
        scheduleAppRefresh()
        return true
    }

    func register() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: taskIdentifier, using: nil) { task in
            self.handleAppRefresh(task: task as! BGProcessingTask)
            print("register")
        }
    }
    
    func scheduleAppRefresh() {
        print("scheduleAppRefresh")
        let request = BGProcessingTaskRequest(identifier: taskIdentifier)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
        request.requiresNetworkConnectivity = true
        request.requiresExternalPower = false // Default value in false
        do {
            try BGTaskScheduler.shared.submit(request)
            print("after submit")

        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    func handleAppRefresh(task: BGProcessingTask) {
        print("handleAppRefresh")

        scheduleAppRefresh()
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        DispatchQueue.main.async {
            self.tasks += 1000
        }
        // Network request here
        task.setTaskCompleted(success: true)
        print("handle app refresh")
    }
    
}
