class Post
	attr_accessor :token, :to, :message, :link, :picture, :name, :caption, :description, :actions, :place, :tags, :privacy, :object_attachment
  
	def initialize(token, to, message)
		@token = token
		@to = to
		@message = message
	end
end
