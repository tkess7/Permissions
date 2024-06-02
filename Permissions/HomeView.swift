//
//  HomeView.swift
//  Permissions
//
//  Created by Travis Kessinger on 6/1/24.
//

import SwiftUI

struct HomeView: View {
    @State private var presentGetStartedView = false
    @State private var allPermissionsEnabled = false
    var body: some View {
        VStack(spacing: 24) {
            Text("Home View")
            
            if !allPermissionsEnabled {
                Button("Present full screen cover") {
                    presentGetStartedView = true
                }
            } else {
                Text("All permissions are enabled!")
            }
        }
        .onReceive(PermissionsUtility.shared.$allPermissionsEnabled) { allPermissionsEnabled in
            self.allPermissionsEnabled = allPermissionsEnabled
        }
        .fullScreenCover(isPresented: $presentGetStartedView) {
            GetStartedView(showPermissionsFlow: $presentGetStartedView)
        }
    }
}

#Preview {
    HomeView()
}
