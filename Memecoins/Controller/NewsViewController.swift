//
//  NewsViewController.swift
//  Memecoins
//
//  Created by Alex Paul on 8/6/21.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var news = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArticles()
        configureTableView()
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getArticles(){
        NetworkManger.shared.getNews { [weak self] results in
            guard let self = self else{return}
            switch results{
            case .success(let news):
                self.news = news.articles ?? []
                print(self.news)
                DispatchQueue.main.async {self.tableView.reloadData()}
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let stories = news
       if segue.identifier == "articles"{
           let destinationController = segue.destination as! ArticleViewController
        destinationController.website = stories[(tableView.indexPathForSelectedRow?.row)!]
       }
   }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "news", for: indexPath) as! NewsTableViewCell
        let article = news[indexPath.row]
        cell.newsTitle.text = article.source?.name
        cell.newsDate.text = article.publishedAt?.convertToDisplayFormat()
        cell.newsDescription.text = article.articleDescription
        cell.newsImage.downloadImage(from: article.urlToImage ?? "No Image")
        return cell
    }
    
}
