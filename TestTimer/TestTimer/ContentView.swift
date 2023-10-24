//
//  ContentView.swift
//  TestTimer
//
//  Created by Neo Hsu on 2023/10/18.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var cancellables = Set<AnyCancellable>()
    
    var timer1 = Timer()

    init(){
        timer.sink(receiveValue: { _ in
            print("我在做事拉 \(Date())")
        })
        .store(in: &cancellables)

    }

    
    func stopTimer1(){
        print("stopTimer1")

        timer1 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
        }
    }
    
    func startTimer1(){
        print("startTimer1")

        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func stopTimer(){
        print("stopTimer")

        timer.upstream.connect().cancel()
    }
    
    func startTimer(){
        print("startTimer")

        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }

}

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        VStack {

            Spacer()

            Button("Stop") {
                viewModel.stopTimer()
            }
            .padding(.top)
            Spacer()
            Button("Start") {
                viewModel.startTimer()
            }
            Spacer()

        }
        .padding()
    }
}


