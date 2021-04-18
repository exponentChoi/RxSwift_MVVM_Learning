//
//  MovieCell.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/17.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    static let identifier = String(describing: MovieCell.self)

    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        // Initialization code
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        let width = UIScreen.main.bounds.width
        contentView.frame.size = CGSize(width: (width / 3) - 4, height: (width / 3) + 20)
    }
    
    func setItem(imageURL: String?) {
        if let str = imageURL, let url = URL(string: str) {
            posterImage.kf.setImage(with: url)
        }
    }
}
