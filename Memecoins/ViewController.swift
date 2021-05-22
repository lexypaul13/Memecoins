//
//  ViewController.swift
//  Memecoins
//
//  Created by Alex Paul on 5/22/21.
//

import UIKit

class ViewController: UIViewController {
    var memecoins = [Data]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getMemecoins()
    }

    
    func getMemecoins(){
        NetworkManger.shared.get(.tokens, urlString: "") { [weak self] (result: Result<[Data]?, ErroMessage> ) in
            guard let self = self else { return }
            switch result{
            case .success(let memecoins):
                self.memecoins = memecoins ?? []
                print(self.memecoins)
                
            
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }

}
}
