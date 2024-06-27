//
//  TodoEditView.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/26.
//

import SwiftUI

struct TodoEditView: View {
    @State var title: String
    @Binding var content: String
        
    init(title: String = "TODO ITEM", content: Binding<String>) {
        self.title = title
        _content = content
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(.all, 12)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .background(
                    Rectangle().fill(.primary500)
                )
            
            TextField("Enter something ...", text: $content, axis: .vertical)
                .lineLimit(1...3)
                .padding()
                .background(
                    Rectangle().fill(.white)
                )
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    @State var content = ""
    return TodoEditView(content: $content)
}
