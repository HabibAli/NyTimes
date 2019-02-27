//
//  NyBaseViewModel.swift
//  Nytimes
//
//  Created by Habib Ali on 26/06/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit
@objc protocol NYBaseViewModelDelegate: NSObjectProtocol {
    
    @objc optional func modelDidStartLoading()
    @objc optional func modelDidLoad()
    @objc optional func modelFailedToLoadWithError(_ error: Error?)
    @objc optional func showError(title:String?, message:String)
    @objc optional func reloadData()
    @objc optional func showFilterMenu()
    @objc optional func showVideo()
}

protocol NYViewModelDelegate: NYBaseViewModelDelegate {
    
    func userIntraction(enable: Bool)
    func showProgressHud()
    func showProgressHud(_ status:String)
    func hideProgressHud()
    func pushViewController(vc:UIViewController)
    func changeNavigationVisibility(status:Bool)
    func switchTab(tabIndex: Int)
    func showTaskCompleted(withMessage: String)
    func viewStoryboard() -> UIStoryboard
    func performSegue(name:String)
    func presentAlert(alert:UIAlertController)
    func dismiss()
}

class NYBaseViewModel: NSObject {
    /** The controller which is using this view model object, so that it can be notified in case of any events. */
    //weak var delegate: KTViewModelDelegate?
    weak var delegate : NYViewModelDelegate?
    
    /**
     * Initializes a new view model object.
     *
     * @param delegate The controller which is using this view model object, so that it can be notified in case of any events.
     */
    init(del: Any) {
        super.init()
        delegate = del as? NYViewModelDelegate
        
    }
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidAppear()  {
        
    }
    
    func viewWillDisappear() {
        
    }
    
    func showError(error e: Any){
        if let error : NYError = e as? NYError{
            self.delegate!.showError!(title: error.title, message: error.message!)
        }
        else {
            self.delegate!.showError!(title: Constants.ErrorTitle.GenralError, message: Constants.ErrorMessage.GenralError)
        }
    }
}
