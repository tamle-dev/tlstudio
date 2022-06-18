# ApiSerializer::Movie.new(collection, root: :data)
module ApiSerializer
  class Movie < ResourceSerializer
    attributes  :id,
                :url,
                :external_like,
                :external_comment,
                :external_view,
                :external_code,
                :title,
                :description,
                :author
  end
end
