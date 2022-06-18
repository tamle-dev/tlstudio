class CreateMovieTags < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_tags do |t|
      t.integer :movie_id, limit: 8
      t.integer :tag_id, limit: 8

      t.timestamps
    end

    add_index :movie_tags, :movie_id
    add_index :movie_tags, :tag_id
    add_index :movie_tags, [:movie_id, :tag_id], unique: true, name: 'movie_tags_uniq_idx'
  end
end
