#
module Me
  class MoviesController < AuthController
    def create
      binding.pry
      return
      redirect_to root_path
    end

    private

    def permitted_params
      params.require(:resource).permit(:url)
    end
  end
end