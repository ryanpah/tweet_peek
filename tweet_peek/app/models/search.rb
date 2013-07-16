class Search < ActiveRecord::Base

  has_and_belongs_to_many :users

  attr_accessible :twitter_handle
  validates :twitter_handle, presence: true


end
