//
//  FloatingButton.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/26.
//

import SwiftUI

struct FloatingButton<PopupView: View>: View {
    // MARK: - View Properties

    @State private var isExpanded: Bool = false
    private let trailingPadding: CGFloat = 16
    private let bottomPadding: CGFloat = 50
    
    // MARK: - Init Properties

    var buttonSize: CGFloat
    var popupView: (Bool) -> PopupView

    init(
        buttonSize: CGFloat = 50,
        @ViewBuilder popupView: @escaping (Bool) -> PopupView

    ) {
        self.buttonSize = buttonSize
        self.popupView = popupView
    }

    var body: some View {
        ZStack {
            Color.gray800
                .ignoresSafeArea()
                .opacity(isExpanded ? 0.6 : 0)
                .onTapGesture {
                    isExpanded = false
                }
            
            VStack {
                popupView(isExpanded)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottomTrailing) {
                Button(action: {
                    isExpanded.toggle()
                    
                }, label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
                        .scaleEffect(1.2)
                        .frame(maxWidth: buttonSize, maxHeight: buttonSize)
                        .background(.primary500, in: .circle)
                    // Scaling effect when expanded
                        .scaleEffect(isExpanded ? 0.9 : 1)
                    
                })
                .buttonStyle(NoAnimationButtonStyle())
                .padding(.trailing, trailingPadding)
                .padding(.bottom, bottomPadding)
            }
            
        }
        .animation(.easeInOut, value: isExpanded)
    }
}


#Preview {
    FloatingButton { _ in }
}
