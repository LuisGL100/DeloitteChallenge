//
//  PhotosViewController.swift
//  FlickrRx
//
//  Created by Luis López on 8/8/21.
//

import RxCocoa
import RxSwift
import UIKit

class PhotosViewController: UIViewController {
    var viewModel: PhotosViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PhotosViewController: BindableType {
    func bindViewModel() {
        
    }
}
