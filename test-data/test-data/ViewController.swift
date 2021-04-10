//
//  ViewController.swift
//  test-data
//
//  Created by Macbook Pro on 10.04.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadData {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadData(completed: @escaping () -> ()) {
         let key = "cYCglVmJb7SypYTm2p8kk9e8BUnXmVcG1rHbodCBDIs"
         let url = "https://api.unsplash.com/photos/random/?count=30&client_id=\(key)"

         let session = URLSession(configuration: .default)
         session.dataTask(with: URL(string: url)!) { (data, _, error) in
             guard let data = data else {
                 print("URLSession data task error: ", error ?? "nil")
                 return
             }
             do {
                self.photos = try JSONDecoder().decode([Photo].self, from: data)
                
                DispatchQueue.main.async {
                    completed()
                }
             } catch{
                 print("Error::", error.localizedDescription)
             }
         }.resume()
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if photos.count != 0 {
            return photos.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        if photos.count == 0 {
            cell.textLabel?.text = "empty array"
        } else {
            cell.textLabel?.text = photos[indexPath.row].alt_description
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: "showDetails", sender: self)
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            destination.photo = photos[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
