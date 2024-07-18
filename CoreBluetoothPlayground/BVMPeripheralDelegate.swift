//
//  BVMCentralManagerDelegate.swift
//  CoreBluetoothPlayground
//
//  Created by Jackson Dugan on 7/16/24.
//

import Foundation
import CoreBluetooth

extension BluetoothViewModel: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: (any Error)?) {
        if let error = error {
                print("Error discovering services: \(error.localizedDescription)")
                return
            }
            
            guard let services = peripheral.services else { return }
            
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("a characterisitc was discovered")
        if let error = error {
                    print("Error discovering characteristics: \(error.localizedDescription)")
                    return
                }
                
                guard let characteristics = service.characteristics else { return }
                
                for characteristic in characteristics {
                    print(characteristic)
                    if characteristicUUIDs.contains(characteristic.uuid) {
                        yourCharacteristic = characteristic
                        // Optionally, notify that the characteristic is found and ready for data transmission
                    }
                }
        }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
            if let error = error {
                print("Error writing value to characteristic: \(error.localizedDescription)")
            } else {
                print("Successfully wrote value to characteristic \(characteristic.uuid)")
            }
        }
    
}
