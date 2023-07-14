class BooksController < ApplicationController
  def index
   @user_books = UserBook.all
  end

  def borrow_book
    book = Book.find(params[:book_id])
    if book.quantity > 0
      user_book = UserBook.new(user_id: 1, book: book, borrowed_date: Date.today, submission_date: Date.today + 10.days, return_date: Date.today)
      if user_book.save
        book.decrement!(:quantity)
        render json: { message: "Book borrowed successfully." }
      else
        render json: { error: "Failed to borrow the book." }, status: 400
      end
    else
      render json: { error: "Book is currently unavailable." }, status: :unprocessable_entity
    end
  end

  def return_book
    user_book = UserBook.find(params[:id])

    if user_book.return_date.nil?
      user_book.return_date = Date.today

      if user_book.return_date > user_book.submission_date
        #fine_amount = calculate_fine(user_book.return_date, user_book.submission_date)
        fine_amount = (return_date - submission_date)*10
        user_book.fine = fine_amount
        flash[:error] = "Book returned late. Fine: #{fine_amount}."
      else
        flash[:success] = "Book returned successfully."
      end
      book = user_book.book
      book.increment!(:quantity)
      user_book.save
      render json: {message: "Book submitted"}
    else
      flash[:error] = "Book has already been returned."
    end
  end
end
