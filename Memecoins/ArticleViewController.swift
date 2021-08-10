//
//  ArticleViewController.swift
//  Memecoins
//
//  Created by Alex Paul on 8/8/21.
//

import UIKit
import WebKit
class ArticleViewController: UIViewController {

    var website: Article?
    
    @IBOutlet weak var articlePage: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: website?.url ?? "" ) {
            let request = URLRequest(url: url)
            articlePage.load(request)
        
         }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
