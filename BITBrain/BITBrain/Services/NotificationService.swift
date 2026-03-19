//
//  NotificationService.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 19.03.26.
//

import Foundation
import UserNotifications

// MARK: - Protocol

protocol NotificationServiceProtocol {
    func requestPermissionAndSchedule() async
    func scheduleSupabaseReminder()
    func cancelSupabaseReminder()
}

// MARK: - Implementation

final class LocalNotificationService: NSObject, NotificationServiceProtocol {

    // Notification identifier – keeping the existing value so any already-scheduled
    // notifications are seamlessly replaced on first launch after the update.
    private let reminderIdentifier = "supabaseReminder"

    // Fire every Monday at 10:00 AM. Using a calendar trigger means the notification
    // fires at a predictable, absolute time and does not drift regardless of when
    // the app is opened – unlike the previous raw 4-day interval approach.
    private let reminderHour = 10
    private let reminderMinute = 0
    private let reminderWeekday = 2 // Monday (1 = Sunday in Gregorian calendar)

    private var onPermissionDenied: (() -> Void)?

    init(onPermissionDenied: (() -> Void)? = nil) {
        self.onPermissionDenied = onPermissionDenied
        super.init()
    }

    // MARK: - Public API

    /// Checks the current authorization status and either requests permission or
    /// schedules the notification directly. Calls `onPermissionDenied` if blocked.
    func requestPermissionAndSchedule() async {
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()

        switch settings.authorizationStatus {
        case .notDetermined:
            let granted = (try? await center.requestAuthorization(options: [.alert, .sound, .badge])) ?? false
            if granted {
                scheduleSupabaseReminder()
            }

        case .authorized, .provisional:
            scheduleSupabaseReminder()

        case .denied:
            await MainActor.run {
                onPermissionDenied?()
            }

        case .ephemeral:
            scheduleSupabaseReminder()

        @unknown default:
            break
        }
    }

    /// Schedules (or replaces) the weekly Supabase reminder notification.
    func scheduleSupabaseReminder() {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Supabase Reminder"
        content.body = "Please update your profile image so that your Supabase project does not get paused."
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.weekday = reminderWeekday
        dateComponents.hour = reminderHour
        dateComponents.minute = reminderMinute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: reminderIdentifier,
                                            content: content,
                                            trigger: trigger)

        // Remove any existing request before adding so we don't accumulate duplicates.
        center.removePendingNotificationRequests(withIdentifiers: [reminderIdentifier])
        center.add(request)
    }

    /// Cancels the pending Supabase reminder (e.g. when the user logs out).
    func cancelSupabaseReminder() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [reminderIdentifier])
    }
}
