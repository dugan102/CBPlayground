//
//  BVMCentralManagerDelegate.swift
//  CoreBluetoothPlayground
//
//  Created by Jackson Dugan on 7/16/24.
//

import Foundation
import CoreBluetooth

extension BluetoothViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            scanForPeripherals()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            if peripheral.identifier.uuidString.hasPrefix("B5A1C144") {
                self.peripherals.append(peripheral)
                self.peripheralNames.append(peripheral.name ?? "unnamed device")
                centralManager?.connect(peripheral)
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheralStatus = .connected
        //add peripheral to connected peripherals
        
        peripheral.delegate = self
        peripheral.discoverServices(serviceUUIDs)
        
        centralManager?.stopScan()
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        peripheralStatus = .disconnected
        //remove peripheral from connected peripherals
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        peripheralStatus = .error
        print(error?.localizedDescription ?? "no error")
    }
    
    func tryConnecting(peripheral: CBPeripheral) -> Bool {
        if serviceUUIDs.contains(CBUUID(string: peripheral.identifier.uuidString)) {
            centralManager?.connect(peripheral)
            connectedPeripherals.append(peripheral)
            peripheralStatus = .connected
            //print characteristic UUIDs of the peripheral here:
            peripheral.delegate = self // Make sure your class conforms to CBPeripheralDelegate
                    
            // Discover services
            peripheral.discoverServices(nil)
            return true
        } else {
            return false
        }
    }
}

