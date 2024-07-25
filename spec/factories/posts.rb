FactoryBot.define do
  factory :post do
    content { 'Sample post content' }
    title { 'Sample title' }
    association :user
  end
end