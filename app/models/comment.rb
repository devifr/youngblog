class Comment < ActiveRecord::Base
  attr_accessible :article_id, :body, :user_id
end
