class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  has_many :created_tasks, class_name: "Task", foreign_key: "creator_id", dependent: :nullify
  has_many :assigned_tasks, class_name: "Task", foreign_key: "assigned_user_id", dependent: :nullify
end
