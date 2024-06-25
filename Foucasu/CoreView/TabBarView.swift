//
//  TabBarView.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/20.
//

import SwiftUI

struct TabBarView: View {
    // MARK: - Properties

    let tabBarData: TabBarData = .init()
    let focusViewModel: FocusViewModel

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch tabBarData.activeTab {
                case .Focus: 
                    FocusView(viewModel: focusViewModel)
                        .preferredColorScheme(.dark)
                case .List: 
                    TodoListView()
                        .preferredColorScheme(.light)
                }
            }.ignoresSafeArea()

            CustomTabBar()
                .environment(tabBarData)
        }
    }
}

#Preview {
    TabBarView(focusViewModel: .init())
}
