//
//  DetailsViewController.swift
//  test-data
//
//  Created by Macbook Pro on 10.04.2021.
//

import UIKit

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

class DetailsViewController: UIViewController {

    @IBOutlet weak var pic: UIImageView!
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: (photo?.urls["thumb"])!)
        pic.downloadedFrom(url: url!)
    
    }
}
