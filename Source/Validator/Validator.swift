//
//  Validator.swift
//  FormNinja
//
//  Created by Anton Doudarev on 8/8/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import Foundation

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
    
    func validate(value : String) -> Bool {
        if value ~= fieldType.expression {
            return true
        }
        
        return false
    }
}