class Command < ApplicationRecord
  belongs_to :server

  validates :target, presence: true
  validates :length, presence: true
  validates :command, presence: true
  validates :status, presence: true
end
