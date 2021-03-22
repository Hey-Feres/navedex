# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

20.times do |i|
  if i == 0
    FactoryBot.create(:user, email: 'bruno@teste.com')
  else
    FactoryBot.create(:user)
  end
end

100.times do |i|
  FactoryBot.create(:naver)
end

20.times do |i|
  FactoryBot.create(:project)
end

Project.all.each do |project|
  rand(2..15).times do |i|
    project.navers << Naver.all.sample
  end
end