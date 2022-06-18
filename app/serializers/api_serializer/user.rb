# ApiSerializer::User.new(collection, root: :data)
module ApiSerializer
  class User < ResourceSerializer
    attributes  :id,
                :username
  end
end
