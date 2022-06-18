class CreateUserMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :user_movies do |t|
      t.integer :user_id, limit: 8
      t.integer :movie_id, limit: 8

      t.timestamps
    end

    add_index :user_movies, :user_id
    add_index :user_movies, :movie_id
    add_index :user_movies, [:user_id, :movie_id], unique: true, name: 'user_movies_uniq_idx'
  end
end
