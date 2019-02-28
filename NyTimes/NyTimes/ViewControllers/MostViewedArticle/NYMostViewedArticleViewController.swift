//
//  NYMostViewedArticleViewController.swift
//  Nytimes
//
//  Created by Habib Ali on 25/06/2018.
//  Copyright © 2018 Folio3. All rights reserved.
//

import UIKit

class NYMostViewedArticleViewController: NYBaseViewController,NYMostViewedArticleModelDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tblVw: UITableView!
    var vModel : NYMostViewedArticleModel?
    
    override func viewDidLoad() {
        viewModel = NYMostViewedArticleModel(del:self)
        vModel = viewModel as? NYMostViewedArticleModel
        super.viewDidLoad()
        self.tblVw.delegate = self
        self.tblVw.dataSource = self
        vModel?.loadArticles(completion: { (success, response) in
            self.tblVw.reloadData()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    //TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vModel!.numberOfSections(in: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vModel!.tableView(tableView,numberOfRowsInSection:section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = vModel?.dataForIndexPath(indexPath: indexPath) as! [String:Any]
        let cell:NYBaseCell = tableView.dequeueReusableCell(withIdentifier: data[NYBaseCellConstant.Identifier] as! String) as! NYBaseCell
        cell.configure(data: data, indexPath: indexPath)
        return cell
    }
    
}
