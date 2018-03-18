//
//  Presenter.swift
//  swift-mvp-prac
//
//  Created by 佐藤賢 on 2018/03/19.
//  Copyright © 2018年 佐藤賢. All rights reserved.
//

import UIKit
import SWXMLHash

protocol CatPresenter: class {
  init(view: CatView)
  
  var numberOfCats: Int { get }
  func imageUrl(index: Int) -> URL?
  func showData()
}

class CatPresenterImpl: CatPresenter {
  // ViewとModelのProtocolを参照
  private let view: CatView
  private var cats: [Cat] = []
  
  required init(view: CatView) {
    self.view = view
  }
  
  var numberOfCats: Int {
    return cats.count
  }
  
  func imageUrl(index: Int) -> URL? {
    return URL(string: cats[index].url)
  }
  
  func showData() {
    guard let url = URL(string: "http://thecatapi.com/api/images/get?format=xml&results_per_page=20&size=small") else {
      return
    }
    
    let session = URLSession(configuration: .default)
    session.dataTask(with: url) { [weak self] data, _, _ in
      
      guard let data = data else {
        return
      }
      
      let xml = SWXMLHash.parse(data)
      
      self?.cats = xml["response"]["data"]["images"]["image"].all
        .flatMap { (id: $0["id"].element?.text ?? "", url: $0["url"].element?.text ?? "") }
        .map { Cat(id: $0.id, url: $0.url) }
      
      DispatchQueue.main.async {
        self?.view.reloadData()
      }
      
      }.resume()
  }
}
