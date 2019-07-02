class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_writer :login
  after_initialize :set_default_role, :if => :new_record?
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  enum role: [:user, :admin]

  def set_default_role
    self.role ||= :user
  end

  def login
    self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      #change authenticate method in lower
      where(conditions.to_h).where(["lower(username)= :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
