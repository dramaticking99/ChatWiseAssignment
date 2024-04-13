//
//  SecondScreenTableViewController.swift
//  ChatWiseAssignment
//
//  Created by Chetan Sanwariya on 11/04/24.
//

import UIKit

class SecondScreenTableViewController: UITableViewController , ProductManagerDelegate {
    
    var products : [ProductModal] = []
    var productImages : [UIImage] = []
    
    let productManager = ProductManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loading the initial product images with the default images
        let loadingImage  = UIImage(named: "Loading-2")
        productImages = Array(repeating: loadingImage!, count: 30)
        
        productManager.delegate = self
        productManager.fetchProductData()
        
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "productCell")
        
        settingUpSectionHeader()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if products.count == 0 {
            return 1
        } else {
            return products.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if products.count == 0 {
            // return a loading spinner cell (Activity Indidcator)
            let cell = tableView.dequeueReusableCell(withIdentifier: "loaderCell", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        
        let product = products[indexPath.row]
        
        cell.productImageView.image = productImages[indexPath.row]
        cell.productTitleLabel.text = product.title
        cell.productDescriptionLabel.text = product.description
        
        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if products.count == 0 {
            //for showing the loading spinner before the table view is loaded (Activity Indicator)
            return 50
        } else {
            return 180
        }
    }
    
    // MARK: - Did fetch methods
    
    func didFetchImage(image: UIImage, indexPath: IndexPath) {
        productImages[indexPath.row] = image
        tableView.reloadData()
    }
    
    func didLoadProductData(productsArray: [ProductModal]) {
        products = productsArray
        self.tableView.reloadData()
        
        //Loading the images one by one after the Product Data is loaded
        var i = 0
        for product in products {
            let indexPath = IndexPath(row: i, section: 0)
            productManager.fetchImage(imageURL: product.images[0] , indexPath: indexPath)
            i += 1
        }
    }
    
    //MARK: - Header and footer setup Functions
    
    func settingUpSectionHeader() {
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.frame.width,
                                          height: 50 ))
        
        let headerLabel = UILabel(frame: CGRect(origin: CGPoint(x: header.frame.origin.x + 16,
                                                                y: header.frame.origin.y),
                                                size: header.frame.size ))
        headerLabel.text = "Product List"
        headerLabel.textAlignment = .left
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        header.addSubview(headerLabel)
        
        header.backgroundColor = .systemBackground
        tableView.tableHeaderView = header
    }
    
}
