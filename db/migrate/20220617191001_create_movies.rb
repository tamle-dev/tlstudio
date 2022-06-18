class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :url
      t.integer :external_like, limit: 8
      t.integer :external_comment, limit: 8
      t.integer :external_view, limit: 8
      t.string :external_code
      t.string :title
      t.text :description
      t.string :author

      t.timestamps
    end

    add_index :movies, :external_code
  end
end
