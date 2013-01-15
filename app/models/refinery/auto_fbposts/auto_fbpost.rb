module Refinery
  module AutoFbposts
    class AutoFbpost < Refinery::Core::BaseModel
      self.table_name = 'refinery_auto_fbposts'

      attr_accessible :post_facebook, :position
      # def title was created automatically because you didn't specify a string field
      # when you ran the refinery:engine generator. <3 <3 Refinery CMS.
      def title
        "Override def title in vendor/extensions/auto_fbposts/app/models/refinery/auto_fbposts/auto_fbpost.rb"
      end
    end
  end
end
