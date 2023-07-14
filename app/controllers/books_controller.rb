class BooksController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_book, only: [:show,:update,:destroy]

  def index
    @books = Book.all
    render json: @books
  end

  def show
    render json: @book
  end

  def create
    @user = User.find(params[:user_id])
    @book = @user.books.new(book_params)
    if @book.save
      render json: @book
    else 
      render error: { error: 'Unable to create book.' }, status: 400
    end
  end

  def update
    if @book.update(book_params)
      render json: { message: 'Book updated successfully'}, status: 200
    else 
      render json: {error: 'Unable to update' }, status: 400
    end
  end

  def destroy
    if @book
    @book.destroy
    render json: { message: 'Book deleted successfully'}, status: 200
   else
    render json: { error: 'Unable to delete '}, status: 400
   end
  end

  private

  def book_params
    params.require(:book).permit(:title, :language, :author, :status, :description, :quantity, :price, :category_id, :condition_id, :user_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
