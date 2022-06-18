# PagingSerializer.new(collection).to_hash
class PagingSerializer < ResourceSerializer
  attributes  :prev_page,
              :next_page,
              :current_page,
              :total_count,
              :total_pages,
              :per_page

  def prev_page
    object.prev_page.to_i
  end

  def next_page
    object.next_page.to_i
  end

  def current_page
    object.current_page.to_i
  end

  def total_count
    object.total_count.to_i
  end

  def total_pages
    object.total_pages.to_i
  end

  def per_page
    object.limit_value.to_i
  end
end
