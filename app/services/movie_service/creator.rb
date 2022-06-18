# MovieService::Creator.new(params).exec
module MovieService
  class Creator
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def exec
      params[:id] = IdentifierService.new.generate(::Movie, 0)
      ::Faq.create(params)
    end
  end
end
