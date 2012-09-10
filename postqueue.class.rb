class PostQueue
	@posts
	
	def initialize
		@posts = Array.new
	end
	
	def addPost(post)
		@posts.push(post)
	end
	
	def getPost
		@posts.shift
	end
	
	def empty
		@posts.length == 0
	end
end