require 'spec_helper'

describe BootstrapHelper::Helper do
  describe "yield_or_default" do
    it "should return yield_name" do
      yield_or_default(:xxx).should == :xxx
    end

    it "should return default message" do
      yield_or_default(nil).should == ""
    end
  end

  describe "render_page_title" do
    it "should return 'SITENAME' when @page_title and SITE_NAME not given" do
      render_page_title.should == "<title>SITE_NAME</title>"
    end

    it "should return 'SITENAME' when @page_title not given" do
      SITE_NAME = "Foo"
      render_page_title.should == "<title>Foo</title>"
    end

    it "should return @page_title when @page_title is given" do
      @page_title = "Bar"
      render_page_title.should == "<title>Foo | Bar</title>"
    end
  end

  describe "render_body_tag" do

    before do 
      stub!(:controller_name).and_return('pages')
      stub!(:action_name).and_return('welcome')
    end

    it "render_body_tag with controller_name and action_name" do

      render_body_tag.should == raw(%Q|<!--[if lt IE 7 ]>
<body class="pages-controller welcome-action ie6"><![endif]-->
<!--[if gte IE 7 ]>
<body class="pages-controller welcome-action ie"><![endif]-->
<!--[if !IE]>-->
<body class="pages-controller welcome-action">
<!--<![endif]-->|)
    end
    
    it "render_body_tag with controller_name and action_name" do

      @body_id = "foo"
      render_body_tag.should == raw(%Q|<!--[if lt IE 7 ]>
<body class="pages-controller welcome-action ie6"><![endif]-->
<!--[if gte IE 7 ]>
<body class="pages-controller welcome-action ie"><![endif]-->
<!--[if !IE]>-->
<body id="foo-page" class="pages-controller welcome-action">
<!--<![endif]-->|)
    end
  end

  describe "notice_message" do

    it "should return flash message" do
      stub!(:flash).and_return({:warning => "Update Success!"})
      notice_message.should == "<div class=\"alert fade in alert-warning\"><a href=\"#\" class=\"close\" data-dismiss=\"alert\">x</a>Update Success!</div>"
    end

    it "should return alert-success message when use notice message" do
      stub!(:flash).and_return({:notice => "Update Success!"})
      notice_message.should == "<div class=\"alert fade in alert-success\"><a href=\"#\" class=\"close\" data-dismiss=\"alert\">x</a>Update Success!</div>"
    end

  end

  describe "render_list" do
    before do
      self.stub!("current_page?").and_return(true)

      def render_some_list(options={})
          list = render_list options do |li|
          li << link_to("Link 1", "#")
          li << link_to("Link 2", "#")
          li << link_to("Link 3", "#")
        end
      end

    end

    it "should return ul & li" do
      list = render_render_some_list
      list.should == "<ul><li class=\"first active\"><a href=\"#\">Link 1</a></li><li class=\"active\"><a href=\"#\">Link 2</a></li><li class=\"last active\"><a href=\"#\">Link 3</a></li></ul>"
    end

    it "should return ul with class_name" do
      options = { :class => "foo" }
      list = render_render_some_list(options)
      list.should == "<ul class=\"foo\"><li class=\"first active\"><a href=\"#\">Link 1</a></li><li class=\"active\"><a href=\"#\">Link 2</a></li><li class=\"last active\"><a href=\"#\">Link 3</a></li></ul>"
    end

    it "should return ul with id_name" do
      options = { :id => "bar" }
      list = render_render_some_list(options)
      list.should == "<ul id=\"bar\"><li class=\"first active\"><a href=\"#\">Link 1</a></li><li class=\"active\"><a href=\"#\">Link 2</a></li><li class=\"last active\"><a href=\"#\">Link 3</a></li></ul>"
    end
  end
end