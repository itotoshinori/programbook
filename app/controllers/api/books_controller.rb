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
        user_id = params[:user_id]
        if user_id.present?
        	user = User.find(user_id) 
			if @book.save and user.admin
				Book.new.total_point_make(params[:id])
				Book.new.category_rank_make(@book.category_code1)
				render json: show, status: 200
			else
			#render json: @book.errors, status: :unprocessable_entity
			end
        end
    end
    def create  
        @book = Book.new(book_params)
        user_id = params[:user_id]
        if user_id.present?
			user = User.find(user_id) 
			if @book.save and user.admin
				render :show, status: :created
				Book.new.total_point_make(@book.id)
				Book.new.category_rank_make(@book.category_code1)
			else
			#render  status: :unprocessable_entity, json:{ messages: @books.errors.full_messages }
				render json: @book.errors.full_messages, status: :unprocessable_entity
			end
        end
    end
    def destroy
        @book = Book.find(params[:id])
		category_code1 = @book.category_code1
        @book.destroy
        Book.new.category_rank_make(category_code1)
    end
     
    private
    def book_params
        params.permit(:id, :title, :description, :photo, :publisher, :author, :classificationcode, :category_code1, :category_code2, :category_code3, :official_site, :amazon, :rakuten, :googlebooks, :publication_date, :introductory, :evaluation, :search_point)
    end
end
