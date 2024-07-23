//
//  PracticeView.swift
//  CoreBluetoothPlayground
//
//  Created by Jackson Dugan on 7/10/24.
//

import SwiftUI

struct CustomCircleButton: View {
    let action: () -> Void
    private let circleSize: CGFloat = 75

    var body: some View {
        Button(action: action) {
            Image(systemName: "circle")
                .font(.system(size: circleSize))
        }
    }
}

struct PracticeView: View {
    @ObservedObject var bluetoothViewModel: BluetoothViewModel
    var body: some View {
        let circleSize: CGFloat = 75
        
        VStack (spacing: 8) {
            
            Spacer()
            
            HStack {
                Spacer()
                
                CustomCircleButton(action: {sendToHM10(data: Data([0x01]))})
                
                Spacer()
            }
            
            HStack {
                
                CustomCircleButton(action: {sendToHM10(data: Data([0x02]))})
                
                Spacer().frame(width: 91)
                
                CustomCircleButton(action: {sendToHM10(data: Data([0x03]))})
                
            }
            
            HStack {
                Spacer()
                
                CustomCircleButton(action: {sendToHM10(data: Data([0x04]))})
                
                Spacer()
            }
            
            Spacer()
            
        }
    }
    
    func sendToHM10 (data: Data) {
        if let peripheral = bluetoothViewModel.connectedPeripherals.first {
            
            bluetoothViewModel.sendData(data, to: peripheral)
        }
    }
    
}

#Preview {
    PracticeView(bluetoothViewModel: BluetoothViewModel())
}
