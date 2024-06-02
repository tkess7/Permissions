//
//  SetUpPermissionsView.swift
//  Permissions
//
//  Created by Travis Kessinger on 6/1/24.
//

import SwiftUI

struct SetUpPermissionsView: View {
    @EnvironmentObject var viewModel: PermissionsFlowViewModel
    @Environment(\.dismiss) var dismiss
    let firstPermission: PermissionsFlow
    
    var body: some View {
        NavigationStack {
            VStack {
                switch firstPermission {
                case .bluetooth:
                    BluetoothView()
                case .location:
                    LocationView()
                }
            }
            .navigationDestination(for: PermissionsFlow.self) { flow in
                switch flow {
                case .bluetooth:
                    BluetoothView()
                case .location:
                    LocationView()
                }
            }
            .toolbar {
                ToolbarItemGroup {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SetUpPermissionsView(firstPermission: PermissionsFlow.bluetooth)
}
