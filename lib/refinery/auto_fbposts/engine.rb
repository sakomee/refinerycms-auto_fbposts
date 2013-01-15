module Refinery
  module AutoFbposts
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::AutoFbposts

      engine_name :refinery_auto_fbposts

      # initializer "register refinerycms_auto_fbposts plugin" do
      #   Refinery::Plugin.register do |plugin|
      #     plugin.name = "auto_fbposts"
      #     plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.auto_fbposts_admin_auto_fbposts_path }
      #     plugin.pathname = root
      #     plugin.activity = {
      #       :class_name => :'refinery/auto_fbposts/auto_fbpost'
      #     }

      #   end
      # end
      
      require 'refinerycms-settings'

      config.after_initialize do
        
        Refinery.register_extension(Refinery::AutoFbposts)
        Refinery::Setting.find_or_set(:host_name, 'www.example.com')
        Refinery::Setting.find_or_set(:auto_facebook_access_token, 'Your facebook token here')
        Refinery::Setting.find_or_set(:auto_facebook_page, '000000000000000')
        Refinery::Setting.find_or_set(:auto_facebook_message,
          'A new blog post "{title}" is published.')
      end

      require 'refinerycms-auto_fbposts'
      config.to_prepare do

        Refinery::Blog::Post.class_eval do
          attr_accessible :post_facebook, :facebook_posted        
          include ::RefineryExtension::AutoFbpost
          include ::RefineryExtension::Fbpost   
        
        end
      end
    end
  end
end
