class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, length: { minimum: 6},  confirmation: true, on: :create

  has_many :contacts, dependent: :nullify

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.first_name = (auth["info"]["user"]).capitalize
      user.last_name = "@codecore"
      user.email = "#{auth["info"]["user"]}@email.com"
      user.password = "12345678"
    end
  end

end
