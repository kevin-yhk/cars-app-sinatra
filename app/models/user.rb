class User < ActiveRecord::Base
    has_many :cars
    has_secure_password

    validates :username, :email, uniqueness: true
    validates :username, :email, :password, presence: true
end 