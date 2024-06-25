//
//  CustomTabBar.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/15.
//

import SwiftUI

struct CustomTabBar: View {

    // MARK: - Properties

    @Environment(TabBarData.self) private var tabBarData

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(Tabs.allCases, id: \.rawValue) { tab in
                Spacer()

                Button(action: {
                    tabBarData.activeTab = tab
                }, label: {
                    VStack(spacing: 5) {
                        Image(systemName: tabBarData.activeTab == tab ? tab.selectedImage : tab.image)
                            .imageScale(.large)
                            .foregroundStyle(.white)
                            .keyframeAnimator(initialValue: 1, trigger: tabBarData.activeTab) { content, scale in
                                content
                                    .scaleEffect(tabBarData.activeTab == tab ? scale : 1)
                            } keyframes: { _ in
                                CubicKeyframe(1.2, duration: 0.2)
                                CubicKeyframe(1, duration: 0.2)
                            }

                        Text(tab.rawValue)
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
                    .animation(.snappy) { content in
                        content
                            .opacity(tabBarData.activeTab == tab ? 1 : 0.6)
                    }
                }).buttonStyle(NoAnimationButtonStyle())

                Spacer()
            }
        }
        .frame(height: 60)
        .background(
            Rectangle().fill(.primary500)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    TabBarView()
        .environment(TabBarData())
}
