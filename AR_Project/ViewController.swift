//
//  ViewController.swift
//  AR_Project
//
//  Created by Igor Postnikov on 1/30/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://api.exchangeratesapi.io/latest?base=GBP&symbols=USD"
        getData(from: url)
    }
    
    private func getData(from url: String){
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print("failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            print(json.rates.USD)
        })
        
        task.resume()
        
        
    }
}


struct Response: Codable {
    //let results: MyResult
    let rates: MyResult
    let base: String
    let date: String
}

struct MyResult: Codable {
    let USD: Int
}
