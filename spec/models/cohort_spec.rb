require 'rails_helper'

RSpec.describe Cohort, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "Validations" do
    def validation_attributes(new_attributes)
      valid_attributes = {
        title: "valid title",
        details: "valid details"
      }
      valid_attributes.merge(new_attributes)
    end
  end
end
