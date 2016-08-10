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
    func formView(formView: FormView, sizeForForFieldType type : FieldType) -> CGSize
}

class FormView: UIView {
 
    weak var dataSource : FormViewDataSource?
    
    var typingAttributes : Dictionary<String , AnyObject>?
    var placeHolderAttributes : Dictionary<String , AnyObject>?
    /*
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(formCollectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(formCollectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        formCollectionView.frame = self.bounds
    }
    */
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
        return  dataSource.formView(self, sizeForForFieldType: fieldType)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FormFieldCell", forIndexPath: indexPath) as! FormFieldCell
        cell.fieldType = dataSource?.fieldTypesFormView(self)[indexPath.row]
        
        return cell
    }
}