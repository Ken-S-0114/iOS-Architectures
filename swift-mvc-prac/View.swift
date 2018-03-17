//
//  View.swift
//  swift-mvc-prac
//
//  Created by 佐藤賢 on 2018/03/17.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import Kingfisher

class CatListCell: UICollectionViewCell {
  
  private let imageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    imageView.frame         = bounds
    imageView.contentMode   = .scaleAspectFill
    imageView.clipsToBounds = true
    addSubview(imageView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.kf.cancelDownloadTask()
    imageView.image = nil
  }
  
  func configure(with url: URL?) {
    imageView.kf.setImage(with: url)
  }
}
