//
//  FocusView.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/20.
//

import SwiftUI

struct FocusView: View {
    // MARK: - Properties
    
    @Environment(\.safeAreaInsets) var safeAreaInsets
    private let spacing: CGFloat = 15
    private let timerViewHeight: CGFloat = 400
    
    // MARK: - Init Properties
    
    var viewModel: FocusViewModel
    
    init(viewModel: FocusViewModel = .init()) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 0) {
            titleText

            GeometryReader { proxy in
                VStack(spacing: spacing) {
                    // Timer Ring
                    ZStack {
                        shadowRingView
                        
                        // Timer Circle's Background
                        Circle()
                            .fill(.backgroundDark)
                        
                        // Progress Ring
                        Circle()
                            .trim(from: 0, to: viewModel.progress)
                            .stroke(Color.primary500.opacity(0.7), lineWidth: 10)
                        
                        // Knob
                        knobView
                        
                        countText
                    }
                    .padding(60)
                    .frame(height: proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.easeInOut, value: viewModel.progress)
                    
                    activityButton
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .padding(.top, safeAreaInsets.top)
        .padding([.bottom, .horizontal])
        .background {
            Rectangle().fill(.backgroundDark)
        }
        .overlay {
            setTimerView
        }
        .alert("Congratulation!!\nYou completed it 🥳🤩", isPresented: .constant(viewModel.isFinished)) {
            Button("Start New", role: .cancel) {
                viewModel.didClickStartNewButton()
            }
            
            Button("Close", role: .destructive) {
                viewModel.didClickStopButton()
            }
        }
    }
}

// MARK: - Subviews

extension FocusView {
    @ViewBuilder
    var titleText: some View {
        HStack {
            Text("Focus")
                .font(.largeTitle).bold()
                .foregroundStyle(.white)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    var shadowRingView: some View {
        Circle()
            .fill(.white.opacity(0.03))
            .padding(-40)
        
        Circle()
            .trim(from: 0, to: viewModel.progress)
            .stroke(.white.opacity(0.03), lineWidth: 80)
        
        Circle()
            .stroke(Color.primary500, lineWidth: 5)
            .blur(radius: 15)
            .padding(-2)
    }
    
    @ViewBuilder
    var knobView: some View {
        let knobSize: CGSize = .init(width: 30, height: 30)
        
        GeometryReader { proxy in
            let size = proxy.size
            
            Circle()
                .fill(.primary500)
                .frame(width: knobSize.width, height: knobSize.height)
                .overlay {
                    Circle()
                        .fill(.white)
                        .padding(5)
                }
                .frame(width: size.width, height: size.height, alignment: .center)
                .offset(x: size.height / 2)
                .rotationEffect(.init(degrees: viewModel.progress * 360))
        }
    }
    
    @ViewBuilder
    var countText: some View {
        Text(viewModel.timerStringValue)
            .font(.system(size: 45, weight: .thin))
            .rotationEffect(.init(degrees: 90))
            .contentTransition(.numericText(value: viewModel.progress))
            .animation(.snappy, value: viewModel.progress)
    }
    
    @ViewBuilder
    var activityButton: some View {
        let size: CGSize = .init(width: 80, height: 80)
        
        Button {
            viewModel.didClickActivityButton()
            
        } label: {
            Image(systemName: !viewModel.isStarted ? "timer" : "stop.fill")
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
                .frame(width: size.width, height: size.height)
                .background(
                    Circle()
                        .fill(.primary500)
                )
                .shadow(color: .primary500, radius: 8, x: 0, y: 0)
        }
    }
    
    @ViewBuilder
    var setTimerView: some View {
        let topPadding: CGFloat = 10
        
        ZStack {
            Color.gray800
                .opacity(viewModel.isTimerViewVisible ? 0.6 : 0)
                .onTapGesture {
                    viewModel.didClickEmptySpace()
                }
            
            VStack(spacing: spacing) {
                Text("Set Timer")
                    .font(.title2.bold())
                    .padding(.top, topPadding)
            
                HStack(spacing: spacing) {
                    Menu {
                        contextMenuOptionsView(maxValue: 12, hint: "hr") { value in
                            viewModel.hour = value
                        }
                    } label: {
                        menuLabelText(title: "\(viewModel.hour)", unit: "hr")
                    }
                    
                    Menu {
                        contextMenuOptionsView(maxValue: 60, hint: "min") { value in
                            viewModel.minutes = value
                        }
                    } label: {
                        menuLabelText(title: "\(viewModel.minutes)", unit: "min")
                    }
                    
                    Menu {
                        contextMenuOptionsView(maxValue: 60, hint: "sec") { value in
                            viewModel.seconds = value
                        }
                    } label: {
                        menuLabelText(title: "\(viewModel.seconds)", unit: "sec")
                    }
                }
                .padding(.top, topPadding)
            
                Button {
                    viewModel.didClickSaveButton()
                    
                } label: {
                    Text("Save")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.vertical)
                        .padding(.horizontal, 100)
                        .background(
                            Capsule()
                                .fill(.primary500)
                        )
                }
                .disabled(viewModel.isTimeAtZero)
                .opacity(viewModel.isTimeAtZero ? 0.5 : 1)
                .padding(.vertical)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                Rectangle()
                    .fill(.primary300)
                    .roundedCorner(10, corners: [.topLeft, .topRight])
                    .ignoresSafeArea()
            )
            .frame(maxHeight: .infinity, alignment: .bottom)
            .offset(y: viewModel.isTimerViewVisible ? 0 : timerViewHeight)
        }
    }
    
    @ViewBuilder
    func menuLabelText(
        title: String,
        unit: String,
        textOpacity: CGFloat = 0.7,
        textBackgroundOpacity: CGFloat = 0.1,
        horizontalPadding: CGFloat = 20,
        verticalPadding: CGFloat = 12
    ) -> some View {
        Text("\(title) \(unit)")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(.white.opacity(textOpacity))
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background(
                Capsule()
                    .fill(.white.opacity(textBackgroundOpacity))
            )
    }

    @ViewBuilder
    func contextMenuOptionsView(
        maxValue: Int,
        hint: String,
        onClick: @escaping (Int) -> Void
    ) -> some View {
        ForEach(0 ... maxValue, id: \.self) { value in
            Button("\(value) \(hint)") {
                onClick(value)
            }
        }
    }
}

#Preview {
    let tabBarData: TabBarData = .init()
    let viewModel: FocusViewModel = .init()
    return TabBarView(tabBarData: tabBarData, focusViewModel: viewModel)

}
