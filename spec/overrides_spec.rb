require File.dirname(__FILE__) + '/spec_helper'
require 'ostruct'

module OverridesSpecs
  class Post
    extend Machinist::Machinable
    attr_accessor :title, :body, :comments
  end

  class Subpost < Post
  end
end

describe Machinist::Blueprint do
  before(:each) do
    OverridesSpecs::Post.clear_blueprints!

    OverridesSpecs::Post.blueprint do
      title { "First Post" }
      overrides do
        title_and_body { |tb| object.title, object.body = tb.split(' - ') }
        body_and_title { |tb| object.body, object.title = tb.split(' | ') }
      end
    end
  end

  it "supports overriding attributes that are not defined in the object" do
    post = OverridesSpecs::Post.make :title_and_body => "Title - Body"
    post.title.should == "Title"    
    post.body.should == "Body"    

    post = OverridesSpecs::Post.make :body_and_title => "Body | Title"
    post.title.should == "Title"    
    post.body.should == "Body"    
  end

  it "works with inheritance" do
    OverridesSpecs::Subpost.blueprint do
    end

    post = OverridesSpecs::Subpost.make :title_and_body => "Title - Body"
    post.title.should == "Title"    
    post.body.should == "Body"    
  end
end