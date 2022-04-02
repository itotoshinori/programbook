class Book < ApplicationRecord
    validates :photo, presence: true
    validates :publisher, presence: true
    validates :author, presence: true
    validates :classificationcode, presence: true, numericality: {only_integer: true}
    validates :category_code1, presence: true, numericality: {only_integer: true}
    validates :official_site, presence: true
    validates :publication_date, presence: true
    validates :introductory, inclusion: [true, false]
    
    def total_point_make(id)
        book = Book.find(id)
        evaluation = book.evaluation
        search_point = book.search_point
        total_point = (evaluation-4)*50 + search_point
        book.total_point = total_point
        book.save
    end
    def category_rank_make(category_code1)
        #book = Book.find(id)
        books = Book.where(category_code1:category_code1).order('total_point DESC').order('publication_date DESC')
        rank = 1
        books.each do |book_category|
            book_category.category_rank = rank
            book_category.save
            rank = rank + 1
        end
    end
end
