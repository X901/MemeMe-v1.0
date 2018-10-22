//
//  EditorViewController.swift
//  MemeMe
//
//  Created by X901 on 19/10/2018.
//  Copyright © 2018 X901. All rights reserved.
//

import UIKit


class EditorViewController: UIViewController  {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextfield: UITextField!
    
    @IBOutlet weak var bottomTextfield: UITextField!
    
    @IBOutlet weak var topToolbar: UIToolbar!
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextAttributes(textfield: topTextfield)
        setTextAttributes(textfield: bottomTextfield)

        defualtText()
        
        
        shareButton.isEnabled = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
subscribeToKeyboardNotifications()
        subscribeToHideKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()

    }
    
    //Mark: pick Image from Album
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        choosePickerTypr(type: .photoLibrary)
    }
    
    //Mark: pick Image from Camera
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        choosePickerTypr(type: .camera)
    }
    
    func choosePickerTypr(type :UIImagePickerController.SourceType){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = type
        present(pickerController, animated: true, completion: nil)

    }
    
    func setTextAttributes(textfield: UITextField){
        
        textfield.delegate = self
        
        let memeTextAttributes:[NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -4]
        
        textfield.defaultTextAttributes = memeTextAttributes
        
        textfield.textAlignment = .center
    }
    
    func defualtText(){
        topTextfield.text = "TOP"
        bottomTextfield.text = "BOTTOM"

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //Mark: save meme
    func save() -> Meme {
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextfield.text!, bottomText: bottomTextfield.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        
        //Add it to the memes array on the Application Delegate
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        
        return meme
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar
showOrHideTopAndBottomToolbar(isHidden:true)

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar 
        showOrHideTopAndBottomToolbar(isHidden:false)


        
        return memedImage
    }
    
    func showOrHideTopAndBottomToolbar(isHidden:Bool){
        
        if isHidden == true {
            topToolbar.isHidden = true
            bottomToolbar.isHidden = true
        }else {
            topToolbar.isHidden = false
            bottomToolbar.isHidden = false
            shareButton.isEnabled = true
        }
        
    }

    @IBAction func shareButtonClicked(_ sender: UIButton) {
        let meme = generateMemedImage()
        
        
         let controller = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                // User canceled
                print("user canceled ")
                return
            }
            // User completed activity
            print("User completed activity")

           _ = self.save()
            
            self.dismiss(animated: true, completion: nil)
            
            
        }
              present(controller, animated: true, completion: nil)

    }
    
    //Mark: Rest All
    
    @IBAction func cancelClicked(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    //Mark: Move view UP or Down when show/hide keyboard

    @objc func keyboardWillShow(_ notification:Notification){
        
        if bottomTextfield.isEditing {
        view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    
    @objc func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0

    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    func subscribeToHideKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    
    func unsubscribeToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension EditorViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
           //image found
            imagePickerView.image = image
            
            shareButton.isEnabled = true
            dismiss(animated: true, completion: nil)
            
        } else {
            print("Not able to get an image")
        }

    }
}

extension EditorViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if topTextfield.text == "TOP"{
            topTextfield.text = ""
        }
        
        if bottomTextfield.text == "BOTTOM" {
            bottomTextfield.text = ""

        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if topTextfield.text == "" {
            topTextfield.text = "TOP"
        }
        if bottomTextfield.text == ""{
            bottomTextfield.text = "BOTTOM"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
