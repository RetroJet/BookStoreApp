//
//  BookManager.swift
//  BookStoreApp
//
//  Created by Nazar on 25.08.2025.
//

protocol IBookManager {
    func addBooks(_ items: [BookType])
    func isEmpty() -> Bool
    func getCount() -> Int
    func getAllBooks() -> [BookType]
}

class BookManager: IBookManager {
    private var books: [BookType] = []
    
    func addBooks(_ books: [BookType]) {
        self.books.append(contentsOf: books)
    }
    
    func isEmpty() -> Bool {
        books.isEmpty
    }
    
    func getCount() -> Int {
        books.count
    }
    
    func getAllBooks() -> [BookType] {
        return books
    }
}
