//
//  ProfileView.swift
//  SwiftUI-Intermediate
//
//  Created by Daniel Ayala Jabon on 10/3/22.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ViewModel()
    @FocusState private var focusedField: FocusedField?
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            Form {
                
                //MARK: - Section Navigation
                Section("Navigation") {
                    NavigationLink(isActive: $viewModel.navigationIsActive) {
                        NavigationViewExample(isActive: $viewModel.navigationIsActive, fieldText: $viewModel.navigationText)
                    } label: {
                        Button {
                            viewModel.navigationIsActive = true
                        } label: {
                            Text(viewModel.navigationText)
                            
                        }
                    }
                }
                
                Section("Personal Info") {
                    
                    TextField("Nickname", text: $viewModel.nickNameField, onCommit: {
                        focusedField = .email
                    })
                        .focused($focusedField, equals: .nickName)
//                        .textFieldStyle(.roundedBorder)
                    TextField("Email", text: $viewModel.emailField, onCommit: {
                        focusedField = nil
                    })
                        .focused($focusedField, equals: .email)
                    
                    
                }
                
                .navigationBarTitle("Profile", displayMode: .inline)
            }
        }
    }
}

//MARK: NavigationViewExample
struct NavigationViewExample: View {
    @Binding var isActive: Bool
    @Binding var fieldText: String
    
    var body: some View {
        VStack{
            TextField("Change Binding Text", text: $fieldText)
                .multilineTextAlignment(.center)
            Button {
                isActive = false
            } label: {
                Text("Navigate Back")
                    .bold()
            }
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
