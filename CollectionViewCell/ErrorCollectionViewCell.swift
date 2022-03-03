//
//  ErrorCollectionViewCell.swift
//  Photo Gallery
//
//  Created by Garima Mohapatra on 5/12/20.
//

import UIKit

final class ErrorCollectionViewCell: UICollectionViewCell, CellConfigurable {

    @IBOutlet private weak var errorLabel: UILabel!
    
    func configure(with model: ErrorModel) {
        errorLabel.text = model.errorText
        
        applyStyle(.default)
    }
}

extension ErrorCollectionViewCell: Styleable {

    func applyStyle(_ style: Style) {
        errorLabel.font = style.photoLabelFont
        errorLabel.textColor = style.photoLabelFontColor
    }
    
    struct Style: Equatable {
        let photoLabelFont: UIFont
        let photoLabelFontColor: UIColor
        
        static let `default` = Style(photoLabelFont: .boldSystemFont(ofSize: 16), photoLabelFontColor: .black)
    }
}
