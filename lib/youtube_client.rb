require 'api_client'

# YoutubeClient.new.get_code(url)
# YoutubeClient.new.get_video_info(code)
class YoutubeClient < ApiClient
  attr_reader :api_key

  def initialize
    super(
      url: ENV['YOUTUBE_API_URL'],
      headers: {
        'Content-Type' => 'application/json'
      }
    )
    @api_key = ENV['YOUTUBE_API_KEY']
  end

  def get_video_info(code)
    resp = get_json "/v3/videos?id=#{code}&key=#{api_key}&part=snippet,statistics"
    JSON.parse resp.body
  end

  def get_code(url)
    regex = /(?:http:|https:)*?\/\/(?:www\.|)(?:youtube\.com|m\.youtube\.com|youtu\.|youtube-nocookie\.com).*(?:v=|v%3D|v\/|(?:a|p)\/(?:a|u)\/\d.*\/|watch\?|vi(?:=|\/)|\/embed\/|oembed\?|be\/|e\/)([^&?%#\/\n]*)/
    matches = regex.match(url)

    return unless matches

    matches[1]
  end
end