//
//  BluetoothViewModel.swift
//  CoreBluetoothPlayground
//
//  Created by Jackson Dugan on 7/11/24.
//

import Foundation
import CoreBluetooth

//connection status
enum ConnectionStatus {
    
    case connected
    case disconnected
    case scanning
    case connecting
    case error
    
}

let characteristicUUIDs: [CBUUID] = [
    
    CBUUID(string: "FFE1")
    
]

let serviceUUIDs: [CBUUID] = [
        CBUUID(string: "B5A1C144-01DC-0090-FF75-7ADAEF476B1E"),
        //CBUUID(string: "Your-First-Service-UUID-Here"),
        //CBUUID(string: "Your-Second-Service-UUID-Here"),
        // Add more service UUIDs as needed
    ]

class BluetoothViewModel: NSObject, ObservableObject {
    var centralManager: CBCentralManager?
    @Published var peripherals: [CBPeripheral] = []
    @Published var connectedPeripherals: [CBPeripheral] = []
    @Published var peripheralNames: [String] = []
    @Published var peripheralStatus: ConnectionStatus = .disconnected
    
    //test this code:
    var yourCharacteristic: CBCharacteristic?

    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
     
    
    func scanForPeripherals() {
        peripheralStatus = .scanning
        centralManager?.scanForPeripherals(withServices: nil)
    }
    
    
    func sendData(_ data: Data, to peripheral: CBPeripheral) {
            guard let characteristic = yourCharacteristic else {
                print("Characteristic not found")
                return
            }
            peripheral.writeValue(data, for: characteristic, type: .withResponse)
        }
    
}
