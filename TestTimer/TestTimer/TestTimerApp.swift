//
//  TestTimerApp.swift
//  TestTimer
//
//  Created by Neo Hsu on 2023/10/18.
//

import SwiftUI
import UIKit
import CoreData
import BackgroundTasks

@main
struct TestTimerApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            TimerView()
//            ContentView()
//                .environmentObject(delegate)
//                .onChange(of: scenePhase) { phase in
//                    switch phase {
//                    case .background:
//                        delegate.scheduleAppRefresh()
//                        delegate.tasks += 1
//                        print("background \(delegate.tasks)")
//                    case .active:
//                        print("active \(delegate.tasks)")
//                        BGTaskScheduler.shared.getPendingTaskRequests(completionHandler: { request in
//                            print("Pending task requests: \(request)")
//                        })
//                    case .inactive:
//                        print("inactive \(delegate.tasks)")
//                    @unknown default:
//                        break
//                    }
//                }
        }
    }
}
