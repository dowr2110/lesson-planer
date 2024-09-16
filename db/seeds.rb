# frozen_string_literal: true

require 'faker'

categories = [
  { name: 'Mathematics' },
  { name: 'Physics' },
  { name: 'Computer Science' },
  { name: 'Biology' },
  { name: 'Chemistry' }
]

categories.each do |category_data|
  category = Category.create!(category_data)

  disciplines = case category.name
                when 'Mathematics'
                  %w[Algebra Geometry Calculus]
                when 'Physics'
                  ['Mechanics', 'Thermodynamics', 'Quantum Physics']
                when 'Computer Science'
                  ['Data Structures', 'Algorithms', 'Databases']
                when 'Biology'
                  %w[Genetics Ecology Microbiology]
                when 'Chemistry'
                  ['Organic Chemistry', 'Inorganic Chemistry', 'Physical Chemistry']
                end

  disciplines.each do |discipline_name|
    Discipline.create!(name: discipline_name, category: category)
  end
end

puts 'Categories and Disciplines have been seeded!'

50.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 8),
    role: 'teacher'
  )

  teacher_profile = user.create_teacher_profile!(
    experience: Faker::Lorem.paragraph(sentence_count: 3),
    specialization: Faker::Job.field,
    status: 'verified'
  )

  teacher_profile.disciplines << Discipline.all.sample(2)
end

puts '50 Teachers have been seeded!'
