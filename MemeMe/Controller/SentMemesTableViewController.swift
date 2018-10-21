//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by X901 on 21/10/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController {

    @IBOutlet weak var tableViewMemes: UITableView!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        tableViewMemes.reloadData()
    }
    

}


extension SentMemesTableViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "showDetails") as! SentMemesDetails
        detailController.image = memes[indexPath.row].memedImage
            
            self.navigationController!.pushViewController(detailController, animated: true)

    }
    
}

extension SentMemesTableViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      
        return memes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeTableCell") as! SentMemesTableViewCell
        
        cell.imageViewMeme.image = memes[indexPath.row].memedImage
        cell.topLable?.text = memes[indexPath.row].topText
        cell.bottomLabel?.text = memes[indexPath.row].bottomText
        
        return cell

    }
    
    
}

