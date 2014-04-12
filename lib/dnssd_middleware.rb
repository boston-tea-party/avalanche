require 'socket'

class DnssdMiddleware
  def initialize(app)
    @app = app

    if ENV['PORT']
      DNSSD.register('Avalanche Service', '_avalanche._tcp.', nil, ENV['PORT'].to_i)
    end
  end

  def call(env)
    @app.call(env)
  end
end
