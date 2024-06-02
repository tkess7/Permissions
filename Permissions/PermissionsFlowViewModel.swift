//
//  PermissionsFlowViewModel.swift
//  Permissions
//
//  Created by Travis Kessinger on 6/1/24.
//

import SwiftUI

class PermissionsFlowViewModel: ObservableObject {
    @Published var flowCompleted = false
    @Published var path = NavigationPath()
    @Published var permissionsFlow: PermissionsFlow = .bluetooth
    @Published var neededPermissions: [PermissionsFlow] = []
    
    func setupPath() {
        path = NavigationPath()
        flowCompleted = false
        
        let isBluetoothEnabled = PermissionsUtility.shared.isBluetoothEnabled
        let isLocationEnabled = PermissionsUtility.shared.isLocationEnabled
        neededPermissions = [!isBluetoothEnabled ? .bluetooth : nil,
                             !isLocationEnabled ? .location : nil]
            .compactMap{ $0 }
    }
}

enum PermissionsFlow: Hashable {
    case bluetooth
    case location
}
