//
//  ChatVC.swift
//  GoChat
//
//  Created by Cex on 29/08/2016.
//  Copyright © 2016 newmediatechies. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import MobileCoreServices

class ChatVC: JSQMessagesViewController {
    var messages = [JSQMessage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.senderId = "1"
        self.senderDisplayName = "tonytone123"
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        print("pressed")
        print("\(text)")
        print("\(senderId), \(senderDisplayName)")
        messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text))
        collectionView.reloadData()
        print("\(messages)")
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        print("done")
        //chose vid or photo
        let sheet = UIAlertController(title: "media msgs", message: "select media", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel) { (alert:UIAlertAction) in
            
        }
        let photoLibrary = UIAlertAction(title: "photo library", style: UIAlertActionStyle.Default) { (alert:UIAlertAction) in
            self.getMedia(kUTTypeImage)
        }
        let videoLibrary = UIAlertAction(title: "video library", style: UIAlertActionStyle.Default) { (alert:UIAlertAction) in
            self.getMedia(kUTTypeMovie)
        }
        sheet.addAction(photoLibrary)
        sheet.addAction(videoLibrary)
        sheet.addAction(cancel)
        self.presentViewController(sheet, animated: true, completion: nil)

    }
    
    func getMedia(type: CFString) {
        print(type)
        let mediaPicker = UIImagePickerController()
        mediaPicker.delegate = self
        mediaPicker.mediaTypes = [type as String]
        self.presentViewController(mediaPicker, animated: true, completion: nil)
        //        let imagePicker = UIImagePickerController()
        //        imagePicker.delegate = self
        //        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        return bubbleFactory.outgoingMessagesBubbleImageWithColor(.blackColor())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(messages.count)
        return messages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutBtn(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginVC = storyboard.instantiateViewControllerWithIdentifier("LoginVC") as! LogInVC
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = LoginVC
    }

   }

extension ChatVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("did")
        //get img
        print(info)
        if let picture = info[UIImagePickerControllerOriginalImage] as? UIImage {
           //photo info
          let photo = JSQPhotoMediaItem(image: picture)                                                       //conver to SQ format
          messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: photo))       //add to msg array
        }
        else if let video = info[UIImagePickerControllerMediaURL] as? NSURL {
            let videoItem = JSQVideoMediaItem(fileURL: video, isReadyToPlay: true)
            messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: videoItem))
        }
        self.dismissViewControllerAnimated(true, completion: nil)                                           //dismiss picker
        collectionView.reloadData()                                                                         //reload updated array
    }
}