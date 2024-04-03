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
        @Published var isShowingConfirmationDialog = false
        @Published var isShowingConfirmationAlert = false
        
        //IMAGE PICKER STATES
        @Published var avatarImage = UIImage(named: "DefaultAvatarImage")!
        @Published var isShowingPhotoPicker = false
        
        //TextField States
        @Published var nickNameField = ""
        @Published var emailField = ""
        @Published var emailForegroundStyle = Color.black
        
        //Picker Satates
        @Published var date = Date()
        @Published var ExpertiseLevelType: ExpertiseLevelType = .junior
        @Published var colorScheme: ColorScheme = .light
        @Published var playNotificationSound = false
        @Published var backGroundColor = Color.accentColor.opacity(0.2)
        
        func emailDidSubmit() {
            emailForegroundStyle = emailField.isEmailValid() ? .blue : .red
        }
        
        
        func segmentedControllerDidChanged(_ type: ExpertiseLevelType) {
            
            print(type.rawValue)
            
            switch type {
            case .junior:
                colorScheme = .light
            case .analyst:
                colorScheme = .light
            case .expert:
                colorScheme = .dark
            }
            
            
        }
        
    }
}


enum FocusedField {
    case nickName, email, datePicker
}

enum ExpertiseLevelType: String, CaseIterable {
    case junior
    case analyst
    case expert
}


extension String {
    public func isEmailValid() -> Bool {
        guard !isEmpty else {
            return false
        }
        // TODO: type.regex en utils
        let regTest = NSPredicate(format: "SELF MATCHES %@", "[\\w.\\-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return regTest.evaluate(with: self)
    }
}
