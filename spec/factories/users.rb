# frozen_string_literal: true

Faker::Config.locale = 'pt-BR'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '123456' }
  end
end
