//
//  ViewController.swift
//  CircularStatesView-Example
//
//  Created by Or Elmaliah on 01/05/2016.
//  Copyright © 2016 Or Elmaliah. All rights reserved.
//

import UIKit
import CircularStatesView

enum MyStatesEnum: Int {
    case Awaiting, Packaging, OnMyWay, Delivered, Unknown
}

class ViewController: UIViewController {
    
    @IBOutlet private weak var statesView: CircularStatesView!
    
    private var myModelState: Int = 0
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.statesView.dataSource = self
        self.statesView.indexForStateWithActivityIndicator = MyStatesEnum.OnMyWay.rawValue
        self.statesView.stateActivityIndicatorColor = UIColor.yellowColor()
        self.statesView.circleMaxSize = 80
    }
    
    // MARK: - IBActions
    
    @IBAction private func nextButtonPressed(sender: UIButton) {
        if self.myModelState < MyStatesEnum.Delivered.rawValue {
            self.myModelState += 1
        }
        else {
            self.myModelState = 0
        }
        
        self.statesView.reloadData()
    }
}

extension ViewController: CircularStatesViewDataSource {
    
    func numberOfStatesInCircularStatesView(circularStatesView: CircularStatesView) -> Int {
        return 4
    }
    
    func circularStatesView(circularStatesView: CircularStatesView, isStateActiveAtIndex index: Int) -> Bool {
        return index <= self.myModelState
    }
    
    func circularStatesView(circularStatesView: CircularStatesView, titleForStateAtIndex index: Int) -> String? {
        let myStatesIndex = MyStatesEnum(rawValue: index) ?? .Unknown
        switch myStatesIndex {
        case .Awaiting:
            return "Awaiting Approval"
        case .Packaging:
            return "Packaging"
        case .OnMyWay:
            return "On My Way"
        case .Delivered:
            return "Delivered"
        case .Unknown:
            return ""
        }
    }
    
    func circularStatesView(circularStatesView: CircularStatesView, imageIconForActiveStateAtIndex index: Int) -> UIImage? {
        let myStatesIndex = MyStatesEnum(rawValue: index) ?? .Unknown
        switch myStatesIndex {
        case .Awaiting:
            return UIImage(named: "state_approval_on")
        case .Packaging:
            return UIImage(named: "state_in_progress_on")
        case .OnMyWay:
            return UIImage(named: "state_otw_on")
        case .Delivered:
            return UIImage(named: "state_deliverd_on")
        case .Unknown:
            return UIImage()
        }
    }
    
    func circularStatesView(circularStatesView: CircularStatesView, imageIconForInActiveStateAtIndex index: Int) -> UIImage? {
        let myStatesIndex = MyStatesEnum(rawValue: index) ?? .Unknown
        switch myStatesIndex {
        case .Awaiting:
            return UIImage(named: "state_approval_off")
        case .Packaging:
            return UIImage(named: "state_in_progress_off")
        case .OnMyWay:
            return UIImage(named: "state_otw_off")
        case .Delivered:
            return UIImage(named: "state_deliverd_off")
        case .Unknown:
            return UIImage()
        }
    }
}
