//
//  Validator.swift
//  FormNinja
//
//  Created by Anton Doudarev on 8/8/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import Foundation

enum ValidationResult<Value, ValidationError> {
    case Success(Value)
    case Failure(ValidationError)
}

enum ValidationError: ErrorType {
    case InvalidFirstName
    case InvalidMiddleInitial
    case InvalidLastName
    case InvalidEmail
    case InvalidUserID
    case InvalidPassword
    case InvalidComplexPassword
    case InvalidPhoneNumber
    
    static func errorForFieldType(type : FieldType) -> ValidationError {
        switch type {
        case .firstName:
            return .InvalidFirstName
        case .middleInitial:
            return .InvalidMiddleInitial
        case .lastName:
            return .InvalidLastName
        case .fullName:
            return .InvalidFirstName
        case .email:
            return .InvalidEmail
        case .userid:
            return .InvalidUserID
        case .password:
            return .InvalidPassword
        case .passwordcomplex:
            return .InvalidComplexPassword
        case .phonenumber:
            return .InvalidPhoneNumber
        }
    }
}

func ~= (input: String, pattern: String?) -> Bool {
    if let pattern = pattern {
        return Regex(pattern).validate(input)
    }
    return false
}

class Regex {
    
    let expression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        self.expression = try! NSRegularExpression(pattern: pattern,  options: [.CaseInsensitive])
    }
    
    func validate(input: String) -> Bool {
        return self.expression.firstMatchInString(input, options:[], range: NSMakeRange(0, input.characters.count)) != nil
    }
}

class Validator {
    
    var fieldType : FieldType
    
    init(type : FieldType) {
        fieldType = type
    }
    
    func validate(value : String) -> ValidationResult<String, ValidationError> {
        if value ~= fieldType.expression {
            return .Success(value)
        }
        
        return .Failure(ValidationError.errorForFieldType(fieldType))
    }
}