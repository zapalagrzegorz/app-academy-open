# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  email            :string           not null
#  session_token    :string           not null
#  password_digest  :string           not null
#  activated        :boolean          default(FALSE), not null
#  boolean          :boolean          default(FALSE), not null
#  activation_token :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '123456' }
    activated { true }

    factory :user_foo do
      email { 'foo_bar@gmail.com' }
    end
  end
end
# factory :test_user do

# end
