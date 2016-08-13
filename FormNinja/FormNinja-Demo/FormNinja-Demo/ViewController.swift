//
//  ViewController.swift
//  FormNinja-Demo
//
//  Created by Anton on 8/9/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        layoutInterface()
    }
    
    func setupInterface() {
        view.addSubview(formView)
        view.backgroundColor = UIColor.lightGrayColor()
    }
    
    func layoutInterface() {
        formView.frame = CGRectMake(0, 40, view.bounds.width, view.bounds.height - 40.0)
    }

    //MARK: Lazy loaded views
    
    lazy var formView : FormView = {
        [unowned self] in
        var form : FormView = FormView(frame: CGRectZero)
        form.dataSource = self
        form.backgroundColor = UIColor.lightGrayColor()
        return form
    }()
}

extension ViewController : FormViewDataSource {
    
    func fieldTypesFormView(formView: FormView) -> [FieldType] {
        return [.firstName, .middleInitial, .lastName]
    }

    func formView(formView: FormView, sizeForFormField type : FieldType) -> CGSize {
        switch type {
        case .lastName:
            return CGSizeMake(formView.bounds.width, 60)
        default:
            return CGSizeMake(formView.bounds.width / 2.0, 60)
        }
    }
    
    func formView(formView: FormView, placeHolderForFormField type : FieldType) -> String {
        switch type {
        case .firstName:
            return "First Name"
        case .middleInitial:
            return "Mmiddle Initial"
        case .lastName:
            return "Last Name"
        default :
            return ""
        }
    }
    
    func formView(formView: FormView, sizeForForFieldType type : FieldType) -> CGSize {
        switch type {
        case .lastName:
            return CGSizeMake(formView.bounds.width, 60)
        default:
            return CGSizeMake(formView.bounds.width / 2.0, 60)
        }
    }
}

