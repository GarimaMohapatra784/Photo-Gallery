//
//  PhotoGridCollectionViewCell.swift
//  Photo Gallery
//
//  Created by Garima Mohapatra on 5/12/20.
//

import UIKit
import AlamofireImage

final class PhotoGridCollectionViewCell: UICollectionViewCell, CellConfigurable {
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var photoLabel: UILabel!
    
    func configure(with viewModel: CellViewModel) {
        photoLabel.text = viewModel.authorName
        if viewModel.shouldDownloadPhoto {
            DispatchQueue.main.async {
                let filter = AspectScaledToFillSizeFilter(size: self.photoImageView.frame.size)
                
                // viewModel.shouldDownloadPhoto checks if the URL is nil or not, so it is sufficiently fine to force unwrap this property as viewModel.photoURL!
                self.photoImageView.af.setImage(
                    withURL: viewModel.photoURL!,
                    placeholderImage: UIImage(named: "PlaceholderImage"),
                    filter: filter,
                    imageTransition: .crossDissolve(0.2),
                    runImageTransitionIfCached: true)
            }
        } else {
            photoImageView.image = UIImage(named: "PlaceholderImage")
        }
        
        applyStyle(.default)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        photoImageView.af.cancelImageRequest()
        photoImageView.layer.removeAllAnimations()
        photoImageView.image = nil
        photoLabel.text = nil
    }

}

extension PhotoGridCollectionViewCell: Styleable {

    func applyStyle(_ style: Style) {
        photoLabel.font = style.photoLabelFont
        photoLabel.textColor = style.photoLabelFontColor
    }
    
    struct Style: Equatable {
        let photoLabelFont: UIFont
        let photoLabelFontColor: UIColor
        
        static let `default` = Style(photoLabelFont: .boldSystemFont(ofSize: 16), photoLabelFontColor: .black)
    }
}

