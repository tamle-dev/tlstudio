class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :url
      t.integer :user_id, limit: 8
      t.integer :external_like
      t.integer :external_comment
      t.integer :external_view
      t.string :external_code
      t.string :title
      t.text :description
      t.string :author

      t.timestamps
    end

    add_index :movies, :user_id
    add_index :movies, :external_code
  end
end
