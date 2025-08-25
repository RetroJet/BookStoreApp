//
//  BookRepository.swift
//  BookStoreApp
//
//  Created by Nazar on 24.07.2025.
//

protocol IBookRepository {
    func getBookTypes() -> [BookType]
}

class BookRepository {}

extension BookRepository: IBookRepository {
    func getBookTypes() -> [BookType] {
        [
            BookType(type: "Выбор редакции📚", books: [
                Book(image: "book1", title: "Подводное бормотание", isNew: true),
                Book(image: "book2", title: "Один в поле воен", isNew: true),
                Book(image: "book3", title: "Мне ничего не жаль"),
                Book(image: "book4", title: "Кто ты воин?", isNew: true),
                Book(image: "book5", title: "Можно я с тобой?")
            ]),
            BookType(type: "Новинки в подписке🛎", books: [
                Book(image: "book6", title: "Мы все сможем"),
                Book(image: "book7", title: "Мотивация"),
                Book(image: "book8", title: "Деградация", isNew: true),
                Book(image: "book9", title: "Параллельные прямые")
            ]),
            BookType(type: "Топ месяца🔥", books: [
                Book(image: "book10", title: "Как перестать быть дураком"),
                Book(image: "book11", title: "Зачем все это?", isNew: true),
                Book(image: "book12", title: "Путь к точке", isNew: true),
                Book(image: "book13", title: "Выйди и зайди нормально", isNew: true)
            ])
        ]
    }
}
