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
      overrides do |attrs|
        attrs[:body] = attrs.delete(:msg)
        attrs[:title] = object.class.name
      end
    end
  end

  it "should allow to override attributes hash directly" do
    post = OverridesSpecs::Post.make :msg => 'Msg'
    post.body.should == 'Msg'
  end

  it "works with inheritance" do
    OverridesSpecs::Subpost.blueprint do
    end

    post = OverridesSpecs::Subpost.make :msg => 'Msg'
    post.body.should == 'Msg'
  end

  it "should have access to object" do
    post = OverridesSpecs::Post.make
    post.title.should == 'OverridesSpecs::Post'
  end
end