class Post < ApplicationRecord
  has_rich_text :content
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
end
