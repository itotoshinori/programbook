class Api::BooksController < ApplicationController
    def index
        @books = Book.order("category_code1").order('total_point DESC').order('publication_date DESC')
        catgory = params[:category_id]
        if catgory
            @books = @books.where(category_code1:catgory)
        end
    end
    def show
        @book = Book.find(params[:id])
    end
    def update
        @book = Book.find(params[:id])
        @book.update(book_params)
        if @book.save
          Book.new.total_point_make(params[:id])
          Book.new.category_rank_make(params[:id])
          render json: show, status: 200
        else
          render json: @book.errors, status: :unprocessable_entity
        end
    end
    def create  
        @book = Book.new(book_params)
        if @book.save
          render :show, status: :created
          Book.new.total_point_make(@book.id)
          Book.new.category_rank_make(@book.id)
        else
          render json: @book.errors, status: :unprocessable_entity
        end
    end
    def destroy
        Book.find(params[:id]).destroy 
    end
     
    private
    def book_params
        params.permit(:id, :title, :description, :photo, :publisher, :author, :classificationcode, :category_code1, :category_code2, :category_code3, :official_site, :amazon, :rakuten, :googlebooks, :publication_date, :introductory, :evaluation, :search_point)
    end
end
