//
//  Styles.swift
//  SwiftUI-Intermediate (iOS)
//
//  Created by Guillermo Rodríguez ALonso on 3/4/24.
//

import SwiftUI

//MARK: - Custom Styles

struct PrimaryButtonStyle: ButtonStyle {
    var bgColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundStyle(.white)
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: 24))
    }

}


struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 2 : 1)
    }
    
}
