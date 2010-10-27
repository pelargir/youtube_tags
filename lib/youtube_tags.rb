module YoutubeTags
  include Radiant::Taggable
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::DateHelper
  
  desc "Creates an context for YouTube" 
  tag "youtube" do |tag|
    raise StandardError::new('the youtube tag needs a username in the user attribute') if tag.attr['user'].blank?
    tag.locals.user = tag.attr['user']
    tag.expand
  end
  
  desc "Creates the loop for the videos - takes optional count"
  tag "youtube:videos" do |tag|
    count = (tag.attr['count'] || 10).to_i
    raise StandardError::new('the count attribute should be a positive integer') unless count > 0
    
    client = YouTubeG::Client.new
    client.videos_by(:user => tag.locals.user, :per_page => count).videos.map do |video|
      tag.locals.video = video
      tag.expand
    end
  end
  
  desc "Creates the context for each individual video"
  tag "youtube:videos:video" do |tag|
    tag.expand
  end
  
  desc "Returns the video's title"
  tag "youtube:videos:video:title" do |tag|
    video = tag.locals.video
    video.title
  end
  
  desc "Returns the video's view count"
  tag "youtube:videos:video:view_count" do |tag|
    video = tag.locals.video
    pluralize video.view_count, "view"
  end
  
  desc "Returns a description of how long ago the video was published"
  tag "youtube:videos:video:published" do |tag|
    video = tag.locals.video
    "#{time_ago_in_words video.published_at} ago"
  end
  
  desc "Returns the video's URL"
  tag "youtube:videos:video:url" do |tag|
    video = tag.locals.video
    video.player_url
  end
  
  desc "Returns the video's thumbnail URL"
  tag "youtube:videos:video:thumbnail" do |tag|
    video = tag.locals.video
    video.thumbnails.first.url
  end
end
