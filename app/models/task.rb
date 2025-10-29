class Task < ApplicationRecord
  belongs_to :project
  belongs_to :creator, class_name: "User"
  belongs_to :assigned_user, class_name: "User", optional: true

  validates :title, presence: true
  validates :status, inclusion: { in: %w[pending in_progress completed] }
end
