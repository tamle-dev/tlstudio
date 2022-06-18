# MovieService::Creator.new(user, params).exec
module MovieService
  class Creator
    attr_reader :user, :youtube_client, :params

    def initialize(user, params)
      @user           = user
      @youtube_client = YoutubeClient.new
      @params         = params
    end

    def exec
      ActiveRecord::Base.transaction do
        movie = find_or_create_movie

        create_user_movie(movie)
        
        movie
      end
    end

    private

    def external_code
      @external_code ||= youtube_client.get_code(url)
    end

    def url
      params[:url]
    end

    def find_or_create_movie
      movie = Movie.find_by(external_code: external_code)
      return movie if movie

      create_movie
    end

    def create_movie
      ::Movie.create(build_create_params)
    end

    def build_create_params
      item = movie_info['items'][0]

      snippets = item['snippet']
      title = snippets['title']
      description = snippets['description']
      author = snippets['channelTitle']

      statistics = item['statistics']
      external_like = statistics['likeCount']
      external_comment = statistics['commentCount']
      external_view = statistics['viewCount']

      create_params = {}
      create_params[:id] = IdentifierService.new.generate(::Movie, 0)
      create_params[:url] = "https://www.youtube.com/watch?v=#{external_code}"
      create_params[:external_like] = external_like
      create_params[:external_comment] = external_comment
      create_params[:external_view] = external_view
      create_params[:external_code] = external_code
      create_params[:title] = title
      create_params[:description] = description 
      create_params[:author] = author

      create_params
    end

    def movie_info
      @movie_info ||= youtube_client.get_video_info(external_code)
    end

    def create_user_movie(movie)
      user_movie = ::UserMovie.new(user_id: user.id, movie_id: movie.id)

      user_movie.save if user_movie.persisted?
    end
  end
end
