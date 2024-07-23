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
        NavigationStack {
            List(bluetoothViewModel.peripherals, id: \.self) { peripheral in
                Button(action: {
                    if bluetoothViewModel.tryConnecting(peripheral: peripheral) {
                        selectedPeripheral = peripheral
                        navigateToPracticeView = true
                    }
                }) {
                    if let peripheralName = peripheral.name {
                        Text(peripheral.identifier.uuidString + ": " + peripheralName).foregroundColor(.white)
                    } else {
                        Text(peripheral.identifier.uuidString).foregroundColor(.white)
                    }
                }
            }
            .navigationTitle("Peripherals")
            .navigationDestination(isPresented: $navigateToPracticeView) {
                PracticeView(bluetoothViewModel: bluetoothViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
