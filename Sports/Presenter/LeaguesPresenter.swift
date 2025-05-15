//
//  LeaugesPresenter.swift
//  Sports
//
//  Created by Macos on 14/05/2025.
//

import Foundation

class LeaugesPresenter{

    var LVC :LeaugesViewController
    var leagues : [Leauges] = []

    init(tableLeauges:TableProductsViewController){
        self.TableProducts = tableProducts
    }

}



/*

 var TableProducts :TableProductsViewController
 var products : [Products] = []
 init(tableProducts:TableProductsViewController){
     self.TableProducts = tableProducts
 }


 func getData(){

     Network.fetchDataFromJSON {[weak self] response in
         self?.products = response?.products ?? []
         DispatchQueue.main.async {
             self?.TableProducts.products  =  self?.products
             self?.TableProducts.tableView.reloadData()
         }


     }
 }

 */
