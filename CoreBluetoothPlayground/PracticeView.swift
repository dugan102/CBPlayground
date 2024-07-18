//
//  PracticeView.swift
//  CoreBluetoothPlayground
//
//  Created by Jackson Dugan on 7/10/24.
//

import SwiftUI

struct PracticeView: View {
    @ObservedObject var bluetoothViewModel: BluetoothViewModel
    var body: some View {
        Text("Hi?")
        
        Button(action: {
                        if let peripheral = bluetoothViewModel.connectedPeripherals.first {
                            let data = Data([1]) // Sending a single byte with value 1
                            bluetoothViewModel.sendData(data, to: peripheral)
                        }
                    }) {
                        Text("Send 1 to Peripheral")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
        
    }
}

#Preview {
    PracticeView(bluetoothViewModel: BluetoothViewModel())
}
