class Scrapingbook
    require 'nokogiri'
    require 'open-uri'
    require 'uri'
    def books_point_repair()
        @books = Book.all
        #@books.each do |book|
            book = Book.find(302)
            if book.classificationcode == 1
                blog = "ブログ "
            else
                blog = nil
            end
            target = "#{blog}#{book.title} #{book.author} #{book.publisher}" 
            target_url = URI.encode_www_form(q: target)
            url = "https://cgi.search.biglobe.ne.jp/cgi-bin/search-period?#{target_url}&num=10&lr=all&as_qdr=y"
            html = URI.open(url).read
            doc = Nokogiri::HTML.parse(html)
            if doc.at_css('.hitCo01').present?
                search_count = doc.at_css('.hitCo01').search('strong').text.to_i
            else
                search_count = 0
            end
            book.point = search_count
            book.save
            book.point
        #end
    end
end