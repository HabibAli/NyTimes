//
//  NYBaseViewController.swift
//  Nytimes
//
//  Created by Habib Ali on 25/06/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit
import SVProgressHUD

class NYBaseViewController: UIViewController {

    var viewModel : NYBaseViewModel?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
//        print("deinit \(String(describing: self))")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel?.viewDidLoad()
        
        if self.navigationController != nil{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.viewDidAppear()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        viewModel?.viewWillDisappear()
    }
    
    //Implement only when custom back button is required.
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func showError(title:String?, message:String)
    {
        let altError = UIAlertController(title: title,message: message,preferredStyle:UIAlertControllerStyle.alert)
        
        altError.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil ))
        self.present(altError,animated: true, completion: nil)
    }
    
    func showAlertWithActions(vc: UIViewController, title: String, message:String,actions:[UIAlertAction])
    {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions{
            alertView.addAction(action)
        }
        vc.present(alertView, animated: true, completion: nil)
    }
    
    func openUrl(url:String){
        guard let _url = URL(string: url) else { return }
        UIApplication.shared.open(_url)
    }
    
    
    @objc func showProgressHud() {
        
        SVProgressHUD.show();
        SVProgressHUD.setDefaultAnimationType(.native)
        userIntraction(enable: false)
    }
    
    @objc func showProgressHud(_ status: String) {
        SVProgressHUD.show(withStatus: status)
        SVProgressHUD.setDefaultAnimationType(.native)
        
        userIntraction(enable: false)
    }
    
    @objc func hideProgressHud() {
        
        SVProgressHUD.dismiss()
        userIntraction(enable: true)
    }
    
    @objc func showNetworkIndicator(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    @objc func hideNetworkIndicator(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    @objc func pushViewController(vc:UIViewController){
        if let nav = self.navigationController{
            nav.pushViewController(vc, animated: true)
        }
    }
    
    func changeNavigationVisibility(status:Bool){
        self.navigationController?.setNavigationBarHidden(status, animated: false)
    }
    
    @objc func presentAlert(alert:UIAlertController){
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func switchTab(tabIndex: Int){
        self.tabBarController?.selectedIndex = tabIndex
    }
    
    @objc func showTaskCompleted(withMessage msg: String) {
        //SVProgressHUD.show(UIImage(named: "light-check-mark")!, status: msg)
        //SVProgressHUD.dismiss(withDelay: 1.0)
    }
    
    @objc func userIntraction(enable: Bool) {
        
        if enable {
            
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        else {
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            
        }
    }
    
    @objc func viewStoryboard() -> UIStoryboard {
        return self.storyboard!
        
    }
    
    @objc func dismiss()  {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func performSegue(name:String) {
        
        self.performSegue(withIdentifier: name, sender: self)
    }
    
    
    func isLargeScreen() -> Bool {
        var large : Bool = false
        let horizontalClass : UIUserInterfaceSizeClass = self.traitCollection.horizontalSizeClass
        let verticalCass : UIUserInterfaceSizeClass  = self.traitCollection.verticalSizeClass;
        
        if horizontalClass == .regular && verticalCass == .regular {
            large = true
        }
        return large
    }
}
