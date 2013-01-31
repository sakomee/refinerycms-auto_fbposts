module Refinery
  module AutoFbposts
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::AutoFbposts

      engine_name :refinery_auto_fbposts

      require 'refinerycms-settings'

      config.after_initialize do
        Refinery.register_extension(Refinery::AutoFbposts)

        Refinery::Setting.find_or_set(:auto_fb_app_id, '')        
        Refinery::Setting.find_or_set(:auto_fb_application_secret, '')
        Refinery::Setting.find_or_set(:auto_fb_host_name, 'www.example.com')
        Refinery::Setting.find_or_set(:auto_fb_access_token, 'Your facebook token here')
        Refinery::Setting.find_or_set(:auto_fb_message,
          'A new blog post "{title}" is published.')       
      end

      require 'refinerycms-auto_fbposts'
      config.to_prepare do
        Refinery::Blog::Post.class_eval do
          attr_accessible :post_facebook, :facebook_posted        
          include ::RefineryExtension::Auto_Fbpost
        end

        Refinery::Blog::Admin::PostsController.class_eval do  
          before_filter :validate_fbpost_requirements, :only => [:create, :update ]
          include ::RefineryExtension::ValidateFbpost
        end
      end
    end
  end
end

