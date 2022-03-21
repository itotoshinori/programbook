class Api::BooksController < ApplicationController
    def index
        @books = Book.order("category_code1").order('publication_date DESC')
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
          render :show, status: :updated
        else
          render json: @book.errors, status: :unprocessable_entity
        end
    end
    def create
        @book = Book.new(book_params)
        if @book.save
          render :show, status: :created
        else
          render json: @book.errors, status: :unprocessable_entity
        end
    end
    def destroy
        Book.find(params[:id]).destroy
    end
     
    private
    def book_params
        params.permit(:title, :description, :photo, :publisher, :author, :classificationcode, :category_code1, :category_code2, :category_code3, :official_site, :amazon, :rakuten, :publication_date)
    end
end
