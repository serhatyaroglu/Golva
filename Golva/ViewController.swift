//
//  ViewController.swift
//  Golva
//
//  Created by serhat yaroglu on 30.01.2021.
//

import UIKit
import Alamofire
extension UIImage {
       convenience init?(url: URL?) {
              guard let url = url else { return nil }
              do {
                     self.init(data: try Data(contentsOf: url))
              } catch {
                     print("Cannot load image from url: \(url) with error: \(error)")
                     return nil
              }
       }
}


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
  
  
    var Contacts = [Contact]()
    var apiResult : ApiResult? = nil
    var dataList : [Contact] = [Contact]()
    
  

    @IBOutlet weak var tableview: UITableView!
    override func viewWillAppear(_ animated: Bool) {
           getContacts()
           print(self.Contacts)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.reloadData()
       }
    
    
    
    func getContacts() {
           AF.request("https://api.mocki.io/v1/8610c021")
                  .validate()
                  .responseDecodable(of: ApiResult.self) {
                         (response) in
                         guard let apiResultFromResponse = response.value else{return}
                         self.Contacts = apiResultFromResponse.response.contacts
                         print(self.Contacts)
                         //print( self.apiResult!.metas.code )
                  }
        DispatchQueue.main.async {
            self.tableview.reloadData()
            //reload on main thread
                 }
        
    }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           let verticalPadding: CGFloat = 8
           let maskLayer = CALayer()
           maskLayer.cornerRadius = 12    //if you want round edges
           maskLayer.backgroundColor = UIColor.black.cgColor
           maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 1, dy: verticalPadding/6)
           cell.layer.mask = maskLayer
           let oldFrame = cell.contentView.frame
           cell.contentView.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: oldFrame.size.width + 10, height: oldFrame.size.height)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! DetailsTableViewCell
        let currentContact = Contacts[indexPath.row]
        cell.saatLabel?.text = currentContact.turSaati 
        cell.turNameLabel?.text = currentContact.turAdi
        
        tableview.reloadData()
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 2
    }
   



}
