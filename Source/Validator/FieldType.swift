//
//  Expression.swift
//  FormNinja-Demo
//
//  Created by Anton on 8/9/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import Foundation

enum FieldType : String {
    
    case firstName, middleInitial, lastName, fullName, email, userid, password, passwordcomplex, phonenumber

    var expression : String? {
        get {
            switch self {
            case .firstName:
                return "^[a-z]{3,10}$"
            case .middleInitial:
                return "^[a-z]{1,10}$"
            case .lastName:
                return "^[a-z']{3,10}$"
            case .fullName:
                return "^([a-z]+[,.]?[ ]?|[a-z]+['-]?)+$"
            case .email:
                return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            case .userid:
                return "/^[A-Za-z0-9_]{3,20}$/"
            case .password:
                return "/^[A-Za-z0-9!@#$%^&*()_]{6,20}$/"
            case .passwordcomplex:
                return "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9].*[0-9])(?=.*[^a-zA-Z0-9]).{8,}"
            case .phonenumber:
                return "^\\d{10}$"
            }
        }
    }
}