module ArticlesHelper

	def pemilik?(art)
	  user_signed_in? && art.user_id == current_user.id
	end
end
