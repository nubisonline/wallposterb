#!/usr/bin/env ruby
require 'socket'
require 'cgi'
require 'logger'
require 'rubygems'
require 'json'
require 'curb-fu'

load 'post.class.rb'
load 'postqueue.class.rb'
load 'poster.rb'

logger = Logger.new(STDOUT)
postqueue = PostQueue.new

tPoster = Thread.new{ start_posting(logger, postqueue) }

webserver = TCPServer.new('0.0.0.0', 4321)
logger.info("Webserver started");
while (session = webserver.accept)
	logger.info("Got request")
	contentlength = 0
	while (buff = session.gets)
		if(buff == "\n" || buff == "\r\n")
			break
		else
			if(buff[0,14] == "Content-Length")
				contentlength = buff[16..-1].to_i
			end
		end
	end
	content = session.read(contentlength)
	session.print "HTTP/1.1 200/OK\nContent-type:text/html\n\n"
	begin
		#Parse payload
		payload = CGI::unescape(content)
		posts = JSON.parse(payload)
		
		posts.each do |postraw|
			post = Post.new(postraw["token"], postraw["to"], postraw["message"])
			
			post.link = postraw["link"] if postraw.has_key?("link")
			post.picture = postraw["picture"] if postraw.has_key?("picture")
			post.name = postraw["name"] if postraw.has_key?("name")
			post.caption = postraw["caption"] if postraw.has_key?("caption")
			post.description = postraw["description"] if postraw.has_key?("description")
			post.actions = postraw["actions"] if postraw.has_key?("actions")
			post.place = postraw["place"] if postraw.has_key?("place")
			post.tags = postraw["tags"] if postraw.has_key?("tags")
			post.privacy = postraw["privacy"] if postraw.has_key?("privacy")
			post.object_attachment = postraw["object_attachment"] if postraw.has_key?("object_attachment")
			
			postqueue.addPost(post)
		end
		
	end
	session.close
	
	logger.info("Request handled, starting poster")	

	tPoster.wakeup
end
