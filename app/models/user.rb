class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # ↓フォロー関係記述
  # 自分が、フォローしているユーザー関連
  # 自分がフォローされているユーザー関連
  has_many :active_relationships, class_name: "Relationship", foreign_key: "following_id"
  has_many :followings, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id"
  has_many :followeds, through: :passive_relationships, source: :following
  
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
  
  # このメソッドでは、passiveなので、フォローされている方が、foreign_idになる。＝＞フォローしてくれてる人かどうかをチェック！
  
  def self.search_for(value,method)
    case method
      when 'perfect'
        User.where(name: value)
      when 'forward'
        User.where('name LIKE ?', value + '%' )
      when 'backward'
        User.where('name LIKE ?', '%' + value )
      when 'partial'
        User.where('name LIKE ?', '%' + value + '%')
    end
  end
  
  
  attachment :profile_image

  validates :name, uniqueness: true,
                   length: { minimum: 2, maximum: 20 }

  validates :introduction, length: { maximum: 50 }
end
