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
    @State var Speed: Double = 0
    var body: some View {
        
        VStack (spacing: 8) {
            
            Spacer()
            
            HStack {
                Spacer()
                
                CustomCircleButton(action: { sendToHM10(buttonNumber: 1, speed: UInt8(Speed)) })
                
                Spacer()
            }
            
            HStack {
                
                CustomCircleButton(action: { sendToHM10(buttonNumber: 2, speed: UInt8(Speed)) })
                
                Spacer().frame(width: 91)
                
                CustomCircleButton(action: { sendToHM10(buttonNumber: 3, speed: UInt8(Speed)) })
                
            }
            
            HStack {
                Spacer()
                
                CustomCircleButton(action: { sendToHM10(buttonNumber: 4, speed: UInt8(Speed)) })
                
                Spacer()
            }
            
            Text("Speed: ").foregroundColor(.black)
            
            HStack {
                Spacer()
                
                Slider(value: $Speed, in: 0...255)
                
                Spacer()
            }
            
            
            
            Spacer()
            
        }
    }
    
    func sendToHM10(buttonNumber: UInt8, speed: UInt8) {
            if let peripheral = bluetoothViewModel.connectedPeripherals.first {
                bluetoothViewModel.sendData(buttonNumber: buttonNumber, speed: speed, to: peripheral)
            }
        }
    
}

#Preview {
    PracticeView(bluetoothViewModel: BluetoothViewModel())
}
