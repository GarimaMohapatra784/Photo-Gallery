//
//  ViewController.swift
//  Photo Gallery
//
//  Created by Garima Mohapatra on 30/11/20.
//

import UIKit

final class ViewController: UIViewController {
        
    @IBOutlet private weak var photoGalleryCollectionView: UICollectionView! {
        didSet {
            photoGalleryCollectionView.register(UINib(nibName:"PhotoGridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"PhotoGridCollectionViewCell")
            photoGalleryCollectionView.register(UINib(nibName:"ErrorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"ErrorCollectionViewCell")
        }
    }
    
    private let viewModel: ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoGalleryCollectionView.collectionViewLayout = flowLayout
        viewModel.delegate = self
        photoGalleryCollectionView.delegate = self
        viewModel.fetchResult()
    }
    
    private var flowLayout: UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.state {
        case .loading:
        let cell = photoGalleryCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGridCollectionViewCell", for: indexPath) as! PhotoGridCollectionViewCell
        return cell
        case .success:
            let cell = photoGalleryCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGridCollectionViewCell", for: indexPath) as! PhotoGridCollectionViewCell
            
            let cellViewModel = viewModel.cellViewModels[indexPath.row]
            cell.configure(with: cellViewModel)
            
            return cell
        case .failure:
            let cell = photoGalleryCollectionView.dequeueReusableCell(withReuseIdentifier: "ErrorCollectionViewCell", for: indexPath) as! ErrorCollectionViewCell
            cell.configure(with: viewModel.errorModel)
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch viewModel.state {
        case .loading, .success:
            let padding: CGFloat = 50
            let cellSize = collectionView.frame.size.width - padding
            return CGSize(width: cellSize/2, height: cellSize/2)
        case .failure:
            let frame = view.frame.size
            return CGSize(width: frame.width, height: frame.height/3)
        }
        
      
    }
}

extension ViewController: Delegate {
    func didLoading<T>(_ viewModel: T) {
        DispatchQueue.main.async {
            self.photoGalleryCollectionView.reloadData()
        }
    }
    
    func didSucceed<T>(_ viewModel: T) {
        DispatchQueue.main.async {
            self.photoGalleryCollectionView.reloadData()
        }
    }
    
    func didFail<T,E>(_ viewModel: T, errorModel: E) {
        DispatchQueue.main.async {            
            self.photoGalleryCollectionView.reloadData()
        }
    }
}
