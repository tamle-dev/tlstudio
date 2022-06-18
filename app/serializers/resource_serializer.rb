#
class ResourceSerializer < BaseSerializer
  class_attribute :_attrs

  attr_reader :object

  def self.attributes(*attrs)
    if self._attrs.is_a? Array
      self._attrs += attrs
    else
      self._attrs = attrs
    end
  end

  def initialize(object, **options)
    @object = object
    super(root: options[:root], oj_mode: options[:oj_mode], idx: options[:idx], options: options[:options], meta: options[:meta])
  end

  def to_json(_params = {})
    result = to_hash_with_root.merge(meta)
    Oj.dump(result, mode: oj_mode)
  end

  def to_hash
    self.class._attrs.inject({}) do |result, at|
      result[at] = respond_to?(at) ? send(at) : object.send(at)
      result
    end
  end

  private

  def to_hash_with_root
    if root.present?
      { root => to_hash }
    else
      to_hash
    end
  end
end
