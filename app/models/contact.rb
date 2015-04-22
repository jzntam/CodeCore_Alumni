class Contact < ActiveRecord::Base
  validates :user_id, uniqueness: true
  belongs_to :cohort
  belongs_to :user

  def first_name
    user.first_name if user
  end

  def last_name
    user.last_name if user
  end

  def email
    user.email if user
  end

  def full_name
    if user.first_name || user.last_name
      "#{user.first_name} #{user.last_name}"
    else
      user.email
    end
  end
  
end
