namespace :refinery do

	namespace :auto_fbposts do

	    #call this task by running: rake refinery:auto_fbposts:extend_token
	    desc "Extend facebook token."
	    task :extend_token => :environment do
	    	puts "Auto_fbpost: Extending access token"
	    	RefineryExtension::Auto_Fbpost.extend_fb_token
	    end

	    desc "Post blogs to facebook which are marked as post_facebook"
	    task :post_to_facebook => :environment do
	    	Refinery::Blog::Post.live.where(post_facebook: true).each do |post|
	    		puts "Auto_fbpost: #{post.title}"
	    		post.post_facebook!	         
	    	end
	    end
	end
end