class Post < ActiveRecord::Base
  validates :author, :title, presence: true

  belongs_to :author, class_name: 'User'
  has_many :post_subs, dependent: :destroy
  has_many :subs, through: :post_subs
end
