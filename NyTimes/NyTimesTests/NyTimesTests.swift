//
//  NyTimesTests.swift
//  NyTimesTests
//
//  Created by Habib Ali on 28/02/2019.
//  Copyright © 2019 Folio3. All rights reserved.
//

import XCTest

class NyTimesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNYMostViewedArticleModel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        var article = NYArticle()
        article.title = "Title"
        article.abstract = "Abstract"
        var mediaObjs = [MediaObj]()
        var media = MediaObj()
        var metaDatas = [MediaMetaData]()
        var metadata = MediaMetaData()
        metadata.url = "http://imageurl.com"
        metaDatas.append(metadata)
        media.mediaMetadata = metaDatas
        mediaObjs.append(media)
        article.media = mediaObjs
        let model = NYMostViewedArticleModel(del:self)
        var articles = [NYArticle]()
        articles.append(article)
        model.articles = articles
        let indexPath = IndexPath(row: 0, section: 0)
        let data = model.dataForIndexPath(indexPath: indexPath) as! [String:Any]
        
        XCTAssert(model.numberOfSections(in: UITableView()) == 1, "Number of sections should be equal to 1")
        XCTAssert(model.tableView(UITableView(), numberOfRowsInSection: 0) == articles.count, "Number of rows should be equal to articles count")
        XCTAssert((data[NYBaseCellConstant.Identifier] as! String) == NYArticleCell.identifier, "Identifier should be equal to article cell's identifier")
        XCTAssert((data[NYArticleCellConstant.ArticleTitle] as! String) == article.title, "Data title should be equal to article title")
        XCTAssert((data[NYArticleCellConstant.ArticleDesc] as! String) == article.abstract, "Data description should be equal to article description")
        XCTAssert((data[NYArticleCellConstant.ArticleImageUrl] as! String) == metadata.url, "Data image url should be equal to article image url")
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
