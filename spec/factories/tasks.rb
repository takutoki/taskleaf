FactoryBot.define do
  factory :task do
    name { 'テストを書く' }
    description { 'RSpec&Capybara&FacrtoyBotを準備する' }
    user
  end
end