//
//  ProfileViewModel.swift
//  SwiftUI-Intermediate
//
//  Created by Guillermo Rodríguez ALonso on 2/4/24.
//

import Foundation
import SwiftUI

extension ProfileView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var navigationIsActive = false
        @Published var navigationText = "Tap me and modify text 🥷"
        
        //TextField States
        @Published var nickNameField = ""
        @Published var emailField = ""
        
        
    }
}


enum FocusedField {
case nickName, email, datePicker
}

