//
//  Controller.swift
//  swift-mvc-prac
//
//  Created by 佐藤賢 on 2018/03/17.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import SWXMLHash

class CatListVC: UIViewController {
  
  private lazy var collectionView: UICollectionView = {
    let cellWidth = self.view.frame.width / 3
    let layout = CatCollectionViewLayout(itemSize: cellWidth)
    
    let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
    collectionView.register(CatListCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    collectionView.refreshControl = refreshControl
    
    return collectionView
  }()
  
  // Modelを参照
  fileprivate var cats: [Cat] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Cat List"
    
    setupUI()
    fetchData { [weak self] cats in
      self?.cats = cats
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    }
  }
  
  private func setupUI() {
    view.addSubview(collectionView)
  }
  
  @objc private func reloadData() {
    fetchData { [weak self] cats in
      self?.cats = cats
      DispatchQueue.main.async {
        self?.collectionView.refreshControl?.endRefreshing()
        self?.collectionView.reloadData()
      }
    }
  }
  
  // 猫の画像を取得
  private func fetchData(completion: @escaping (([Cat]) -> Void)) {
    guard let url = URL(string: "http://thecatapi.com/api/images/get?format=xml&results_per_page=20&size=small") else {
      completion([])
      return
    }
    
    let session = URLSession(configuration: .default)
    session.dataTask(with: url) { data, _, _ in
      
      guard let data = data else {
        completion([])
        return
      }
      
      let xml = SWXMLHash.parse(data)
      
      let cats = xml["response"]["data"]["images"]["image"].all
        .flatMap { (id: $0["id"].element?.text ?? "", url: $0["url"].element?.text ?? "") }
        .map { Cat(id: $0.id, url: $0.url) }
      
      completion(cats)
      
      }.resume()
  }
}

extension CatListVC: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cats.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CatListCell else {
      return UICollectionViewCell()
    }
    
    cell.configure(with: URL(string: cats[indexPath.row].url))
    
    return cell
  }
}
