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
    
    var unsortedFilms = Set<Film>()
    
    public func addFilmToTableView(name:String?,year:String?){
        if let filmName = name, name != "",
           let year = Int(year!){
            let film = Film(name: filmName, year: year)
            
            let tmpSetCount = unsortedFilms.count
              unsortedFilms.insert(film)
            
            if unsortedFilms.count > tmpSetCount {
                films.append(film)
            }else {
                let alert = UIAlertController(title: "Whoops", message: "film allready added", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
                alertHandler?(alert)
            }
        }
        else {
            let alert = UIAlertController(title: "Whoops", message: "please add all info", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
            alertHandler?(alert)
        }
    }
}
