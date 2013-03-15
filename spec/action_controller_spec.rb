require 'spec_helper'

describe PrefixRoutesWithLocale::ActionController::BaseMethods do

  it "replaces default_url_options method with custom one" do
    ActionController::Base.new.default_url_options.should include(:locale)
  end

  it "sets default_url_options locale to I18n.locale" do
    ActionController::Base.new.default_url_options[:locale].should eq(I18n.locale)
  end

end