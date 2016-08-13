//
//  FormNinjaField.swift
//  FormNinja
//
//  Created by Anton Doudarev on 8/8/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import Foundation
import UIKit

/**
 *  FormEntryTextField Interface Configuration
 */

struct FormEntryTextFieldConfig {
    static var FontPlaceholder      = UIFont(name: "Helvetica", size: 12.0)
    static var TrackingPlaceholder  = CGFloat(100)
    
    static var ColorBackground      = UIColor.lightGrayColor()
    static var ColorSeparator       = UIColor.lightGrayColor()
    static var ColorPlaceholder     = UIColor.lightGrayColor()
    static var ColorTextEntry       = UIColor.lightGrayColor()
    
    static var PaddingHorizontalSeparator   = CGFloat(10)
    static var PaddingVerticalSeparator     = CGFloat(2)
}

protocol FormFieldCellDelegate : class {
    func formCell(formCell: FormFieldCell,
                  didChangeValue newValue: String?)

    func formCell(formCell: FormFieldCell,
                  shouldChangeCharactersInRange range: NSRange,
                                                currentValue: String?,
                                                replacementString string: String) -> Bool
}

///  MARK: - FormCollectionViewCell

class FormFieldCell : UICollectionViewCell {
    
    var fieldType : FieldType?
    
    weak var delegate : FormFieldCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInterface()
    }
    
    // MARK: - Bootstrap Logic
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutInterface()
    }

    // MARK: - LazyLoaded Views
    
    lazy var logoImageView : UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        return imageView
    }()

    lazy var entryField : FormEntryTextField = {
        [unowned self] in
        let textField = FormEntryTextField(frame: CGRectZero)
        textField.backgroundColor = UIColor.darkGrayColor()
        textField.delegate = self
        textField.addTarget(self, action: #selector(FormFieldCell.textFieldDidChange(_:)),
                            forControlEvents: UIControlEvents.EditingChanged)
        return textField
        }()
}

// MARK: - Bootstrap

extension FormFieldCell {
    
    func setupInterface() {
        contentView.addSubview(logoImageView)
        contentView.addSubview(entryField)
    }
    
    func configuredAccessoryBar() {
   
    }
    
    func layoutInterface() {
        /*
        logoImageView.sizeToFit()
        logoImageView.align(toFrame: contentView.bounds,
                            withSize: logoImageView.bounds.size,
                            horizontal: .LeftEdge,
                            vertical: .Center,
                            horizontalOffset: logoImageView.bounds.width == 0 ? 0 : 20.0)
        
        let textFiedWidth  = contentView.bounds.width - (logoImageView.frame.maxX + (2.0 * 20.0))
        let entryFieldSize = CGSizeMake(textFiedWidth, 40.0)
        */
        entryField.frame = contentView.bounds
    }
    
    func updateConfiguration() {

    }
}

func CGCSRectEdgeInset(inputFrame : CGRect, edgeInsets : UIEdgeInsets) -> CGRect {
    var retval :CGRect  = CGRectMake(inputFrame.origin.x + edgeInsets.left, inputFrame.origin.y + edgeInsets.top, 0, 0)
    retval.size.width = CGRectGetWidth(inputFrame) - (edgeInsets.left + edgeInsets.right)
    retval.size.height = CGRectGetHeight(inputFrame) - (edgeInsets.top + edgeInsets.bottom)
    return retval
}

// MARK: - UITextFieldDelegate

extension FormFieldCell : UITextFieldDelegate {
    
    override func becomeFirstResponder() -> Bool {
        return self.entryField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return self.entryField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return false
    }
    
    func textField(textField: UITextField,
                   shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool {
        
        if let delegate = delegate {
            return delegate.formCell(self,
                                     shouldChangeCharactersInRange: range,
                                     currentValue: textField.text,
                                     replacementString: string)
        }
        
        return true
    }
    
    func textFieldDidChange(textField: UITextField) {
        updateConfiguration()
        delegate?.formCell(self, didChangeValue: textField.text)
    }
}