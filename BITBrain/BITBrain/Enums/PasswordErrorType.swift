//
//  PasswordErrorType.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.11.24..
//

import Foundation

enum PasswordErrorType {
    case noLength
    case noLetter
    case noNumber
    case noNumberandLetter
    case noNumberandLength
    case noLetterandLength
    case noAll
    case noError

    var errorMessages: String? {
        switch self {
        case .noLength:
            return "Error Password No Lenght"
        case .noLetter:
            return "Error No Letter New Password"
        case .noNumber:
            return "Error No Number New Password"
        case .noNumberandLetter:
            return "Error No Number And Letter New Password"
        case .noNumberandLength:
            return "Error No Number And Length New Password"
        case .noLetterandLength:
            return "Error No Letter And Length New Password"
        case .noAll:
            return "Error No All New Password"
        case .noError:
            return nil
        }
    }
}
