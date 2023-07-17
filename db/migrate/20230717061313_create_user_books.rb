class CreateUserBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :user_books do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :borrowed_date
      t.date :submission_date
      t.date :return_date

      t.timestamps
    end
  end
end
