//
//  TestTimerView.swift
//  TestTimer
//
//  Created by Neo Hsu on 2023/10/24.
//
import SwiftUI

struct TimerView: View {
    @StateObject var object = TestObject()
    @StateObject var object2 = TestObject()

    var body: some View {
        VStack {
            Button(object.show ? "Hide Timer" : "Show Timer") {
                object.show.toggle()
            }
            if object.show {
                Text("\(object.count)")
                    .task(object.timer)
            }
            if object2.show {
                Text("\(object2.count)")
                    .task(object2.timer)
            }
        }
    }
}

class TestObject: ObservableObject {
    @Published var date: Date = .now
    @Published var count = 0
    @Published var show = true {
        didSet {
            print("Task isCanceled \(Task.isCancelled)")
        }
    }

    @Sendable
    func timer() async {
        let taskID = UUID()
        print("Task \(taskID) has been inited.")

        print(Thread.current)
        defer {
            print("Task \(taskID) has been cancelled.")
            print("Task \(taskID) isCanceled \(Task.isCancelled)")

            // 做一些数据的善后工作
        }
        while !Task.isCancelled {
            try? await Task.sleep(nanoseconds: 1000000000)
//            let now = Date.now
            await MainActor.run { // 需要切换回主线程
//                date = now
                count = count + 1
                print("Task \(taskID) :\(count) \(Thread.current)")

            }
            print("Task \(taskID) await :\(count) \(Thread.current)")

        }
    }
}
