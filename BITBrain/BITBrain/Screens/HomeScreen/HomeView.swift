//
//  ChatView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.10.24..
//

import SwiftUI
import UserNotifications

struct HomeView: View {

    // MARK: - EnvironmentObject properties

    @EnvironmentObject var appState: AppState
    
    // MARK: - StateObject properties

    @StateObject var chatController: ChatController
    @StateObject var userDefaultsHelper = UserDefaultsHelper()
    
    // MARK: - State properties

    @State private var isPresented = false
    @State private var isTutorialPresented = false
    @State private var isCustomSheetPresented = false
    @State private var apiKeyValue = ""
    @State private var isPermissionAlertPresented = false

    // MARK: - Layout

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color.white.edgesIgnoringSafeArea(.all)
                Image("chat_background_image")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Spacer()
                        Text("Welcome to Smart Spark!")
                            .font(.system(size: 23, weight: .semibold, design: .serif))
                            .foregroundStyle(Color.darkBlue)
                        Spacer()
                        Button(action: {
                            isTutorialPresented = true
                        }) {
                            Image(systemName: "info.circle")
                                .foregroundColor(.darkBlue)
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 14)
                    
                    Divider()
                        .background(Color.lightGrayBit)
                        .padding(.bottom, 10)

                    HStack {
                        if appState.apiKeyValue.isEmpty {
                            Text("• Inactive")
                                .foregroundStyle(Color.gray)
                                .bold()
                                .italic()
                        } else {
                            Text("• Active")
                                .foregroundStyle(Color.green)
                                .bold()
                                .italic()
                        }
                    }
                    .frame(height: 12)

                    Button(action: {
                        if appState.apiKeyValue.isEmpty {
                            isCustomSheetPresented = true
                        } else {
                            isPresented = true
                        }
                    }) {
                        Text(appState.apiKeyValue.isEmpty ?
                             "Tap here to activate and start\nusing your Smart Spark chat." :
                             "Tap here to use your Smart Spark chat.")
                            .font(.system(size: 18, weight: .semibold, design: .serif))
                            .italic()
                            .frame(width: UIScreen.main.bounds.width * 0.94, height: 60)
                            .foregroundColor(.white)
                            .background(Color.primaryBlue.opacity(0.7))
                            .cornerRadius(20)
                            .shadow(color: .gray, radius: 2, x: 0, y: 6)
                    }
                    Spacer()
                }
            }
            .ignoresSafeArea(.keyboard)
            .fullScreenCover(isPresented: $isPresented) {
                ActiveChatView(chatController: appState.chatController)
            }
            .fullScreenCover(isPresented: $isTutorialPresented, content: TutorialView.init)
            .sheet(isPresented: $isCustomSheetPresented) {
                CustomSheetView(
                    isVisible: $isCustomSheetPresented,
                    apiKeyValue: $appState.apiKeyValue
                ) {
                    appState.saveApiKey(appState.apiKeyValue) // Save the validated key
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isPresented = true // Navigate to ActiveChatView
                    }
                }
                .presentationDetents([.height(350)])
            }
        }
        .onAppear {
            apiKeyValue = userDefaultsHelper.getOpenAiAPIToken() ?? ""
            checkForNotificationPermission()
        }
        .alert("Permission denied!", isPresented: $isPermissionAlertPresented) {
            Button("Settings", role: .none ) {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please Turn on the Notification to get info about project pausing.")
        }
    }
    
    private func checkForNotificationPermission() {
        // TODO: - Make and move this into special helper class
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            
            switch settings.authorizationStatus {
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { allowed, error in
                    if allowed {
                        dispatchNotification()
                    }
                }
            case .denied:
                showAlertToOpenSettings()
            case .provisional, .ephemeral:
                return
            case .authorized:
                dispatchNotification()
            @unknown default:
                return
            }
        }
    }
    
    private func dispatchNotification() {
        // TODO: - Make this into special helper class
        let notificationCenter = UNUserNotificationCenter.current()
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Supabase Reminder"
        notificationContent.body = "Please upodate your profile image so that your Supabase project don't get paused."
        notificationContent.sound = .default
        
        let calendar = Calendar.current
//        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
//        dateComponents.hour = 12
//        dateComponents.minute = 49
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 345600, repeats: true) //345600 = 4 days

        let request = UNNotificationRequest(identifier: "supabaseReminder", content: notificationContent, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ["supabaseReminder"])
        notificationCenter.add(request)
    }
    
    private func showAlertToOpenSettings() {
        isPermissionAlertPresented = true
    }
}
