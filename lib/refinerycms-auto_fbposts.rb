require 'refinery/auto_fbposts'
require 'fb_graph'

class MyCustomException < StandardError ; end
module RefineryExtension
  module Fbpost
    def self.post_facebook_message(url, title)  
       begin 
        access_token = Refinery::Setting.get(:auto_fb_access_token)
        page_id = Refinery::Setting.get(:auto_fb_page)
        message = Refinery::Setting.get(:auto_fb_message)
        message = message.gsub('{title}', title)
        page = FbGraph::Page.new(page_id, access_token: access_token)   
         page.feed!(message: message, link: url)  
        rescue
          
        end     
    end

     #Extends the life of short life token and updates refinery setting value for token
    def self.extend_fb_token   
        old_access_token = Refinery::Setting.get(:auto_fb_access_token)
        app_id=Refinery::Setting.get(:auto_fb_app_id)
        application_secret=Refinery::Setting.get(:auto_fb_application_secret)
        fb_auth = FbGraph::Auth.new(app_id, application_secret)
        fb_auth.exchange_token!(old_access_token)
        new_extended_token=fb_auth.access_token 
        Refinery::Setting.set('auto_fb_access_token', "#{new_extended_token}")
        begin 
        rescue Exception => e
        end
    end  
  end 
    
  module AutoFbpost
    # Posts the blog in facebook
    def post_facebook!
      Refinery::Core::Engine.routes.default_url_options[:host] = Refinery::Setting.get(:auto_fb_host_name)
      url=Refinery::Core::Engine.routes.url_helpers.blog_post_url(self)
      title=self.title         
      RefineryExtension::Fbpost.post_facebook_message(url, title)
      self.facebook_posted = true
      self.post_facebook = false
      self.save    
      begin
      rescue => e
      end
    end    
  end
end


