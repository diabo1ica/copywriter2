module PostsHelper
  def extract_title(content)
    content = ActionController::Base.helpers.strip_tags(content)
    words = content.split
    first_three_words = words.take(5).join(' ')
    first_three_words[0, 30]
  end
end

