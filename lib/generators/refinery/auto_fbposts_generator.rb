module Refinery
  class AutoFbpostsGenerator < Rails::Generators::Base
    
    def rake_db
      rake("refinery_auto_fbposts:install:migrations")
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

        # Added by Refinery CMS Auto Fbposts extension
        Refinery::AutoFbposts::Engine.load_seed
        EOH
      end
    end
    
   source_root File.expand_path('../../../../', __FILE__)
    
    def Copy_files
      copy_file 'app/views/refinery/blog/admin/posts/_form.html.erb'  
      copy_file 'app/models/blog_post_observer.rb'    
    end

    def create_initializer_file
      puts "  Updating active_record.observers in application.rb"
      application "config.active_record.observers = :blog_post_observer"
    end
  end
end
