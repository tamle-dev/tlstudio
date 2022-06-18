#
module ApiSerializer
  class Resource < ResourceSerializer
    attributes  :id,
                :created_at,
                :updated_at

    def created_at
      object.created_at.to_i
    end

    def updated_at
      object.updated_at.to_i
    end
  end
end
