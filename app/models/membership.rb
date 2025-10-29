class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  validates :role, presence: true, inclusion: { in: %w[owner admin member guest] }
  validates :user_id, uniqueness: { scope: :organization_id }
end
