class User < ApplicationRecord
  attr_accessor :remember_token
  before_save {self.email = email.downcase}
  validates :name,presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,presence: true, length: {maximum: 255},
             format: {with: VALID_EMAIL_REGEX},
             uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
  
  # $B%/%i%9%a%=%C%I(B
  class << self
    # $BEO$5$l$?J8;zNs$N%O%C%7%eCM$rJV$9(B
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                              BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # $B%i%s%@%`$J%H!<%/%s$rJV$9(B
    def User.new_token
      SecureRandom.urlsafe_base64
    end
  end

  # $B1JB3%;%C%7%g%s$N$?$a$K%f!<%6!<$r%G!<%?%Y!<%9$K5-21$9$k(B
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # $BEO$5$l$?%H!<%/%s$,%@%$%8%'%9%H$H0lCW$7$?$i(Btrue$B$rJV$9(B
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # $B%f!<%6!<$N%m%0%$%s>pJs$rGK4~$9$k(B
  def forget
    update_attribute(:remember_digest, nil)
  end
end

