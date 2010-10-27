namespace :radiant do
  namespace :extensions do
    namespace :youtube_tags do
      
      desc "Runs the migration of the youtube_tags extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          YoutubeTagsExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          YoutubeTagsExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the youtube_tags to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from YoutubeTagsExtension"
        Dir[YoutubeTagsExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(YoutubeTagsExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
