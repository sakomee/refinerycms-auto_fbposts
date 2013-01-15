module Refinery
  module AutoFbposts
    module Admin
      class AutoFbpostsController < ::Refinery::AdminController

        crudify :'refinery/auto_fbposts/auto_fbpost', :xhr_paging => true

      end
    end
  end
end
