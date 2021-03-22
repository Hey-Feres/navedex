# frozen_string_literal: true

Faker::Config.locale = 'pt-BR'

FactoryBot.define do
  factory :project do
    name { Faker::App.name }
  end
end
