class Scrapingbook
    require 'nokogiri'
    require 'open-uri'
    require 'uri'
    def books_point_repair()
        #@books = Book.all
        #@books.each do |book|
            book = Book.find(304)
            if book.classificationcode == 1
                blog = "ブログ "
            else
                blog = nil
            end
            book.id
        #end
    end
end