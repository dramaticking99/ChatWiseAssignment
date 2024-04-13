//
//  ProductManager.swift
//  ChatWiseAssignment
//
//  Created by Chetan Sanwariya on 11/04/24.
//

import UIKit
import Alamofire

protocol ProductManagerDelegate : AnyObject {
    func didLoadProductData(productsArray : [ProductModal])
    func didFetchImage(image : UIImage, indexPath: IndexPath)
}

class ProductManager {
    
    var delegate : ProductManagerDelegate?
    
    func fetchProductData() {
        let url = "https://dummyjson.com/products"
        
        AF.request(url,interceptor: .none).responseDecodable(of: Products.self) { response in
            
            switch response.result {
            case .success(let productsArray):
                self.delegate?.didLoadProductData(productsArray: productsArray.products)
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchImage(imageURL : String, indexPath : IndexPath) {
        
        AF.request(imageURL,interceptor: .none).responseData { response in
            
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.delegate?.didFetchImage(image: image, indexPath: indexPath)
                } else {
                    print("Error converting the data to image")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

