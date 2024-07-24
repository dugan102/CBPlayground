//
//  PracticeView.swift
//  CoreBluetoothPlayground
//
//  Created by Jackson Dugan on 7/10/24.
//

import SwiftUI

struct CustomCircleButton: View {
    let onTouchDown: () -> Void
    let onTouchUp: () -> Void
    private let circleSize: CGFloat = 75

    @State private var isPressed = false

    var body: some View {
        Button(action: {}) {
            Image(systemName: "circle")
                .font(.system(size: circleSize))
                .scaleEffect(isPressed ? 0.95 : 1.0) // Slight scale effect to indicate pressing
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !isPressed {
                        isPressed = true
                        onTouchDown()
                        print("down")
                    }
                }
                .onEnded { _ in
                    isPressed = false
                    onTouchUp()
                    print("up")
                }
        )
    }
}

struct PracticeView: View {
    @ObservedObject var bluetoothViewModel: BluetoothViewModel
    @State var Speed: Double = 0

    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            
            HStack {
                Spacer()
                CustomCircleButton(
                    onTouchDown: { sendToHM10(buttonNumber: 1, speed: UInt8(Speed)) },
                    onTouchUp: { sendToHM10(buttonNumber: 0, speed: UInt8(Speed)) }
                )
                Spacer()
            }
            
            HStack {
                CustomCircleButton(
                    onTouchDown: { sendToHM10(buttonNumber: 2, speed: UInt8(Speed)) },
                    onTouchUp: { sendToHM10(buttonNumber: 0, speed: UInt8(Speed)) }
                )
                Spacer().frame(width: 91)
                CustomCircleButton(
                    onTouchDown: { sendToHM10(buttonNumber: 3, speed: UInt8(Speed)) },
                    onTouchUp: { sendToHM10(buttonNumber: 0, speed: UInt8(Speed)) }
                )
            }
            
            HStack {
                Spacer()
                CustomCircleButton(
                    onTouchDown: { sendToHM10(buttonNumber: 4, speed: UInt8(Speed)) },
                    onTouchUp: { sendToHM10(buttonNumber: 0, speed: UInt8(Speed)) }
                )
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
