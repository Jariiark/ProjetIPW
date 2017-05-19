class Feed < ApplicationRecord
 belongs_to :user
 validates :url, :presence => true
  validates :user_id, :presence => true
 default_scope { order('feeds.created_at DESC') }
 end
