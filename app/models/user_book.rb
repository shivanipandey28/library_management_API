  class UserBook < ApplicationRecord
    belongs_to :user
    belongs_to :book
    before_create :decrease_book_quantity
    before_destroy :increase_book_quantity

    private

    def decrease_book_quantity
      book.decrement!(:quantity)
    end

    def increase_book_quantity
      book.increment!(:quantity)
    end
  end
