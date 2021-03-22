# frozen_string_literal: true

Faker::Config.locale = 'pt-BR'

FactoryBot.define do
  factory :naver do
    name { Faker::Name.name }
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }
    admission_date { Faker::Date.between(from: 4.years.ago, to: 1.month.ago) }
    job_role { Faker::Job.position }
  end
end
