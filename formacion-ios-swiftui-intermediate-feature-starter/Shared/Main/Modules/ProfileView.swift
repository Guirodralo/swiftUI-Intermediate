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
            VStack(spacing: 0) {
                Image(uiImage: viewModel.avatarImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
                    .onTapGesture {
                        viewModel.isShowingPhotoPicker = true
                    }
                
            }
            .frame(maxWidth: .infinity)
            .background(viewModel.backGroundColor)
            
            Form {
                
                TextField("Nickname", text: $viewModel.nickNameField, onCommit: {
                    focusedField = .email
                })
                .focused($focusedField, equals: .nickName)
                
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
                
                //MARK: - Personal Info Section
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
                        .datePickerStyle(.compact)
                    
                }
                
                //MARK: - Role Section
                Section("Role") {
                    
                    Picker("Preferred Role", selection: $viewModel.ExpertiseLevelType) {
                        ForEach(ExpertiseLevelType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                        
                    }
                    .pickerStyle(.segmented)
                    //                    .pickerStyle(.menu)
                    //                    .pickerStyle(.inline)
                    //                    .pickerStyle(.wheel)
                }
                
                //MARK: - Preferences section
                Section("Preferences") {
                    Toggle("Play notification sounds", isOn: $viewModel.playNotificationSound)
                    ColorPicker("Set favourite color", selection: $viewModel.backGroundColor)
                }
            }
            //.scrollContentBackground(.hidden)
            
            //MARK: - Save button
            Button {
//                viewModel.isShowingConfirmationDialog = true
                viewModel.isShowingConfirmationAlert = true
            } label: {
                Text("Save Data")
                    .font(.system(size: 19, weight: .semibold))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(PrimaryButtonStyle(bgColor: .accentColor))
            .padding()
        }
        .ignoresSafeArea(.keyboard)
        
        //MARK: - PRESENT PHOTO PICKER
        .sheet(isPresented: $viewModel.isShowingPhotoPicker, content: {
            PhotoPicker.init(avatarImage: $viewModel.avatarImage)
        })
        
        
        
        
        
        //MARK: Alerts
        .alert(isPresented: $viewModel.isShowingConfirmationAlert, content: {
//            Alert(title: Text("Saving Data"), message: Text("Do you want apply changes?"), dismissButton: .default(Text("OK")))
            
            Alert(title: Text("Saving Data"), message: Text("Do you want apply changes?"), primaryButton: .destructive(Text("Not Yet")), secondaryButton: .default(Text("Sure"), action: {
                print("Saving Changes...")
            }))
        })
        
        //MARK: Activity Sheet Is Really a confirmation Dialog
        .confirmationDialog("Do you want to apply changes?", isPresented: $viewModel.isShowingConfirmationDialog, titleVisibility: .visible) {
            
            Button("Sure") {
                print("Saving Changes")
            }
            
        }
        
        
        .onChange(of: viewModel.ExpertiseLevelType, perform: { newValue in
            viewModel.segmentedControllerDidChanged(newValue)
        })
        .preferredColorScheme(viewModel.colorScheme)
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}

//MARK: - NavigationViewExample
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
