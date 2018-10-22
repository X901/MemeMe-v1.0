//
//  SentMemesDetails.swift
//  MemeMe
//
//  Created by X901 on 21/10/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import UIKit

class SentMemesDetails: UIViewController {

    var image : UIImage? = nil
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = image {
            memeImageView.image = image

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false

    }


}
