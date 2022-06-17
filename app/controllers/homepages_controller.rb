#
class HomepagesController < ApplicationController
  def index
    render 'homepages/index', layout: false
  end
end