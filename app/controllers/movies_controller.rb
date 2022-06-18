#
class MoviesController < ApplicationController
  def index
    # TODO maybe except owner videos
    @collection = paging ::Movie.order(id: :desc)
    render 'movies/index'
  end
end