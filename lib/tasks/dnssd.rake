namespace :dnssd do
  task :update => :environment do
    begin
      require 'discover'
      Discover.run
    rescue => e
      p e
    end
  end
end
