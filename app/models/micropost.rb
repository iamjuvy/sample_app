class Micropost < ActiveRecord::Base
  attr_accessible :content, :subject
  belongs_to :user

  validates :content, length: { maximum: 250 }
  validates :subject, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  default_scope order: 'microposts.created_at DESC'
end
