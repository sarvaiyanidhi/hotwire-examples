class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy
  
  validates :title, presence: true
  
  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
  scope :recent, -> { order(created_at: :desc) }
end
