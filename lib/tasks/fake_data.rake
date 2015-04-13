namespace :fake_data do

  desc "Database populator"
  task populate: :environment do
    50.times {User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.user_name + "@email.com", password_digest: BCrypt::Password.create("12345678"), password_confirmation: BCrypt::Password.create("12345678"))}

    6.times { |x| Cohort.create(title: "Cohort #{x + 1}", details: Faker::Hacker.say_something_smart)}

    User.all.each { |u| u.contacts.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.user_name + "@email.com", phone: Faker::PhoneNumber.phone_number, company: Faker::Company.name, website: Faker::Internet.url, other: Faker::Lorem.paragraph(8, true), user_id: u.id, cohort_id: ((Cohort.all.map).each { |x| x.id}).sample)}
  end

end
