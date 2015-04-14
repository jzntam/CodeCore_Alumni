require 'rails_helper'

RSpec.describe User, type: :model do
  def validation_attributes(new_atributes = {})
    valid_atributes = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: Faker::Internet.password
    }
    valid_atributes.merge(new_atributes)
  end 

  it "reqiures a first name" do
    user = User.new(validation_attributes({first_name: nil}))
    expect(user).to be_invalid
  end

  it "requires a last name" do
    user = User.new(validation_attributes({last_name: nil}))
    expect(user).to be_invalid
  end

  it "requires an email" do
    user = User.new(validation_attributes({email: nil}))
    expect(user).to be_invalid
  end

  it "requires a unique email" do
    first_user = User.create(validation_attributes({email: "some@email.com"}))
    user = User.new(validation_attributes({email: "some@email.com"}))
    expect(user).to be_invalid
  end

  it "requires a password" do
    user = User.new(validation_attributes({password: nil}))
    expect(user).to be_invalid
  end

  it "generates a password_digest" do
    user = User.new(validation_attributes)
    expect(user.password_digest).to be
  end

end
