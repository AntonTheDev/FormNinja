//
//  FormEntryTextField.swift
//  FormNinja
//
//  Created by Anton Doudarev on 8/8/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import Foundation
import UIKit


/**
 *  FormEntryTextField 
 *  Custom Textfield with separator
 */

class FormEntryTextField : UITextField {
    
    override func caretRectForPosition(position: UITextPosition) -> CGRect {
        var caretFrame = super.caretRectForPosition(position)
        caretFrame.size.width = 1.0
        caretFrame.origin.y = caretFrame.origin.y - 1.0
        return caretFrame
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    func setupTextField() {
        opaque = false
        contentMode = .Bottom
        backgroundColor = UIColor.clearColor()
        tintColor = UIColor.darkGrayColor()
        textColor = FormEntryTextFieldConfig.ColorTextEntry
        autocapitalizationType = .None
        autocorrectionType = .No
        textAlignment = .Left
        returnKeyType = .Done
        keyboardType = .NumberPad
        allowsEditingTextAttributes = true
        addSubview(separatorView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        /*
        separatorView.align(toFrame: bounds,
                            withSize: CGSizeMake(self.bounds.width - FormEntryTextFieldConfig.PaddingHorizontalSeparator, 1),
                            horizontal: .Center,
                            vertical: .Base,
                            verticalOffset: -FormEntryTextFieldConfig.PaddingVerticalSeparator,
                            horizontalOffset: -FormEntryTextFieldConfig.PaddingHorizontalSeparator)
 */
    }
    
    lazy var separatorView : UIView = {
        var view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.purpleColor()
        view.backgroundColor = FormEntryTextFieldConfig.ColorSeparator
        return view
    }()
}

extension FormEntryTextField {
    /*
    func customTypingAttributes() -> Dictionary<String , AnyObject> {
        return customAttributes( FormEntryTextFieldConfig.FontPlaceholder,
                                tracking: FormEntryTextFieldConfig.TrackingPlaceholder,
                                textAlignment: NSTextAlignment.Left,
                                color : UIColor.whiteColor())
    }
    
    func newPlaceholderAttributedString(name : String) -> NSAttributedString {
        return attriburedString(name,
                                font: FormEntryTextFieldConfig.FontPlaceholder,
                                tracking: FormEntryTextFieldConfig.TrackingPlaceholder,
                                textAlignment: NSTextAlignment.Left,
                                color : FormEntryTextFieldConfig.ColorPlaceholder)
    }
     */
}

