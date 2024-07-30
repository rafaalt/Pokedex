//
//  OffSetScrollView.swift
//  Pokedex
//
//  Created by Rafael Torga on 29/07/24.
//

import SwiftUI

struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}

struct ContentSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { }
}

struct OffsettableScrollView<T: View>: View {
    let axes: Axis.Set
    let showsIndicator: Bool
    let offsetChanged: (CGPoint) -> Void
    let onReach70Percent: () -> Void
    let content: T
    
    @State private var contentHeight: CGFloat = 0
    
    init(axes: Axis.Set = .vertical,
         showsIndicator: Bool = true,
         offsetChanged: @escaping (CGPoint) -> Void = { _ in },
         onReach70Percent: @escaping () -> Void = {},
         @ViewBuilder content: () -> T) {
        self.axes = axes
        self.showsIndicator = showsIndicator
        self.offsetChanged = offsetChanged
        self.onReach70Percent = onReach70Percent
        self.content = content()
    }
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicator) {
            VStack {
                GeometryReader { proxy in
                    Color.clear.preference(key: OffsetPreferenceKey.self,
                                           value: proxy.frame(in: .named("ScrollView")).origin)
                }
                .frame(height: 0)
                
                content
                    .background(
                        GeometryReader { proxy in
                            Color.clear.preference(key: ContentSizePreferenceKey.self,
                                                   value: proxy.size.height)
                        }
                    )
            }
        }
        .coordinateSpace(name: "ScrollView")
        .onPreferenceChange(OffsetPreferenceKey.self) { value in
            offsetChanged(value)
            checkIfReached70Percent(offset: value.y)
        }
        .onPreferenceChange(ContentSizePreferenceKey.self) { value in
            contentHeight = value
        }
    }
    
    private func checkIfReached70Percent(offset: CGFloat) {
        if offset < 0 {
            let screenHeight = offset - UIScreen.main.bounds.height
            let threshold = contentHeight * 0.85
            if screenHeight < -threshold {
                onReach70Percent()
            }
        }
    }
}
