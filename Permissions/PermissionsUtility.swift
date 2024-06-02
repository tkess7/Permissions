//
//  PermissionsUtility.swift
//  Permissions
//
//  Created by Travis Kessinger on 6/1/24.
//

import Combine
import CoreBluetooth
import CoreLocation
import SwiftUI

class PermissionsUtility: NSObject, ObservableObject, CBCentralManagerDelegate, CLLocationManagerDelegate {
    static var shared = PermissionsUtility()
    @Published var isBluetoothEnabled = false
    @Published var isLocationEnabled = false
    @Published var allPermissionsEnabled = false
    @Published var permissionSwitchedOff = false
    
    var bluetoothManager: CBCentralManager!
    var locationManager: CLLocationManager
    private var cancellabes = Set<AnyCancellable>()
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        isBluetoothEnabled = checkBluetoothEnabled()
        isLocationEnabled = checkLocationEnabled()
        
        Publishers.CombineLatest($isBluetoothEnabled, $isLocationEnabled)
            .sink { [weak self] value in
                self?.allPermissionsEnabled = value.0 && value.1
                if value.0 && value.1 {
                    print("All permissions enabled!")
                } else {
                    print("All permissions not enabled!")
                }
            }
            .store(in: &cancellabes)
    }
    
    func checkBluetoothEnabled() -> Bool {
        return CBCentralManager.authorization == .allowedAlways
    }
    
    func checkLocationEnabled() -> Bool {
        let result = locationManager.authorizationStatus == .authorizedAlways && locationManager.accuracyAuthorization == .fullAccuracy
        return result
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        let state = central.state
        if isBluetoothEnabled && state != .poweredOn {
            permissionSwitchedOff = true
        }
        switch state {
        case .poweredOn:
            isBluetoothEnabled = true
        default:
            isBluetoothEnabled = false
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let locationAuthorizationStatus = manager.authorizationStatus == .authorizedAlways && manager.accuracyAuthorization == .fullAccuracy
        if isLocationEnabled && !locationAuthorizationStatus {
            permissionSwitchedOff = true
        }
        isLocationEnabled = locationAuthorizationStatus
    }
    
    func requestBluetooth() {
        if CBCentralManager.authorization == .notDetermined {
            bluetoothManager = CBCentralManager(delegate: self, queue: nil)
        } else {
            openAppSettings()
        }
    }
    
    func requestLocation() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            openAppSettings()
        }
    }
    
    func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
