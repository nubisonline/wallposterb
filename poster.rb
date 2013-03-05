def start_posting(logger, queue)
	logger.info("Starting posting thread")
	while 1
		if queue.empty
			logger.info("Everything handled, stopping posting thread")
			Thread.stop
		end
		
		post = queue.getPost

		postdata = { :access_token => post.token, :message => post.message };

		logger.info(post.class)

		begin
		if(post.class.to_s == "Post")
			postdata.merge!( :link => post.link ) unless post.link.nil?
			postdata.merge!( :picture => post.picture ) unless post.picture.nil?
			postdata.merge!( :name => post.name ) unless post.name.nil?
			postdata.merge!( :caption => post.caption ) unless post.caption.nil?
			postdata.merge!( :description => post.description ) unless post.description.nil?
			postdata.merge!( :actions => post.actions ) unless post.actions.nil?
			postdata.merge!( :place => post.place ) unless post.place.nil?
			postdata.merge!( :tags => post.tags ) unless post.tags.nil?
			postdata.merge!( :privacy => post.privacy ) unless post.privacy.nil?
			postdata.merge!( :object_attachment => post.object_attachment ) unless post.object_attachment.nil?

			response = CurbFu.post("https://graph.facebook.com/" + post.to + "/feed", postdata)

			puts response.inspect
		elsif(post.class.to_s == "ImagePost")
			postdata.merge!( :url => URI::encode(post.url) )

			response = CurbFu.post("https://graph.facebook.com/" + post.to + "/photos", postdata)

			puts URI::encode(post.url)
			puts response.inspect
		else
			raise "Unkown post type in queue"
		end
		
		rescue Exception => e
			logger.info(e.inspect)
		end
	end
end
