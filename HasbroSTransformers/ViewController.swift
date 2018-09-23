//
//  ViewController.swift
//  HasbroSTransformers
//
//  Created by Pooya on 2018-09-22.
//  Copyright © 2018 Amir. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var buttonTitle: UIButton!
    @IBOutlet weak var actIndicateView: UIActivityIndicatorView!
    
    let relativeFontNavTitle:CGFloat = 0.035
    let relativeFontButton:CGFloat = 0.060
    let relativeFontCellTitle:CGFloat = 0.023
    let relativeFontCellDescription:CGFloat = 0.015
    
    let api = API()
    let tTools = TransformerTools()
    
    var transformerBattles : [Transformer] = []
    
    var preloadedImage : [String : UIImage] = [:]
    var deceptImage : UIImage?
    var questionImage : UIImage?
    var autobotloseCount = 0
    var deceptloseCount = 0
    var destroyList : [Transformer] = []

    override func viewDidAppear(_ animated: Bool) {
        let nav = self.navigationController?.navigationBar

        autobotloseCount = 0
        deceptloseCount = 0
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow

//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 100))
//        imageView.contentMode = .scaleAspectFit

//        let image = UIImage(named: "transformersLogos")
//        imageView.image = image
        
//        navigationItem.titleView = imageView
        navigationItem.title = "Hasbro’s Transformers"
        
        print("ViewDidAppear")
        let transformerMain = api.getTransformers()
        let (transformerA , transformerD) = tTools.separateByFields(transformers: transformerMain)
        transformerBattles = tTools.makeBattelsList(transformerA: transformerA, transformerD: transformerD)
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        destroyList = []
        questionImage = UIImage(contentsOfFile: "questionMark")
        
        let transformerMain = api.getTransformers()
        var imagesList = findImageList(transformers: transformerMain)
        for oneImage in imagesList {
            preloadedImage[oneImage.key] = preLoadImage(imagePath: oneImage.value)
        }

        let (transformerA , transformerD) = tTools.separateByFields(transformers: transformerMain)
        transformerBattles = tTools.makeBattelsList(transformerA: transformerA, transformerD: transformerD)
        
        print(transformerMain.count)
        print(transformerA.count)
        print(transformerD.count)
        
        //collectionView.collectionViewLayout = CustomImageLayout()
        buttonTitle.titleLabel?.font = buttonTitle.titleLabel?.font.withSize(self.view.frame.height * relativeFontButton)
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

        
//        if (cellIndex % 2 == 0) {
//            cell.leftCellImage.isHidden = true
//        } else {
//            cell.rightCellImage.isHidden = true
//        }
        
        
        cell.cellEditBtn.customizeButtonG1()
        cell.cellDeleteBtn.customizeButtonG1()

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
        let endurance = "Endurance: " + String(thisTransformer.endurance) + "\n"
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
    
    @IBAction func battlesAct(_ sender: UIButton) {
        //TODO Battle
        let transformerMain = api.getTransformers()
        let (transformerA , transformerD) = tTools.separateByFields(transformers: transformerMain)
        transformerBattles = tTools.makeBattelsList(transformerA: transformerA, transformerD: transformerD)
        self.collectionView.reloadData()
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
        
        actIndicateView.alpha = 1.0
        print("hello paddData \(index)")
        let vc =  storyboard?.instantiateViewController(withIdentifier: "DetailsAddOrEdit") as? DetailsViewController
        vc?.keyIndex = transformerBattles[index].id
        vc?.oneTransformer = transformerBattles[index]
        vc?.typeValue = "Edit"
        print("Delete")
        print(transformerBattles[index].id)
        self.navigationController?.pushViewController(vc!, animated: true)
        actIndicateView.alpha = 0.0
    }
    
    func deleteData(index: Int) {
        actIndicateView.alpha = 1.0
        print("hello deleteData \(index)")
        print("Delete")
        print(transformerBattles[index].id)
        api.deleteTransformer(transformer: transformerBattles[index])  
        transformerBattles.remove(at: index)
        let transformerMain = api.getTransformers()
        let (transformerA , transformerD) = tTools.separateByFields(transformers: transformerMain)
        transformerBattles = tTools.makeBattelsList(transformerA: transformerA, transformerD: transformerD)
        collectionView.reloadData()
        actIndicateView.alpha = 0.0
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


class CustomImageLayout: UICollectionViewFlowLayout {
    
    var numberOfColumns:CGFloat = 2.0
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    override var itemSize: CGSize {
        set { }
        get {
            let itemWidth = (self.collectionView!.frame.width - (self.numberOfColumns - 1)) / self.numberOfColumns
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 1 // Set to zero if you want
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
}
