//
//  BookModel.swift
//  BookStoreApp
//
//  Created by Nazar on 24.07.2025.
//

struct BookType: Hashable {
    let type: String
    let books: [Book]
}

struct Book: Hashable {
    let image: String
    let title: String
    var isNew = false
}
