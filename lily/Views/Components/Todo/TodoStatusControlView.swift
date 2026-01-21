//
//  TodoStatusControlView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI



struct TodoStatusControlView: View {
    @Binding var status: TodoStatus

    private let size: CGFloat = 24
    private let cornerRadius: CGFloat = 6

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                switch status {
                case .inactive:
                    status = .active
                case .active:
                    status = .complete
                case .complete:
                    status = .active
                }
            }
        } label: {
            ZStack {
                switch status {
                case .inactive:
                    // Play button for inactive
                    Image("rounded.square.play.SFSymbol")
                        .foregroundColor(Color("BluePrimary"))
                        .imageScale(.large)
                        .font(Font.system(size: size+5, weight: .heavy))
                        
                    
                      

                case .active:
                    // Empty checkbox for active
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.clear)
                        .frame(width: size, height: size)

                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color("CheckboxUnchecked"), lineWidth: 2)
                        .frame(width: size, height: size)

                case .complete:
                    // Filled checkbox with checkmark for complete
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color("BluePrimary"))
                        .frame(width: size, height: size)

                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color("BluePrimary"), lineWidth: 2)
                        .frame(width: size, height: size)

                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .transition(.scale.combined(with: .opacity))
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 20) {
        TodoStatusControlView(status: .constant(.inactive))
        TodoStatusControlView(status: .constant(.active))
        TodoStatusControlView(status: .constant(.complete))
    }
    .padding()
}
