class ScrapingsController < ApplicationController
  def index
    @title = Scrapingbook.new.books_point_repair()
  end
end
