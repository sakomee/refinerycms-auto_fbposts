class BlogPostObserver < ActiveRecord::Observer
	observe Refinery::Blog::Post
	def after_save(blog_post)
		if (blog_post.post_facebook && blog_post.live?)  
			blog_post.post_facebook!
		end
	end
end
