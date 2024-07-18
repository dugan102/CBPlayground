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
    
    var body: some View {
        NavigationView {
            List(bluetoothViewModel.peripherals, id: \.self) { peripheral in
                ZStack {
                    if let peripheralName = peripheral.name {
                        NavigationLink(
                            peripheral.identifier.uuidString + ": " + peripheralName,
                            destination: PracticeView(bluetoothViewModel: bluetoothViewModel)
                        )
                    } else {
                        NavigationLink(
                            peripheral.identifier.uuidString,
                            destination: PracticeView(bluetoothViewModel: bluetoothViewModel)
                        )
                    }
                    Button(action: {
                        bluetoothViewModel.tryConnecting(peripheral: peripheral)
                    }, label: {
                        EmptyView()
                    })
                    .simultaneousGesture(TapGesture())
                }
            }
            .navigationTitle("Peripherals")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
