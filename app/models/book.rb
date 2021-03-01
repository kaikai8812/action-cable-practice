class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body,  length: { maximum: 200 }, presence: true
  
  
  def favorited_by?(user)  #userは、ページではcurrent_user
    favorites.where(user_id: user.id).exists?
  end
  #trueだったら、いいねしている＝current_userが、favoriteモデルに存在する
  
    def self.search_for(value,method)
      case method
        when 'perfect'
          Book.where(name: value)
        when 'forward'
          Book.where('title LIKE ?', value + '%' )
        when 'backward'
          Book.where('title LIKE ?', '%' + value )
        when 'partial'
          Book.where('title LIKE ?', '%' + value + '%')
      end
    end
    
end
