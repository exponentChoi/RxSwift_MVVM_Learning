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

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        // Initialization code
        
//        contentView.layer.borderWidth = 1
//        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        let width = UIScreen.main.bounds.width
//        backView.frame.size = CGSize(width: (width / 3) - 0.4, height: (width / 3) + 20)
//    }
    
    func setItem(imageURL: String?) {
//        let width = UIScreen.main.bounds.width
//        backView.frame.size = CGSize(width: (width / 3) - 0.4, height: (width / 3) + 20)
//
        if let str = imageURL, let url = URL(string: str) {
            posterImage.kf.setImage(with: url)
        } else {
            posterImage.image = UIImage(named: "mv_noImage")
        }
    }
}
