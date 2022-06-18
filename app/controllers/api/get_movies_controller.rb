#
class Api::GetMoviesController < ::Api::ApplicationController
  def call
    collection = paging scoped

    render json: CollectionSerializer.new(
      collection,
      ApiSerializer::Movie,
      root: :data,
      meta: {
        paging: PagingSerializer.new(collection).to_hash
      },
    ), status: :ok
  end

  private

  def scoped
    Movie.order(id: :desc)
  end
end

