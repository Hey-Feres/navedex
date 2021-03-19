# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Faker::Config.locale = 'pt-BR'

user = User.create(email: 'teste@teste.com', password: '123456')

100.times do |i|
  Naver.create!(
    name: Faker::Name.name,
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
    admission_date: Faker::Date.between(from: 4.years.ago, to: 1.month.ago),
    job_role: Faker::Job.position
  )
end

20.times do |i|
  Project.create!(
    name: Faker::App.name
  )
end

Project.all.each do |project|
  rand(2..15).times do |i|
    project.navers << Naver.all.sample
  end
end