//
//  TodoListView.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/20.
//

import SwiftUI

struct TodoListView: View {
    @Environment(\.safeAreaInsets) var safeAreaInsets
    
    @State var todoContent: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            titleText

            VStack(spacing: 0) {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.top, safeAreaInsets.top)
        .padding([.bottom, .horizontal])
        .background {
            Rectangle().fill(.white)
        }
        .overlay(alignment: .bottomTrailing) {
            FloatingButton { isExpanded in
                if isExpanded {
                    TodoEditView(content: $todoContent)
                }
            }
        }
    }
}

// MARK: - Subviews

extension TodoListView {
    @ViewBuilder
    var titleText: some View {
        HStack {
            Text("TO-DO LIST")
                .font(.largeTitle).bold()
                .foregroundStyle(.gray800)

            Spacer()
        }
    }
}

#Preview {
    let viewModel: FocusViewModel = .init()
    return TabBarView(focusViewModel: viewModel)
}
