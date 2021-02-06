//
//  SecondViewController.swift
//  GCD
//
//  Created by Timur Begishev on 06.02.2021.
//

import UIKit

class SecondViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	fileprivate var imageURL: URL?
	fileprivate var image: UIImage? {
		get { return imageView.image }
		set {
			activityIndicator.stopAnimating()
			imageView.image = newValue
			imageView.sizeToFit()
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

        fetchImage()
    }
    
	fileprivate func fetchImage() {
		activityIndicator.startAnimating()
		imageURL = URL(string: "https://wallpapertag.com/wallpaper/full/7/5/3/129013-margot-robbie-harley-quinn-wallpaper-3200x2000-smartphone.jpg")
		
		let queue = DispatchQueue.global(qos: .utility)
		queue.async { [weak self] in
			guard let url = self?.imageURL,
				  let imageData = try? Data(contentsOf: url)
			else { return }
			DispatchQueue.main.async {
				self?.image = UIImage(data: imageData)
			}
		}
	}

}
