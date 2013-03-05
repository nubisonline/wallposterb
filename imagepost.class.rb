class ImagePost
	attr_accessor :token, :to, :url, :message
  
	def initialize(token, to, url, message)
		@token = token
		@to = to
		@url = url
		@message = message
	end
end
