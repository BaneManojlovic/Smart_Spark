//
//  ValidationError.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.11.24..
//

import Foundation

enum ValidationError: Error {
    case nameEmpty
    case nameInvalid
    case emailEmpty
    case emailInvalid
    case passwordEmpty
    case passwordInvalid
    case repeatPasswordEmpty
    case repeatPasswordInvalid
    case passwordsDontMatch
}
