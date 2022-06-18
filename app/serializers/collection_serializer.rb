# CollectionSerializer.new(collection, Serializer)
class CollectionSerializer < BaseSerializer
  attr_reader :collection, :serializer_class

  def initialize(collection, serializer_class, options = {})
    @collection       = collection
    @serializer_class = serializer_class
    super(root: options[:root], oj_mode: options[:oj_mode], idx: options[:idx], options: options[:options], meta: options[:meta])
  end

  def to_json(_params = {})
    Oj.dump(to_a_with_root, mode: oj_mode)
  end

  def to_a
    collection.map do |item|
      rs = serializer_class.new(item, idx: idx, meta: meta, options: options).to_hash
      @idx = idx + 1
      rs
    end
  end

  def each(&block)
    collection.each_with_index do |item, idx|
      block.call(serializer_class.new(item, idx: idx, meta: meta, options: options))
    end
  end

  private

  def to_a_with_root
    if root.present?
      { root => to_a }.merge(meta)
    else
      to_a
    end
  end
end
