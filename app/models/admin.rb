class Admin < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true

  class << self
    def authenticate(email, password)
      admin = Admin.find_by_email(email).try(:authenticate, password)
    end
  end
end
