class User < ApplicationRecord
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :groups, foreign_key: :user_id, dependent: :destroy
  has_many :payments, foreign_key: :user_id, dependent: :destroy

  validates :email, presence: true
  validates :name, presence: true

  def admin?
    role == 'admin'
  end
end
