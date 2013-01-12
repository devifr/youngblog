class Article < ActiveRecord::Base
  attr_accessible :description, :title, :user_id
  has_many :comment
  belongs_to :user
#  paginates_per 10
end
