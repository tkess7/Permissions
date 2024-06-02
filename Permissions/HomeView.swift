//
//  HomeView.swift
//  Permissions
//
//  Created by Travis Kessinger on 6/1/24.
//

import SwiftUI

struct HomeView: View {
    @State private var presentGetStartedView = false
    var body: some View {
        VStack(spacing: 24) {
            Text("Home View")
            
            if !PermissionsUtility.shared.allPermissionsEnabled {
                Button("Present full screen cover") {
                    presentGetStartedView = true
                }
            } else {
                Text("All permissions are enabled!")
            }
        }
        .fullScreenCover(isPresented: $presentGetStartedView) {
            GetStartedView(showPermissionsFlow: $presentGetStartedView)
        }
    }
}

#Preview {
    HomeView()
}
