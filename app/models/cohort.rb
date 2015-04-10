class Cohort < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :details, presence: true
  default_scope {order(:title => 'asc')}

  has_many :contacts, dependent: :nullify
end
