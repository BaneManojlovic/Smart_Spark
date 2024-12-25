//
//  CustomAlert.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 24.10.24..
//

import SwiftUI

struct AlertMessage: Identifiable {
    var id: UUID = UUID() // A unique identifier for the alert
    var message: String
}

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

struct CustomSheetView: View {

    // MARK: - Binding properties

    @Binding var isVisible: Bool
    @Binding var apiKeyValue: String

    let onConfirm: () -> Void
    
    // MARK: - State properties

    @State private var localApiKeyValue: String = "" // Temporary state
    @State private var isInvalidKey: Bool = false
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil

    // MARK: - Private Methods

    private func okButtonAction() {
        isLoading = true
        validateApiKey(localApiKeyValue) { isValid, error in
            DispatchQueue.main.async {
                isLoading = false
                if isValid {
                    apiKeyValue = localApiKeyValue
                    onConfirm()
                    isInvalidKey = false
                    isVisible = false
                } else {
                    isInvalidKey = true
                    errorMessage = error ?? "Invalid API Key. Please try again."
                }
            }
        }
    }

    private func cancelButtonAction() {
        isVisible = false
    }

    private func validateApiKey(_ key: String, completion: @escaping (Bool, String?) -> Void) {
        // Simulate a network call (replace this with actual API logic)
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            if key.count > 150 {
                completion(true, nil)
            } else {
                completion(false, "API Key must be at least 150 characters.")
            }
        }
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
                        .accessibilityLabel("Close")
                }
            }
            
            // Title
            Text(isInvalidKey ? "You entered an invalid API Key" : "To start chatting, please \nenter your valid OpenAI API Key")
                .font(.title2)
                .multilineTextAlignment(.center)
                .frame(alignment: .center)
                .foregroundColor(isInvalidKey ? .red : .darkBlue)
                .fontWeight(.bold)
            
            Text("Get an OpenAI API Key [Here](https://platform.openai.com/api-keys). A 'Quota Exceeded' error, means you need to setup billing on your OpenAI account.")
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .frame(alignment: .center)
                .fontWeight(.bold)
                .foregroundColor(.darkGrayBit)
                .tint(.blue)
                .padding()
            
            
            // Input Field
            HStack {
                ZStack(alignment: .leading) {
                    // Input Field
                    if localApiKeyValue.isEmpty {
                        Text("Enter your API key...")
                            .foregroundColor(.gray)
                            .padding(.leading, 6)
                    }
                    TextField("", text: $localApiKeyValue)
                        .tint(Color.primaryBlue)
                        .foregroundColor(Color.darkBlue)
                        .padding(5)
                        .background(Color.gray.opacity(0.1))
                        .overlay(RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.lightGrayBit, lineWidth: 1)
                        )
                        .accessibilityLabel("API Key Text Field")
                }
                .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
            }

            // Loading Indicator
            if isLoading {
                ProgressView()
                    .padding()
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
                .accessibilityLabel("Cancel Button")

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
                .accessibilityLabel("OK Button")
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(Color.white)
        .cornerRadius(16, corners: [.topLeft, .topRight])
        .onDisappear {
            isInvalidKey = false
            errorMessage = nil
        }
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
