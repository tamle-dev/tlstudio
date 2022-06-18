# ApiClient.new.convert('USD', 'VND)
class ApiClient
  attr_reader :url, :headers, :cache_bucket
  
  def initialize(url: nil, cache_bucket: nil, headers: {})
    @url = url
    @headers = headers
    @cache_bucket = cache_bucket
  end

  protected

  def get_json(path, params = {})
    uri = request_uri(path, params)
    req = Net::HTTP::Get.new(uri, headers.merge('Content-Type' => 'application/json'))

    make_request(uri, req)
  end
  
  def post_json(path, params)
    uri = request_uri(path)
    req = Net::HTTP::Post.new(uri, headers.merge('Content-Type' => 'application/json'))
    req.body = params.to_json
    make_request(uri, req)
  end

  def post_json_with_proxy(path, proxy, params)
    proxy = URI.parse(proxy)
    uri = request_uri(path)
    req = Net::HTTP::Post.new(uri, headers.merge('Content-Type' => 'application/json'))
    req.body = params.to_json
    make_request(uri, req, proxy)
  end

  def post_json_with_follow_redirect(path, params)
    res = post_json(path, params)
    if res.is_a?(Net::HTTPRedirection)
      uri = URI(res['location'])
      req = Net::HTTP::Post.new(uri, headers.merge('Content-Type' => 'application/json'))
      req.body = params.to_json
      res = make_request(uri, req)
    end

    res
  end

  def put_json(path, params)
    uri = request_uri(path)
    req = Net::HTTP::Put.new(uri, headers.merge('Content-Type' => 'application/json'))
    req.body = params.to_json
    make_request(uri, req)
  end

  # def post_json_with_cache(path, params)
  #   return post_json(path, params) if cache_bucket.blank?
    
  #   cache_key = params.delete(:cache_key) || build_cache_key(method, path, params)
  #   cache_prefix = params.delete(:cache_prefix)
  #   cache_key = cache_prefix + "/" + cache_key if cache_prefix.present?

  #   cacheObj := NewCacheObject(apiReq.GetCacheBucket(), cacheKey)
  #   if cacheObj.IsExisted() {
  #     r, err := cacheObj.Reader()
  #     if err != nil {
  #       return nil, err
  #     }

  #     return &http.Response{Body: r}, nil
  #   }

  #   post_json(path, params)
  # end

  # def cache_object
  #   @cache_object ||= Google::Cloud::Storage.new(
  #     project_id: "my-project",
  #     credentials: "/path/to/keyfile.json"
  #   )
  # end

  def build_cache_key(method, path, params)
    uri = request_uri(path, params)
    "#{uri.host}#{uri.path}/#{Digest::MD5.hexdigest("#{method}:#{uri}:#{params.to_json}")}"
  end

  def make_request(uri, req, proxy = nil)
    if proxy
      http = Net::HTTP::Proxy(proxy.host, proxy.port, proxy.user, proxy.password).new(uri.host, uri.port)
    else
      http = Net::HTTP.new(uri.host, uri.port)
    end

    if uri.scheme == 'https'
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    http.request(req)
  end

  def request_uri(path, params = {})
    uri = "#{url}#{path}"
    uri += "?#{to_query_string(params)}" if params.present?

    URI(uri)
  end

  def to_query_string(params)
    params.to_a.map { |x| "#{x[0]}=#{x[1]}" }.join("&")
  end
end
