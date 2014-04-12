class Discover
  def self.run
    new.run
  end

  def run
    DNSSD.browse!('_avalanche._tcp.') do |browse_reply|
      DNSSD.resolve(browse_reply) do |reply|
        DocumentUpdater.new(reply.target, reply.port).update
      end
    end
  end
end
