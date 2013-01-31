require 'refinery/auto_fbposts'
require 'fb_graph'

module RefineryExtension
  module Auto_Fbpost
    # Posts the blog in facebook
    def post_facebook!
      begin
        Refinery::Core::Engine.routes.default_url_options[:host] = Refinery::Setting.get(:auto_fb_host_name)
        url=Refinery::Core::Engine.routes.url_helpers.blog_post_url(self)
        title=self.title         
        RefineryExtension::Auto_Fbpost.post_facebook_message(url, title)
        self.facebook_posted = true
        self.post_facebook = false
        self.save 
      rescue
      end   
    end 

    def self.post_facebook_message(url, title)  
      access_token = Refinery::Setting.get(:auto_fb_access_token)
      page_id = FbGraph::User.me(access_token).fetch.identifier
      message = Refinery::Setting.get(:auto_fb_message)
      message = message.gsub('{title}', title)
      page = FbGraph::Page.new(page_id, access_token: access_token)       
      page.feed!(message: message, link: url)       
    end

    #Extends the life of short life token and updates refinery setting value for token
    def self.extend_fb_token   
     begin
      old_access_token = Refinery::Setting.get(:auto_fb_access_token)
      app_id=Refinery::Setting.get(:auto_fb_app_id)
      application_secret=Refinery::Setting.get(:auto_fb_application_secret)
      fb_auth = FbGraph::Auth.new(app_id, application_secret)
      fb_auth.exchange_token!(old_access_token)
      new_extended_token=fb_auth.access_token   
      Refinery::Setting.set('auto_fb_access_token', "#{new_extended_token}")
      rescue Exception=>e
        puts "#{e}: Plase debug the access token and verify the following questions"
        print <<-String
          Is the User logged in?
          Is your access token correct?
          Is the Facebook access token still valid?
          Did you put right application id and secret?
        String
      end
    end      
  end 

  module ValidateFbpost
    def validate_fbpost_requirements       
      alert_message=['Auto facebook post Error : <ul>']
      if (params["post"]["post_facebook"]=="1")
        access_token=Refinery::Setting.get(:auto_fb_access_token)  
        app_id=Refinery::Setting.get(:auto_fb_app_id)
        application_secret=Refinery::Setting.get(:auto_fb_application_secret)

        begin
          # Check if Session has expired--------------------
          #Validate access_token () ------------------------
          app = FbGraph::Application.new(app_id, :secret => application_secret)
          app_result = app.debug_token access_token  
          
          # Check permission for access_token---------------        
          if !(app_result.scopes.include?("share_item"))
            alert_message<<'<li>Facebook access token does not contain share permission.'
            flash[:alert] = alert_message.join("</li> </ul>").html_safe
          end 

          # Check Authentication---------------------------
          begin
            user_result=FbGraph::User.me(access_token).fetch   
          rescue Exception => e
            alert_message<< "<li> #{e}"
            flash[:alert] = alert_message.join("</li> </ul>").html_safe
          end 

        rescue Exception => e
          alert_message<<"<li> #{e}"
          flash[:alert] = alert_message.join("</li> </ul>").html_safe
        end
      end
    end
  end
end


