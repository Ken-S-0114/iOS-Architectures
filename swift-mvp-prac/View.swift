//
//  View.swift
//  swift-mvp-prac
//
//  Created by 佐藤賢 on 2018/03/19.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import Kingfisher

protocol CatView: class {
  func reloadData()
}

class CatListVC: UIViewController, CatView {
  private lazy var collectionView: UICollectionView = {
    let cellWidth = self.view.frame.width / 3
    let layout = CatCollectionViewLayout(itemSize: cellWidth)
    
    let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
    collectionView.register(CatListCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    collectionView.refreshControl = refreshControl
    
    return collectionView
  }()
  
  // PresenterのProtocol参照
  var presenter: CatPresenter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Cat List"
    
    setupUI()
    // Presenterに処理を委譲
    presenter.showData()
  }
  
  func setupUI() {
    view.addSubview(collectionView)
  }
  
  @objc func pullToRefresh() {
    presenter.showData()
  }
  
  func reloadData() {
    collectionView.refreshControl?.endRefreshing()
    collectionView.reloadData()
  }
  
}

// MVCではController内で記述していたがMVPではView内で記述(処理はPresenterに委譲)
extension CatListVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter.numberOfCats
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CatListCell else {
      return UICollectionViewCell()
    }
    
    // 画像を表示する処理をPresenterに委譲
    cell.configure(with: presenter.imageUrl(index: indexPath.row))
    
    return cell
  }
}

// MVCと同じView内に記述
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
