//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by X901 on 21/10/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UIViewController {

    @IBOutlet weak var collectionViewMemes: UICollectionView!

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      setFlowLayout()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionViewMemes.reloadData()
    }
    
    func setFlowLayout(){
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

}

extension SentMemesCollectionViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
            let detailController = self.storyboard!.instantiateViewController(withIdentifier: "showDetails") as! SentMemesDetails
            detailController.image = memes[indexPath.row].memedImage
            
            self.navigationController!.pushViewController(detailController, animated: true)
            
        }
    
}

extension SentMemesCollectionViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewMemes.dequeueReusableCell(withReuseIdentifier: "memeCollectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
        
        cell.imageViewMeme.image = memes[indexPath.row].memedImage

        return cell
    }
    
    
}
