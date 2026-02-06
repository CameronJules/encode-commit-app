//
//  TodoStatusControlView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI



struct TodoStatusControlView: View {
    @Binding var status: TodoStatus
    var todoId: UUID?
    var coinAnimationManager: CoinAnimationManager?
    var slideAnimationManager: TodoSlideAnimationManager?
    var onStatusChange: ((TodoStatus, TodoStatus) -> Void)? = nil

    private let size: CGFloat = 24
    private let cornerRadius: CGFloat = 6

    var body: some View {
        Button {
            let oldStatus = status
            let newStatus: TodoStatus = {
                switch status {
                case .inactive: return .active
                case .active: return .complete
                case .complete: return .active
                }
            }()

            // Trigger coin animation when completing a task (visual effect starts immediately)
            if oldStatus == .active && newStatus == .complete, let todoId = todoId {
                coinAnimationManager?.triggerCoinAnimation(from: todoId)
            }

            // If slide animation manager exists, delay status change until animation completes
            if let slideManager = slideAnimationManager, let todoId = todoId {
                slideManager.triggerSlideAnimation(todoId: todoId, from: oldStatus, to: newStatus)
                // Delay status change to allow slide animation to play
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        status = newStatus
                    }
                    // Notify after status change so coin awarding happens at correct time
                    onStatusChange?(oldStatus, newStatus)
                }
            } else {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    status = newStatus
                }
                onStatusChange?(oldStatus, newStatus)
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
        .background(
            GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: CoinSourcePositionKey.self,
                        value: todoId.map { [$0: geometry.frame(in: .named("coinAnimationSpace"))] } ?? [:]
                    )
            }
        )
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
