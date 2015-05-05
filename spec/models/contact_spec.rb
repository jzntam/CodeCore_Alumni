require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:user) { create(:user) }
  let(:cohort) { create(:cohort) }

  def valid_attributes(new_attributes = {})
    attributes = {phone: "555-555-5555"}
    attributes.merge(new_attributes)
  end

  describe "Validations" do
    it "requires the user to only have one contact" do
      user.contacts.create(valid_attributes)
      contact = Contact.new(valid_attributes(user_id: user.id))
      expect(contact).to be_invalid
    end
  end

  describe "Associations", type: :model do
    it "requires contact to belong to User" do
      contact = Contact.new(valid_attributes(user_id: user.id, cohort_id: cohort.id))
      expect(contact).to belong_to :user 
    end
    it "requires contact to belong to Cohort" do
      contact = Contact.new(valid_attributes(user_id: user.id, cohort_id: cohort.id))
      expect(contact).to belong_to :cohort 
    end
  end

  describe ".first_name" do
    it "returns the User's first name for the contact" do
      contact = user.contacts.create(valid_attributes)
      expect(contact.first_name).to eq(user.first_name)
    end
  end

  describe ".last_name" do
    it "returns the User's last name for the contact" do
      contact = user.contacts.create(valid_attributes)
      expect(contact.last_name).to eq(user.last_name)
    end
  end

  describe ".email" do
    it "returns the User's email for the contact" do
      contact = user.contacts.create(valid_attributes)
      expect(contact.email).to eq(user.email)
    end
  end

  describe ".full_name" do
    it "returns the concatenated first name and last name if both are given" do
      contact = user.contacts.create(valid_attributes)
      expect(contact.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
    # Test not necessary because of the validations in the user model.
    # it "returns the email if first and last name are blank" do
    #   # let(:user_2) { create(:user) }
    #   user_2 = User.create(first_name: nil, last_name: nil, email: "hello@world.com", password: "12345678")
    #   contact = user_2.contacts.create(valid_attributes)
    #   expect(contact.full_name).to eq("#{user_2.email}")
    # end
  end

end
