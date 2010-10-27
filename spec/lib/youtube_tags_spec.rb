require File.dirname(__FILE__) + '/../spec_helper'

describe "YoutubeTags" do
  dataset :pages
  
  describe "<r:youtube>" do
    it "should require a YouTube username in the user attribute" do
      tag = %{<r:youtube />}
      
      pages(:home).should render(tag).with_error("the youtube tag needs a username in the user attribute")
    end
    
    it "should give no output" do
      tag = %{<r:youtube user="pelargir" />}
      expected = ""
      
      pages(:home).should render(tag).as(expected)      
    end
    
    it "should pass the username down to the videos directive" do
      tag = %{<r:youtube user="pelargir"><r:videos>.</r:videos></r:youtube>}
      
      client = YouTubeG::Client.new
      YouTubeG::Client.expects(:new).returns(client)
      client.expects(:videos_by).returns stub(:videos => [])
      
      pages(:home).should render(tag).matching(//)
    end
  end
  
  # describe "<r:youtube:videos>" do
  #   it "should give no output" do
  #     tag = %{<r:youtube user="pelargir"><r:videos></r:videos></r:youtube>}
  #     expected = ""
  # 
  #     youtube_search_obj = YouTubeG::Client.new
  #     YouTubeG::Client.expects(:new).returns(youtube_search_obj)
  #     youtube_search_obj.expects(:from).with("pelargir").returns(youtube_search_obj)
  #     youtube_search_obj.expects(:per_page).with(10).returns(%w{a b c d e f g h i j})
  # 
  #     pages(:home).should render(tag).as(expected)
  #   end
  #   
  #   it "should give the last 10 videos by default" do
  #     tag = %{<r:youtube user="pelargir"><r:videos><r:video>.</r:video></r:videos></r:youtube>}
  #     expected = "." * 10
  # 
  #     youtube_search_obj = YouTubeG::Client.new
  #     YouTubeG::Client.expects(:new).returns(youtube_search_obj)
  #     youtube_search_obj.expects(:from).with("pelargir").returns(youtube_search_obj)
  #     youtube_search_obj.expects(:per_page).with(10).returns(%w{a b c d e f g h i j})
  # 
  #     pages(:home).should render(tag).as(expected)
  #   end
  # 
  #   it "should honour the count attribute" do
  #     tag = %{<r:youtube user="pelargir"><r:videos count="5"><r:video>.</r:video></r:videos></r:youtube>}
  #     expected = "." * 5
  # 
  #     youtube_search_obj = YouTubeG::Client.new
  #     YouTubeG::Client.expects(:new).returns(youtube_search_obj)
  #     youtube_search_obj.expects(:from).with("pelargir").returns(youtube_search_obj)
  #     youtube_search_obj.expects(:per_page).with(5).returns(%w{a b c d e})      
  # 
  #     pages(:home).should render(tag).as(expected)
  #   end
  # 
  #   it "should throw an error when the count attribute is not numeric" do
  #     tag = %{<r:youtube user="pelargir"><r:videos count="foo" /></r:youtube>}
  # 
  #     pages(:home).should render(tag).with_error("the count attribute should be a positive integer")
  #   end
  # 
  #   it "should throw an error when the count attribute is a negative" do
  #     tag = %{<r:youtube user="pelargir"><r:videos count="-10" /></r:youtube>}
  # 
  #     pages(:home).should render(tag).with_error("the count attribute should be a positive integer")
  #   end
  # end
  #   
  # describe "<r:youtube:videos:video>" do
  #   it "should give no output" do
  #     tag = %{<r:youtube user="pelargir"><r:videos><r:video></r:video></r:videos></r:youtube>}
  #     expected = ""
  # 
  #     youtube_search_obj = YouTubeG::Client.new
  #     YouTubeG::Client.expects(:new).returns(youtube_search_obj)
  #     youtube_search_obj.expects(:from).with("pelargir").returns(youtube_search_obj)
  #     youtube_search_obj.expects(:per_page).with(10).returns(%w{a b c d e f g h i j})      
  # 
  #     pages(:home).should render(tag).as(expected)
  #     
  #   end
  # end  
  #   
  # describe "<r:youtube:videos:video:text>" do
  #   it "should give the text of the video" do
  #     tag = %{<r:youtube user="pelargir"><r:videos count="1"><r:video:text /></r:videos></r:youtube>}
  #     expected = "text 1"
  # 
  #     videos = [
  #       {"text"=>"text 1",  "created_at"=>"Mon, 23 Feb 2009 12:34:56 +0000", "to_user_id"=>nil, "from_user"=>"pelargir", "id"=>1240985884, "from_user_id"=>1621731, "iso_language_code"=>"nl", "source"=>"&lt;a href=&quot;http://youtube.com/&quot;&gt;web&lt;/a&gt;", "profile_image_url"=>"http://s3.amazonaws.com/youtube_production/profile_images/60061505/logo-vierkant_normal.png"},
  #       ]
  # 
  #     youtube_search_obj = YouTubeG::Client.new
  #     YouTubeG::Client.expects(:new).returns(youtube_search_obj)
  #     youtube_search_obj.expects(:from).with("pelargir").returns(youtube_search_obj)
  #     youtube_search_obj.expects(:per_page).with(1).returns(videos)      
  # 
  #     pages(:home).should render(tag).as(expected)
  #   end
  # end  
  # 
  # describe "<r:youtube:videos:video:url>" do
  #   it "should give the url to the video" do
  #     tag = %{<r:youtube user="pelargir"><r:videos count="1"><r:video:url /></r:videos></r:youtube>}
  #     expected = "http://www.youtube.com/pelargir/statuses/1240985884"
  # 
  #     videos = [
  #       {"text"=>"text 1",  "created_at"=>"Mon, 23 Feb 2009 12:34:56 +0000", "to_user_id"=>nil, "from_user"=>"pelargir", "id"=>1240985884, "from_user_id"=>1621731, "iso_language_code"=>"nl", "source"=>"&lt;a href=&quot;http://youtube.com/&quot;&gt;web&lt;/a&gt;", "profile_image_url"=>"http://s3.amazonaws.com/youtube_production/profile_images/60061505/logo-vierkant_normal.png"},
  #       ]
  # 
  #     youtube_search_obj = YouTubeG::Client.new
  #     YouTubeG::Client.expects(:new).returns(youtube_search_obj)
  #     youtube_search_obj.expects(:from).with("pelargir").returns(youtube_search_obj)
  #     youtube_search_obj.expects(:per_page).with(1).returns(videos)      
  # 
  #     pages(:home).should render(tag).as(expected)
  #   end
  # end  
end
