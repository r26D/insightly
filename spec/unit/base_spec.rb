require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Base do
  before(:each) do
  end

  context "url_base" do
    it "uses the base_insightly_class's" do
      base = Insightly::Base.new
      base_class = double()
      url = "some url"
      base_class.should_receive(:url_base).and_return(url)
      base.should_receive(:base_insightly_class).and_return(base_class)
      base.url_base.should eql(url)
    end
  end

  context "subclass" do
    before(:all) do
      class TestTask < Insightly::Task
      end
    end
    it "knows the base class's url" do
      TestTask.new.url_base.should eql(Insightly::Task.new.url_base)
    end

    it "knows the base class's remote_id_field" do
      TestTask.new.remote_id_field.should eql(Insightly::Task.new.remote_id_field)
    end
  end
end
