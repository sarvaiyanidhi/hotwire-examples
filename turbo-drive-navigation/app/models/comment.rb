class Comment < ApplicationRecord
  belongs_to :task
  
  validates :content, presence: true
  validates :author, presence: true
  
  scope :recent, -> { order(created_at: :desc) }
end
