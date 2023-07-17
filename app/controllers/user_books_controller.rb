class UserBooksController < ApplicationController
  def index
    @user_books = current_user.user_books
    render json: @user_books
  end

  def borrowed_book
    byebug
    book = Book.find(params[:id])
    if book.quantity > 0
      user_book = UserBook.new(user_id: current_user.id, book_id: book.id, borrowed_date: Date.today, submission_date: Date.today + 10.days)
      if user_book.save
        render json: { message: "book borrowed successfully." } 
      else 
        render json: { message: "failed to borrow." }
      end
    else 
      render json: { message: "Book is currently not available." }
    end
  end
end
