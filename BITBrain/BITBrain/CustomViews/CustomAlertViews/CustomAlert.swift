//
//  CustomAlert.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 24.10.24..
//

import SwiftUI

struct CustomAlert {
    let title: String
    let message: String
    let primaryButton: Alert.Button
    let secundaryButton: Alert.Button
}

class AlertViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    var alert: CustomAlert? = nil
    
    func presentAlert(alert: CustomAlert) {
        DispatchQueue.main.async {
            self.alert = alert
            self.showAlert = true
        }
    }
}

struct CustomAlertView: View {
    @Binding var isVisible: Bool
    @Binding var apiKeyValue: String
    let onConfirm: () -> Void

    var body: some View {
        if isVisible {
            ZStack {
                // Fullscreen Dimmed Background
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                // Alert Box
                VStack(spacing: 20) {
                    Text("To start chatting,\nplease enter your valid API Key.")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)

                    TextField("Enter API Key", text: $apiKeyValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    HStack(spacing: 30) {
                        Button("Cancel") {
                            withAnimation {
                                isVisible = false
                            }
                        }
                        .foregroundColor(.red)

                        Button("Ok") {
                            if !apiKeyValue.isEmpty {
                                onConfirm()
                                withAnimation {
                                    isVisible = false
                                }
                            }
                        }
                        .foregroundColor(.blue)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
                .frame(width: 300)
            }
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.3), value: isVisible)
        }
    }
}




struct CustomSheetView: View {

    @Binding var isVisible: Bool
    @Binding var apiKeyValue: String
    let onConfirm: () -> Void
    @State private var isInvalidKey: Bool = false


    private func okButtonAction() {
        if isValidApiKey(apiKeyValue) {
            onConfirm()
            isInvalidKey = false
            isVisible = false
        } else {
            // Show error message
            withAnimation {
                isInvalidKey = true
            }
        }
    }
    
    private func cancelButtonAction() {
        isVisible = false
    }
    
    private func isValidApiKey(_ key: String) -> Bool {
        // TODO: - Add method that check validity of API Key based on response form OpenAI
        return key.count > 150
    }
    
    var body: some View {
        VStack {
            // Close button
            HStack {
                Spacer()
                Button {
                    isVisible = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .frame(width: 50, height: 40)
                        .foregroundColor(.gray.opacity(0.5))
                        .font(.title)
                        .padding(.top, 5)
                }
            }
            
            // Title
            Text(isInvalidKey ? "You entered an invalid API Key" : "To start chatting, please \nenter your valid API Key.")
                .font(.title2)
                .frame(alignment: .center)
                .foregroundColor(isInvalidKey ? .red : .darkBlue)
                .fontWeight(.bold)
            HStack {
                ZStack(alignment: .leading) {
                    // Input Field
                    if apiKeyValue.isEmpty {
                        Text("Enter your API key...")
                            .foregroundColor(.gray)
                            .padding(.leading, 6)
                    }
                    TextField("", text: $apiKeyValue)
                        .tint(Color.primaryBlue)
                        .foregroundColor(Color.darkBlue)
                        .padding(5)
                        .background(Color.gray.opacity(0.1))
                        .overlay(RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.lightGrayBit, lineWidth: 1)
                        )
                }
                .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
            }

            // Buttons
            HStack {
                Button(action: cancelButtonAction) {
                    HStack {
                        Spacer()
                        Text("Cancel")
                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.lightGrayBit)
                .foregroundColor(.red)
                .cornerRadius(8)

                Button(action: okButtonAction) {
                    HStack {
                        Spacer()
                        Text("OK")
                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.darkBlue)
                .cornerRadius(8)
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(Color.white)
        .cornerRadius(16, corners: [.topLeft, .topRight])
    }
    
   
}

// View Modifier to apply rounded corners selectively
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
