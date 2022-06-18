#
class BaseSerializer
  attr_reader :root, :meta, :oj_mode, :idx, :options

  def initialize(root: nil, oj_mode: :compat, idx: 0, options: {}, meta: {})
    @root     = root
    @oj_mode  = oj_mode || :compat
    @idx      = idx || 0
    @meta     = meta || {}
    @options  = options || {}
  end

  def as_json(params = {})
    to_json(params)
  end

  def to_json(_params = {})
    raise 'Not Implement'
  end
end
