FactoryBot.define do
  factory :user do
    name { 'ユーザーテスト' }
    email { 'test1@example.com' }
    password { 'password' }
  end
end