#
module Me
  class MoviesController < AuthController
    def index
      @collection = paging scoped
    end

    def create
      form = MovieForm.new(permitted_params)
      unless form.valid?
        flash[:alert] = []
        form.errors.full_messages.each do |message|
          flash[:alert] << message
        end

        return redirect_back fallback_location: nil
      end

      MovieService::Creator.new(current_user, permitted_params).exec

      redirect_to root_path
    end

    private

    def permitted_params
      params.require(:resource).permit(:user_id, :url)
    end

    def fetch_movie_ids
      UserMovie.select('movie_id').where(user_id: current_user_id)
    end

    def scoped
      Movie.where(id: fetch_movie_ids).order(id: :desc)
    end
  end
end