module ApplicationHelper
  def greeting
    case Time.now.hour
    when 4..11 then 'Good morning'
    when 12..17 then 'Good afternoon'
    when 18..23 then 'Good evening'
    else
      'Good night'
    end
  end
end
