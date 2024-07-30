//
//  ContentView.swift
//  CoreBluetoothPlayground
//
//  Created by Jackson Dugan on 7/10/24.
//

import SwiftUI
import CoreBluetooth

struct ContentView: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    @State private var navigateToPracticeView = false
    @State private var selectedPeripheral: CBPeripheral?

    var body: some View {
        VStack {
            
            Text("Welcome!")
                            .font(.system(size: 30, weight: .bold))
            SearchingView()

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
