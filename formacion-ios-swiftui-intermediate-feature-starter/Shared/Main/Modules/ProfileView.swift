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
                
                //MARK: Personal Info Section
                Section("Personal Info") {
                    
                    TextField("Nickname", text: $viewModel.nickNameField, onCommit: {
                        focusedField = .email
                    })
                    .focused($focusedField, equals: .nickName)
                    //                        .textFieldStyle(.roundedBorder)
                    
                    
                    TextField("Email", text: $viewModel.emailField, onCommit: {
                        focusedField = nil
                    })
                    .onSubmit {
                        viewModel.emailDidSubmit()
                    }
                    .foregroundStyle(viewModel.emailForegroundStyle)
                    .focused($focusedField, equals: .email)
                    
                    
                    DatePicker("DOB", selection: $viewModel.date, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                    
                }
                
                //MARK: Role Section
                Section("Role") {
                    
                    Picker("Preferred Role", selection: $viewModel.ExpertiseLevelType) {
                        ForEach(ExpertiseLevelType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                        
                    }
                    .pickerStyle(.menu)
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
