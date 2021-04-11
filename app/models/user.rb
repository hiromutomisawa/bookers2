class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image

  validates :name,uniqueness: true,presence: true, length: { in: 2..20 }
  validates :introduction, length: {maximum: 50}

  # フォロー機能関連
  # フォロー取得
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォロワー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしてる人
  has_many :following_user, through: :follower, source: :followed
  # 自分をフォローしてる人
  has_many :follower_user, through: :followed, source: :follower

  # フォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  # 外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  # フォローしていればtrue
  def following?(user)
    following_user.include?(user)
  end




end