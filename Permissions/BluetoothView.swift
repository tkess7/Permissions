//
//  BluetoothView.swift
//  Permissions
//
//  Created by Travis Kessinger on 6/1/24.
//

import Combine
import SwiftUI

struct BluetoothView: View {
    @EnvironmentObject var viewModel: PermissionsFlowViewModel
    var body: some View {
        VStack {
            Button("Request bluetooth") {
                PermissionsUtility.shared.requestBluetooth()
            }
        }
        .onReceive(PermissionsUtility.shared.$isBluetoothEnabled.dropFirst()) { bluetoothEnabled in
            if bluetoothEnabled && !PermissionsUtility.shared.isLocationEnabled {
                viewModel.path.append(PermissionsFlow.location)
            } else {
                viewModel.flowCompleted = true
            }
        }
    }
}

#Preview {
    BluetoothView()
}
