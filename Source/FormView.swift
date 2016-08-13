//
//  FormNinjaView.swift
//  FormNinja
//
//  Created by Anton Doudarev on 8/8/16.
//  Copyright © 2016 Anton Doudarev. All rights reserved.
//

import Foundation
import UIKit

protocol FormViewDataSource : class {
    func fieldTypesFormView(formView: FormView) -> [FieldType]
    func formView(formView: FormView, sizeForFormField type : FieldType) -> CGSize
    func formView(formView: FormView, placeHolderForFormField type : FieldType) -> String
}

protocol FormViewDelegate : class {
    func fieldTypesFormView(formView: FormView) -> [FieldType : Any]
}

class FormView: UIView {
 
    weak var dataSource : FormViewDataSource?
    
    var typingAttributes : Dictionary<String , AnyObject>?
    var placeHolderAttributes : Dictionary<String , AnyObject>?

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if formCollectionView.superview == nil {
            addSubview(formCollectionView)
        }
        
        formCollectionView.frame = self.bounds
    }

    //MARK: Lazy loaded views
    
    lazy var formCollectionView : UICollectionView = {
        [unowned self] in
        
        let flowLayout  = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        
        var collectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout : flowLayout)
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerClass(FormFieldCell.self, forCellWithReuseIdentifier: "FormFieldCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        }()
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension FormView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.fieldTypesFormView(self).count ?? 0
    }
    
    func collectionView(collectionView : UICollectionView,
                        layout collectionViewLayout:UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize {
        
        guard  let dataSource = dataSource else {
            return CGSizeMake(collectionView.bounds.width, 0.0)
        }
        
        let fieldType = dataSource.fieldTypesFormView(self)[indexPath.row]
       
        return  dataSource.formView(self, sizeForFormField: fieldType)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FormFieldCell", forIndexPath: indexPath) as! FormFieldCell
        
        let fieldType = dataSource?.fieldTypesFormView(self)[indexPath.row]
        
        cell.fieldType = fieldType
        cell.entryField.placeholder = dataSource?.formView(self, placeHolderForFormField: fieldType!)
       
        return cell
    }
}