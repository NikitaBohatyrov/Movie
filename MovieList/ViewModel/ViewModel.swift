//
//  ViewModel.swift
//  MovieList
//
//  Created by никита богатырев on 31.08.2022.
//

import Foundation
import UIKit

final class ViewModel{
    
    var reloadTableView:(()->Void)?
    
    var alertHandler:((UIAlertController)->())?
    
    var films = [Film](){
        didSet{
            reloadTableView?()
        }
    }
    
    public func addFilmToTableView(name:String,year:Int){
        if 1899...2022 ~= year && name != "" {
            let film = Film(name: name, year: year)
            
            if !films.contains(where: {$0 == film}){
                films.append(film)
            }
            else {
                let alert = UIAlertController(title: "Whoops", message: "this film allready added.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
                alertHandler?(alert)
            }
        }
        else {
            let alert = UIAlertController(title: "Whoops", message: "please add existing film", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
            alertHandler?(alert)
        }
    }
}
