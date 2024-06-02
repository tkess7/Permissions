//
//  LocationView.swift
//  Permissions
//
//  Created by Travis Kessinger on 6/1/24.
//

import SwiftUI

struct LocationView: View {
    @EnvironmentObject var viewModel: PermissionsFlowViewModel
    var body: some View {
        VStack {
            Button("Request location") {
                PermissionsUtility.shared.requestLocation()
            }
        }
        .onReceive(PermissionsUtility.shared.$isLocationEnabled.dropFirst()) { locationEnabled in
            if locationEnabled {
                viewModel.flowCompleted = true
            }
        }
    }
}

#Preview {
    LocationView()
}
