class Employee < ApplicationRecord
  has_secure_password
  belongs_to :team, optional: true
  validates :name, presence: true
  validates :mobile, presence: true, length: { is: 10 }, format: { with: /\A[1-9]\d*\z/ } , uniqueness: true
  validates :address, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } , uniqueness: true
  validates :role, presence: true
  validates_length_of :password, minimum: 6, maximum: 20, if: :password_required?

  before_validation :set_default_password, on: :create

  private
  def set_default_password
    self.password = "password123" if password.blank?
  end

  def password_required?
    new_record? || password.present?
  end
end
