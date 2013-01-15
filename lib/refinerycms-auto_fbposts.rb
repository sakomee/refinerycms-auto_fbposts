require 'refinerycms-core'
require 'refinery/auto_fbposts'
require 'fb_graph'

module RefineryExtension
  module Fbpost
    def self.post_facebook_message(url, title)


      access_token = Refinery::Setting.get(:auto_facebook_access_token)
      page_id = Refinery::Setting.get(:auto_facebook_page)
      message = Refinery::Setting.get(:auto_facebook_message)
      message = message.gsub('{title}', title)
      page = FbGraph::Page.new(page_id, access_token: access_token)
     
      page.feed!(message: message, link: url)
    end
  end

  module AutoFbpost
    def facebook_needed?
      live? && post_facebook && !facebook_posted
    end

    def post_facebook!
      begin
        Refinery::Core::Engine.routes.default_url_options[:host] = Refinery::Setting.get(:host_name)
        url=Refinery::Core::Engine.routes.url_helpers.blog_post_url(self)
        title=self.title         
        RefineryExtension::Fbpost.post_facebook_message(url, title)
        self.facebook_posted = true
        self.post_facebook = false
        self.save    
      rescue => e

      end
    end
  end
end