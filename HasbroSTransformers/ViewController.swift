//
//  ViewController.swift
//  HasbroSTransformers
//
//  Created by Amir on 2018-09-22.
//  Copyright © 2018 Amir. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    
    // outlet connection to the main viewcontroller
    @IBOutlet weak var welcomeMsg: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var battlebuttonTitle: UIButton!
    
    // multiple number to creat font size based on device screen size
    let relativeFontWelcomeTitle:CGFloat = 0.045
    let relativeFontButton:CGFloat = 0.060
    let relativeFontCellTitle:CGFloat = 0.023
    let relativeFontCellDescription:CGFloat = 0.015
    
    //instance to classes API ,TransformerTools and model
    let api = API()
    let transformerTools = TransformerTools()
    var transformerBattles : [Transformer] = []
    
    // variables to keep data for finding winners and speed up app
    var preloadedImage : [String : UIImage] = [:]
    var losersCount = ["A": 0, "D": 0 ]
    var destroyList : [Transformer] = []
    var showBattleResult : Bool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate and dataSource
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //customizing navigationController
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
        navigationItem.title = "Hasbro’s Transformers"
        
        // handeling welcome Message for first time load
        welcomeMsg.text = welcomeMsgText
        welcomeMsg.textColor = UIColor.yellow
        welcomeMsg.font = welcomeMsg.font.withSize(self.view.frame.height * relativeFontWelcomeTitle)
        welcomeMsg.isHidden = false
        
        // get token and update apiToken attr
        getToken(getNew: true, api: api)
        
        // get list of all trasformers from transformers-api
        let transformerMain = api.getTransformers()
        
        // handeling welcome Message for first time load after loading all trasformers
        if transformerMain.count == 0 {
            welcomeMsg.isHidden = false
        } else {
            welcomeMsg.isHidden = true
        }
        
        // pre load images from web to speed up collection view scrolling
        preloadedImage = getURLImagesListAndPreLoadThem(transformersList: transformerMain)
        
        // separate main trasformer list to Autobots and Decepticons sorted lists by rank
        let (transformerA , transformerD) = transformerTools.separateByFields(transformers: transformerMain)
        
        // join Autobots and Decepticons lists and make transformer battle list
        transformerBattles = transformerTools.makeBattelsList(transformerA: transformerA, transformerD: transformerD)
        
        //customize battle button and scale font size based on screen size
        battlebuttonTitle.customizeBattleButton()
        battlebuttonTitle.titleLabel?.font = battlebuttonTitle.titleLabel?.font.withSize(self.view.frame.height * relativeFontButton)
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        // refresh collectionview in case of viewDidAppear
        losersCount = ["A": 0, "D": 0 ]
        showBattleResult = false
        self.collectionView.reloadData()
        
        // get list of all trasformers to update collection with last change in detailes controler
        let transformerMain = api.getTransformers()
        
        // handeling welcome Message for first time load after loading all trasformers
        if transformerMain.count == 0 {
            welcomeMsg.isHidden = false
        } else {
            welcomeMsg.isHidden = true
        }
        
        let imagesList = findImageList(transformers: transformerMain)
        for oneImage in imagesList {
            preloadedImage[oneImage.key] = preLoadImage(imagePath: oneImage.value)
        }
        let (transformerA , transformerD) = transformerTools.separateByFields(transformers: transformerMain)
        transformerBattles = transformerTools.makeBattelsList(transformerA: transformerA, transformerD: transformerD)
        collectionView.reloadData()
    }
    
    
    // UICollectionViewDelegate, UICollectionViewDataSource functions
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
        
        // set back ground to regular first
        cell.backgroundColor =  UIColor(hex: "FFFFFF")
        cell.cellImage.alpha = 1.0
        cell.cellTitle.textColor = UIColor.purple
        cell.cellDetails.textColor = UIColor.black
        
        // count losers and keep them also handeling fighters Status with background
        switch selfWin {
        case "win":
            if showBattleResult {
                cell.backgroundColor =  UIColor(hex: "AFFFAC")
                cell.cellImage.alpha = 1.0
                cell.cellTitle.textColor = UIColor.purple
                cell.cellDetails.textColor = UIColor.black
            }
            break
        case "lose":
            if showBattleResult {
                cell.backgroundColor =  UIColor(hex: "f8f8f8")
                cell.cellImage.alpha = 0.2
                cell.cellImage.tintColor = UIColor(hex: "EB9597")
                cell.cellTitle.textColor = UIColor(hex: "EB9597")
                cell.cellDetails.textColor = UIColor(hex: "EB9597")
            }
            if thisTransformer.name == "" {
                // No Action
            } else if thisTransformer.team == "A" {
                losersCount["A"] = losersCount["A"]! + 1
                destroyList.append(thisTransformer)
            } else {
                losersCount["D"] = losersCount["D"]! + 1
                destroyList.append(thisTransformer)
            }
            break
        default:
            if showBattleResult {
                cell.backgroundColor =  UIColor(hex: "D5D7FF")
                cell.cellImage.alpha = 0.8
                cell.cellTitle.textColor = UIColor.purple
                cell.cellDetails.textColor = UIColor.black
            }
        }
        cell.index = indexPath
        cell.delegate = self
        
        return cell
    }
    
    // delete item by indexpath
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        //CFPropertyList.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
    }
    
    // in case device rotation from portrate to landscape or reverse reload collectionView
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape {
            collectionView.reloadData()
        } else {
            collectionView.reloadData()
        }
    }
    
    // update collcectiom in case of layout changes
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // start battle action and
    @IBAction func battlesAct(_ sender: UIButton) {
        if (battlebuttonTitle.titleLabel?.text == "Start Battle") {
            battlebuttonTitle.setTitle("Restart Game", for: .normal)
            showBattleResult = true
            battlebuttonTitle.shake(horizantaly: 8)
            collectionView.reloadData()
            
            let alert = UIAlertController(title: "Result", message: battleWinner(numA: losersCount["A"]!, numD: losersCount["D"]!), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            battlebuttonTitle.setTitle("Wait..", for: .normal)
            showBattleResult = false
            // remove losers transformers from API after final battle
            for oneTransform in destroyList {
                let _ = api.deleteTransformer(transformer: oneTransform)
            }
            battlebuttonTitle.setTitle("Start Battle", for: .normal)
            losersCount = ["A": 0, "D": 0 ]
            destroyList  = []
            let transformerMain = api.getTransformers()
            let (transformerA , transformerD) = transformerTools.separateByFields(transformers: transformerMain)
            transformerBattles = transformerTools.makeBattelsList(transformerA: transformerA, transformerD: transformerD)
            collectionView.reloadData()
        }
        
    }
    
    // show or hide Edit and Delete buttons
    @IBAction func editAct(_ sender: UIButton) {
        if (editButton.title == "Done" ) {
            editButton.title = "Edit"
        }  else {
            editButton.title = "Done"
        }
        self.collectionView.reloadData()
    }
    
    // pushViewController controler to  DetailsViewController
    @IBAction func addAct(_ sender: UIButton) {
        print("hello paddData \(index)")
        let vc =  storyboard?.instantiateViewController(withIdentifier: "DetailsAddOrEdit") as? DetailsViewController
        vc?.keyIndex = ""
        vc?.typeValue = "Add"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}


