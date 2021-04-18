//
//  MovieDetailVC.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/18.
//

import UIKit
import RxCocoa
import RxSwift

class MovieDetailVC: UIViewController {

    @IBOutlet weak var backgroundPosterImage: UIImageView!
    
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    
    
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    
    @IBOutlet weak var linkButton: UIButton!
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    
    var movieItem: MovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        title = movieItem.title
        
//        navigationController?.navigationBar.barTintColor = .yellow
//        navigationController?.navigationBar.tintColor = .blue
        
//        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow.cgColor]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
//        navigationController?.navigationBar.tintColor = UIColor.yellow.cgColor
        
        
        setupUI()
        setupBind()
        setupItem()
    }
    
    private func setupUI() {
        posterView.layer.borderWidth = 0.5
        posterView.layer.borderColor = UIColor.lightGray.cgColor
        posterView.layer.shadowOpacity = 0.7
        posterView.layer.shadowOffset = CGSize(width: 1, height: 1)
        posterView.layer.masksToBounds = false
//        posterImage.clipsToBounds = true
        
//        backgroundPosterImage.layer.borderWidth = 0.5
//        backgroundPosterImage.layer.borderColor = UIColor.lightGray.cgColor
        
//        ratingView.layer.borderWidth = 1
//        ratingView.layer.borderColor = UIColor.clear.cgColor
        ratingView.layer.cornerRadius = 25
    }
    
    private func setupItem() {
        if let url = URL(string: movieItem.image ?? "") {
            backgroundPosterImage.kf.setImage(with: url)
            posterImage.kf.setImage(with: url)
        }
        
        ratingLabel.text = movieItem.userRating ?? "0.0"
        movieTitleLabel.text = movieItem.title?.htmlEscaped
        subTitleLabel.text = movieItem.subtitle?.htmlEscaped
        dateLabel.text = movieItem.pubDate
        directorLabel.text = movieItem.director?.split(separator: "|").map { $0 }.joined(separator: ", ")
        actorLabel.text = movieItem.actor?.split(separator: "|").map { $0 }.joined(separator: ", ")
        linkButton.setTitle(movieItem.link, for: .normal)
//        movieTitleLabel.attributedText = movieItem.title?.htmlToAttributedString2
//        subTitleLabel.attributedText = movieItem.subtitle?.htmlToAttributedString2
    }
    
    private func setupBind() {
        linkButton.rx.tap.bind(onNext: { [weak self] in
            guard let `self` = self,
                  let url = URL(string: self.movieItem.link ?? "")else { return }
            UIApplication.shared.open(url, options: [:])
        }).disposed(by: disposeBag)
    }
    
}
