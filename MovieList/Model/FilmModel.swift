//
//  FilmModel.swift
//  MovieList
//
//  Created by никита богатырев on 31.08.2022.
//

import Foundation

struct FilmID:Equatable,Hashable{
    let film:Film
    let id:Int
}

struct Film:Equatable,Hashable {
    let name:String
    let year: Int
}
