require 'rails_helper'

RSpec.describe Cohort, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "Validations" do
    def validation_attributes(new_attributes ={})
      valid_attributes = {
        title: "valid title",
        details: "valid details"
      }
      valid_attributes.merge(new_attributes)
    end

    it "requires a title" do
      cohort = Cohort.new (validation_attributes({title: nil}))
      expect(cohort).to be_invalid
    end

    it "requires details" do
      cohort = Cohort.new (validation_attributes({details: nil}))
      expect(cohort).to be_invalid
    end

    it "requires titles to be unique" do
      cohort = Cohort.create(validation_attributes)
      cohort_1 = Cohort.new(validation_attributes)
      expect(cohort_1).to be_invalid
    end

  end
end
