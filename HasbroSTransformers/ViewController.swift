//
//  ViewController.swift
//  HasbroSTransformers
//
//  Created by Pooya on 2018-09-22.
//  Copyright © 2018 Amir. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var welcomeMsg: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var battlebuttonTitle: UIButton!
    
    let relativeFontWelcomeTitle:CGFloat = 0.045
    let relativeFontButton:CGFloat = 0.060
    let relativeFontCellTitle:CGFloat = 0.023
    let relativeFontCellDescription:CGFloat = 0.015
    
    let api = API()
//    var apiToken : String = ""
    let tTools = TransformerTools()
    
    var transformerBattles : [Transformer] = []
    
    var preloadedImage : [String : UIImage] = [:]
    var autobotloseCount = 0
    var deceptloseCount = 0
    var destroyList : [Transformer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get token and update apiToken attr
        getToken(getNew: true, api: api)
        
        // get list of all trasformesr from transformers-api
        let transformerMain = api.getTransformers()
        
        // pre load images from web to speed up collection view scrolling
        preloadedImage = getURLImagesListAndPreLoadThem(transformersList: transformerMain)

        // separate main trasformer list to Autobots and Decepticons sorted lists by rank
        let (transformerA , transformerD) = tTools.separateByFields(transformers: transformerMain)

        // join Autobots and Decepticons lists and make transformer battle list
        transformerBattles = tTools.makeBattelsList(transformerA: transformerA, transformerD: transformerD)
        
        //customize battle button and scale font size based on screen size 
        battlebuttonTitle.customizeBattleButton()
        battlebuttonTitle.titleLabel?.font = battlebuttonTitle.titleLabel?.font.withSize(self.view.frame.height * relativeFontButton)
    }

    override func viewDidAppear(_ animated: Bool) {
        let nav = self.navigationController?.navigationBar
        
        autobotloseCount = 0
        deceptloseCount = 0
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
        navigationItem.title = "Hasbro’s Transformers"
        
        let transformerMain = api.getTransformers()
        
        if transformerMain.count == 0 {
            welcomeMsg.text = welcomeMsgText
            welcomeMsg.textColor = UIColor.yellow
            welcomeMsg.font = welcomeMsg.font.withSize(self.view.frame.height * relativeFontWelcomeTitle)
            welcomeMsg.isHidden = false
        } else {
            welcomeMsg.isHidden = true
        }
        
        
        let imagesList = findImageList(transformers: transformerMain)
        for oneImage in imagesList {
            preloadedImage[oneImage.key] = preLoadImage(imagePath: oneImage.value)
        }
        let (transformerA , transformerD) = tTools.separateByFields(transformers: transformerMain)
        transformerBattles = tTools.makeBattelsList(transformerA: transformerA, transformerD: transformerD)
        collectionView.reloadData()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transformerBattles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let thisTransformer = transformerBattles[indexPath.item]
        let cellIndex = indexPath.item

        let frameHeight = self.view.frame.height
        let frameWidth = self.view.frame.width
        let bestFrameSize = (frameHeight > frameWidth ) ? frameHeight : frameWidth
        
        // MARK : Find and Mark am I winner
        var selfWin = "win"
        if (cellIndex % 2 == 0 && cellIndex + 1 <= transformerBattles.count ) {
            let vsTransformer = transformerBattles[cellIndex + 1]
            selfWin = thisTransformer.amIWinnerVS(vsTransformer: vsTransformer)
        }  else if (cellIndex % 2 == 1 && cellIndex >= 1 ) {
            let vsTransformer = transformerBattles[cellIndex - 1]
            selfWin = thisTransformer.amIWinnerVS(vsTransformer: vsTransformer)
        } else {
            selfWin = "win"
        }

        
        cell.cellEditBtn.customizeEditButton()
        cell.cellDeleteBtn.customizeDeleteButton()

        if (editButton.title == "Done" && thisTransformer.name != "" ) {
            cell.cellDeleteBtn.isHidden = false
            cell.cellEditBtn.isHidden = false
        }  else {
            cell.cellDeleteBtn.isHidden = true
            cell.cellEditBtn.isHidden = true
        }
        
        let rank = "Rank: " + String(thisTransformer.rank) + "\n"
        let strength = "Strength " + String(thisTransformer.strength) + "\n"
        let courage = "Courage: " + String(thisTransformer.courage) + "\n"
        let skill = "Skill: " + String(thisTransformer.skill) + "\n"
        let intelligence = "Intelligence: " + String(thisTransformer.intelligence) + "\n"
        let speed = "Speed: " + String(thisTransformer.speed) + "\n"
        let firepower = "Firepower: " + String(thisTransformer.firepower) + "\n"
//        let endurance = "Endurance: " + String(thisTransformer.endurance) + "\n"
        let teamName = "Team: " + thisTransformer.getTeamName() + "\n"

        cell.cellImage.image = preloadedImage[thisTransformer.team]
        cell.cellTitle.text = thisTransformer.name
        cell.cellTitle.font = cell.cellTitle.font.withSize(bestFrameSize * relativeFontCellTitle)
        cell.cellDetails.text =  (thisTransformer.name == "" ) ? "" : rank + strength + courage + intelligence + speed + firepower + skill + teamName
        cell.cellDetails.font = cell.cellDetails.font.withSize(bestFrameSize * relativeFontCellDescription)
        


        switch selfWin {
        case "win":
            cell.backgroundColor =  UIColor(hex: "AFFFAC")
            cell.cellImage.alpha = 1.0
            cell.cellTitle.textColor = UIColor.purple
            cell.cellDetails.textColor = UIColor.black
            break
        case "lose":
            cell.backgroundColor =  UIColor(hex: "f8f8f8")
            cell.cellImage.alpha = 0.2
            cell.cellImage.tintColor = UIColor(hex: "EB9597")
            cell.cellTitle.textColor = UIColor(hex: "EB9597")
            cell.cellDetails.textColor = UIColor(hex: "EB9597")
            if thisTransformer.team == "A" {
                autobotloseCount = autobotloseCount + 1
            } else {
                deceptloseCount = deceptloseCount + 1
            }
            break
        default:
            cell.backgroundColor =  UIColor(hex: "D5D7FF")
            cell.cellImage.alpha = 0.8
            cell.cellTitle.textColor = UIColor.purple
            cell.cellDetails.textColor = UIColor.black
        }

        
        
        
        
        
        cell.index = indexPath
        cell.delegate = self
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        //CFPropertyList.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
    }
    // MARK: Make battle and go to the result view
    @IBAction func battlesAct(_ sender: UIButton) {
        // TODO : Battle
        let transformerMain = api.getTransformers()
        let (transformerA , transformerD) = tTools.separateByFields(transformers: transformerMain)
        transformerBattles = tTools.makeBattelsList(transformerA: transformerA, transformerD: transformerD)
        self.collectionView.reloadData()
        
        
//        let vc =  storyboard?.instantiateViewController(withIdentifier: "DetailsAddOrEdit") as? DetailsViewController
//        vc?.keyIndex = transformerBattles[index].id
//        vc?.oneTransformer = transformerBattles[index]
//        vc?.typeValue = "Edit"
//        print("Delete")
//        print(transformerBattles[index].id)
//        self.navigationController?.pushViewController(vc!, animated: true)

        
        
    }

    @IBAction func editAct(_ sender: UIButton) {
        if (editButton.title == "Done" ) {
            editButton.title = "Edit"
        }  else {
            editButton.title = "Done"
        }
        self.collectionView.reloadData()
    }

    @IBAction func addAct(_ sender: UIButton) {
        print("hello paddData \(index)")
        let vc =  storyboard?.instantiateViewController(withIdentifier: "DetailsAddOrEdit") as? DetailsViewController
        vc?.keyIndex = ""
        vc?.typeValue = "Add"
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let vc =  storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        //        vc?.name = imgArray[indexPath.row]
        //        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape {
            collectionView.reloadData()
        } else {
            collectionView.reloadData()
        }
    }
    
    
}


extension ViewController : DataCollectionProtocol {
    func passData(index: Int) {
        
        print("hello paddData \(index)")
        let vc =  storyboard?.instantiateViewController(withIdentifier: "DetailsAddOrEdit") as? DetailsViewController
        vc?.keyIndex = transformerBattles[index].id
        vc?.oneTransformer = transformerBattles[index]
        vc?.typeValue = "Edit"
        print("Delete")
        print(transformerBattles[index].id)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func deleteData(index: Int) {
        print("hello deleteData \(index)")
        print("Delete")
        print(transformerBattles[index].id)
        _ = api.deleteTransformer(transformer: transformerBattles[index])
        transformerBattles.remove(at: index)
        let transformerMain = api.getTransformers()
        let (transformerA , transformerD) = tTools.separateByFields(transformers: transformerMain)
        transformerBattles = tTools.makeBattelsList(transformerA: transformerA, transformerD: transformerD)
        collectionView.reloadData()
    }
}



extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let heightVal = self.view.frame.height
        let widthVal = self.view.frame.width
        let heightMul : CGFloat = (heightVal < widthVal) ? 2.0 : 4.0
        
        return CGSize(width: bounds.width / 2  , height:  bounds.height / heightMul )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
