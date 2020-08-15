class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, :first_name, :last_name, :password, presence: true
  validates :email, :phone, uniqueness: true
  validates :email, length: { maximum: 100 }
  # validates :phone, numericality: { only_integer: true }, length: { is: 13 }, on: :update
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validate :password_complexity
  


  def password_complexity
    if password.present? && !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$/)
      errors.add :password, 'must include at least a number, an uppercase and a lowercase letter'
    end
  end


end
