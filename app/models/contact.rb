class Contact < ActiveRecord::Base
  validates :user_id, uniqueness: true
  belongs_to :cohort
  belongs_to :user

  def first_name
    User.find(user_id).first_name if User.find(user_id)
  end

  def last_name
    User.find(user_id).last_name if User.find(user_id)
  end

  def email
    User.find(user_id).email if User.find(user_id)
  end

  def full_name
    if User.find(user_id).first_name || User.find(user_id).last_name
      "#{User.find(user_id).first_name} #{User.find(user_id).last_name}"
    end
  end
  
end
