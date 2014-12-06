class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :todos, dependent: :destroy

  validates :auth_token, uniqueness: true

  before_create :generate_authentication_token!

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
      #alternatively use: self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: auth_token)
  end

end
