//
//  ContentView.swift
//  Animations
//
//  Created by Nowroz Islam on 14/8/23.
//

import SwiftUI

struct DropTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .rotationEffect(phase.isIdentity ? .zero : .degrees(-30), anchor: .bottomLeading)
            .offset(phase.offsetAmount)
    }
}

extension TransitionPhase {
    var offsetAmount: CGSize {
        switch self {
        case .willAppear:
            return CGSize(width: 0, height: -800)
        case .identity:
            return CGSize(width: 0, height: 0)
        case .didDisappear:
            return CGSize(width: 0, height: 800)
        }
    }
}

extension Transition where Self == DropTransition {
    static var drop: some Transition {
        DropTransition()
    }
}

struct ContentView: View {
    @State private var isShowing: Bool = false
    
    var body: some View {
        VStack {
            if isShowing {
                Image(.x)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .frame(width: 200, height: 200)
                    .transition(.drop)
            }
            
            Button("Drop") {
                withAnimation(.smooth(duration: 1)) {
                    isShowing.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
