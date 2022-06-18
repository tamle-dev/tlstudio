class Movie < ApplicationRecord
  has_many :user_movies
  has_many :users, through: :user_movies

  has_many :movie_tags
  has_many :tags, through: :movie_tags
end
