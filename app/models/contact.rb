class Contact < ActiveRecord::Base
  belongs_to :cohort
  belongs_to :user

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end
  
end
