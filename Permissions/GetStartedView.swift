//
//  GetStartedView.swift
//  Permissions
//
//  Created by Travis Kessinger on 6/1/24.
//

import SwiftUI

struct GetStartedView: View {
    @StateObject private var permissionsFlowViewModel = PermissionsFlowViewModel()
    @State private var presentSetUpPermissionsView = false
    @Binding var showPermissionsFlow: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                Text("Let's get started")
                
                Button("Set up permissions") {
                    permissionsFlowViewModel.setupPath()
                    presentSetUpPermissionsView = true
                }
            }
            .onReceive(permissionsFlowViewModel.$flowCompleted) { flowCompleted in
                if flowCompleted {
                    showPermissionsFlow = false
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
        .fullScreenCover(isPresented: $presentSetUpPermissionsView) {
            let isBluetoothEanbled = PermissionsUtility.shared.isBluetoothEnabled
            SetUpPermissionsView(firstPermission: isBluetoothEanbled ? .location : .bluetooth)
                .environmentObject(permissionsFlowViewModel)
        }
    }
}

#Preview {
    GetStartedView(showPermissionsFlow: .constant(true))
}
