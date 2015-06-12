class List < ActiveRecord::Base
  has_many :bookmarks

  # has_many :invites
  # has_many :invited_users, through: :invites, source: :user

  belongs_to :user
end