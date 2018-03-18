//
//  CatCollectionViewLayout.swift
//  swift-mvp-prac
//
//  Created by 佐藤賢 on 2018/03/19.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit

class CatCollectionViewLayout: UICollectionViewFlowLayout {
  convenience init(itemSize: CGFloat) {
    self.init()
    self.itemSize = CGSize(width: itemSize, height: itemSize)
    sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    minimumInteritemSpacing = 0
    minimumLineSpacing = 0
  }
}
