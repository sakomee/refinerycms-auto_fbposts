require 'spec_helper'

module Refinery
  module AutoFbposts
    describe AutoFbpost do
      describe "validations" do
        subject do
          FactoryGirl.create(:auto_fbpost)
        end

        it { should be_valid }
        its(:errors) { should be_empty }
      end
    end
  end
end
