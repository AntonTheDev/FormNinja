//
//  FormNinjaField.swift
//  FormNinja-Demo
//
//  Created by Anton on 8/9/16.
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
    
    func formCell(formCellTappedNext cell: FormFieldCell)
    
    func formCell(formCellTappedPrevious cell: FormFieldCell)

    func formCell(formCellTappedDone cell: FormFieldCell)

    func formCell(formCell: FormFieldCell,
                  didChangeValue newValue: String?)

    func formCell(formCell: FormFieldCell,
                  shouldChangeCharactersInRange range: NSRange,
                                                currentValue: String?,
                                                replacementString string: String) -> Bool
}

///  MARK: - FormCollectionViewCell

class FormFieldCell : UICollectionViewCell {
    
    weak var delegate   : FormFieldCellDelegate?

    var barButtonItems : [UIBarButtonItem] = [UIBarButtonItem]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1.0
        self.backgroundColor = UIColor.yellowColor()
        layer.borderColor = UIColor.blackColor().CGColor
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
    
    // MARK: - Tap Actions
    
    func tappedDone() {
        delegate?.formCell(formCellTappedDone: self)
    }
    
    func tappedPrevious() {
        delegate?.formCell(formCellTappedPrevious: self)
    }
    
    func tappedNext() {
        delegate?.formCell(formCellTappedNext: self)
    }
    
    // MARK: - LazyLoaded Views
    
    lazy var logoImageView : UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        return imageView
    }()
    
    lazy var numberToolbar : UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.Default
        self.entryField.inputAccessoryView = toolbar
        return toolbar
    }()
    
    lazy var entryField : FormEntryTextField = {
        [unowned self] in
        let textField = FormEntryTextField(frame: CGRectZero)
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if let delegate = delegate {
            return delegate.formCell(self, shouldChangeCharactersInRange: range, currentValue: textField.text, replacementString: string)
        }
        
        return true
    }
    
    func textFieldDidChange(textField: UITextField) {
        updateConfiguration()
        delegate?.formCell(self, didChangeValue: textField.text)
    }
}