class Api::BooksController < ApplicationController
    def index
        @books = Book.order('created_at DESC')
    end
    def create
        @book = Book.new(book_params)
        if @book.save
          render :show, status: :created
        else
          render json: @book.errors, status: :unprocessable_entity
        end
    end
     
    private
    def book_params
        params.permit(:title, :description)
    end
end
