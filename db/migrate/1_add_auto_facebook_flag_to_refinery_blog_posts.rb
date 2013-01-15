class AddAutoFacebookFlagToRefineryBlogPosts < ActiveRecord::Migration

  def self.up
    add_column :refinery_blog_posts, :post_facebook, :boolean, default: false
    add_column :refinery_blog_posts, :facebook_posted, :boolean, default: false
  end

  def self.down
    remove_column :refinery_blog_posts, :post_facebook
    remove_column :refinery_blog_posts, :facebook_posted
  end

end
