#
class Api::Me::ShareMovieController < ::Api::AuthController
  def call
    form = MovieForm.new(permitted_params)
    unless form.valid?
      render_form_error(form)
      return
    end

    movie = MovieService::Creator.new(current_user, permitted_params).exec

    render json: ApiSerializer::Movie.new(movie, root: :data), status: :created
  end

  private

  def permitted_params
    params.permit(
      :url
    )
  end
end

