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
		delay(4) { [weak self] in
			self?.loginAlert()
		}
    }
	
	fileprivate func delay(_ delay: Int, closure: @escaping ()->Void) {
		DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay), execute: closure)
	}
	
	fileprivate func loginAlert() {
		let alert = UIAlertController(title: "Please login", message: "Enter your login and password", preferredStyle: .alert)
		let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
		let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
		
		alert.addAction(ok)
		alert.addAction(cancel)
		alert.addTextField { (usernameTF) in
			usernameTF.placeholder = "Login"
		}
		alert.addTextField { (passwordTF) in
			passwordTF.placeholder = "Password"
			passwordTF.isSecureTextEntry = true
		}
		
		present(alert, animated: true, completion: nil)
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
