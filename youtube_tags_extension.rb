require 'youtube_g'

class YoutubeTagsExtension < Radiant::Extension
  version "1.0"
  description "Displaying YouTube videos in your pages"
  url "http://github.com/pelargir/youtube_tags"
  
  def activate
    Page.send :include, YoutubeTags
  end
end
