# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :session_token, :password_digest, presence: true
  validates :username, :session_token, uniqueness: true
  before_validation :ensure_session_token!
  validates :password, length: {minimum: 6, allow_nil: true}

  has_many :subs,
    class_name: 'Sub',
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy

  has_many :posts,
    class_name: "Post",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy

  has_many :comments,
    class_name: 'Comment',
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!

    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user
      if user.is_password?(password)
        return user
      end
    end
    nil
  end

  private

  def ensure_session_token!
    self.session_token ||= SecureRandom::urlsafe_base64(16)
  end
end
