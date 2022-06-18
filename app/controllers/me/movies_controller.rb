#
module Me
  class MoviesController < AuthController
    def create
      ap params
      redirect_to root_path
    end

    def new
    end

    private

    def permitted_params
      params.permit(:url)
    end
  end
end