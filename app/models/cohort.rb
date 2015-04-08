class Cohort < ActiveRecord::Base
  validates :title, presence: true
  validates :details, presence: true
end
