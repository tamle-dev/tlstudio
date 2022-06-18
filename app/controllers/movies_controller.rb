#
class MoviesController < ApplicationController
  def index
    render 'movies/index'
  end

  def create
    ap params
    redirect_to root_path
  end

  private

  def permitted_params
    params.permit(:url)
  end
end