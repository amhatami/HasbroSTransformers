//
//  ResultViewController.swift
//  HasbroSTransformers
//
//  Created by Pooya on 2018-09-22.
//  Copyright © 2018 Amir. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var resultDescription: UILabel!
    @IBOutlet weak var startBtnTitle: UIButton!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    let relativeFontButton:CGFloat = 0.060
    let relativeFontHeadTitle:CGFloat = 0.070
    let relativeFontDescription:CGFloat = 0.035
    
    var header : String = ""
    var resultDetails : String = ""
    var destroyList : [Transformer] = []
    
    let api = API()
    var apiToken : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // get token and update apiToken attr
        getToken(getNew: false, api: api)
        
        indicatorView.alpha = 0.0
        
        let frameHeight = self.view.frame.height
        let frameWidth = self.view.frame.width
        let bestFrameSize = (frameHeight > frameWidth ) ? frameHeight : frameWidth

        resultTitle.font = resultTitle.font.withSize(bestFrameSize * relativeFontHeadTitle)
        resultTitle.font = resultDescription.font.withSize(bestFrameSize * relativeFontDescription)
        resultTitle.font = resultTitle.font.withSize(bestFrameSize * relativeFontButton)

    }
    

    @IBAction func startNewAct(_ sender: UIButton) {
        indicatorView.alpha = 1.0
        for oneTransforme in destroyList {
            //api.deleteTransformer(transformer: oneTransforme)
        }
        indicatorView.alpha = 0.0
        
    }


}
