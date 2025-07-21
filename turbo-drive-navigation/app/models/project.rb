class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :comments, through: :tasks, dependent: :destroy

  validates :title, presence: true
  validates :status, inclusion: { in: %w[planning active completed archived] }
  validates :priority, inclusion: { in: 1..5 }
  
  scope :active, -> { where(status: ['planning', 'active']) }
  scope :by_priority, -> { order(:priority) }
end
