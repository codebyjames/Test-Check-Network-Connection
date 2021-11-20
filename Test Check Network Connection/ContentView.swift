//
//  ContentView.swift
//  Test Check Network Connection
//
//  Created by James Loboda on 11/20/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var monitor = NetworkMonitor()
    @State private var showAlertError = false
    private let titleSuccess = "Success"
    private let titleFail = "Not Internet Connection"
    private let messageSuccess = "Successful network request!"
    private let messageFail = "Please check WiFi or Cellular connection"
    
    @ViewBuilder var internetView: some View {
        Image(systemName: monitor.isConnected ? "wifi" : "wifi.slash")
            .font(.system(size: 60))
        Text(monitor.isConnected ? "Connected" : "Not Connected")
            .padding()
    }
        
    var body: some View {
        VStack {
            internetView
            Button("Test Network") {
                self.showAlertError = true
            }
        }
        .alert(isPresented: $showAlertError) {
            if monitor.isConnected { // show alert & exit on return (don't do below)
                return generalAlert(title: titleSuccess, message: messageSuccess)
            }
            return generalAlert(title: titleFail, message: messageFail)
        }
    }
    
    func generalAlert(title: String, message: String) -> Alert {
        Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("OK")))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
