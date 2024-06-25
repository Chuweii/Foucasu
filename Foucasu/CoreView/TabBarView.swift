//
//  TabBarView.swift
//  CustomTab
//
//  Created by Wei Chu on 2024/6/20.
//

import SwiftUI

struct TabBarView: View {
    let tabBarData: TabBarData = .init()

    var body: some View {
        VStack(spacing: 0) {
            ZStack{
                switch tabBarData.activeTab {
                case .Focus: FocusView()
                case .List: TodoListView()
                }
            }.ignoresSafeArea()

            CustomTabBar()
                .environment(tabBarData)
        }
    }
}

#Preview {
    TabBarView()
}
