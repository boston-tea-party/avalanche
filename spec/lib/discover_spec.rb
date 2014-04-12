require 'spec_helper'
require Rails.root.join('lib', 'discover')

describe Discover do
  it 'discovers nearby servers' do
    port = 1080
    document_updater = double('document_updater', update: nil)
    expect(DocumentUpdater).to receive(:new).
      with("#{fqdn}.", port).
      and_return(document_updater)

    server = spawn_server(port)
    discoverer = Thread.new { discover.run }
    server.close
    server = spawn_server(port)

    server.close
    sleep 1
    discoverer.kill
  end

  private

  let(:discover) { Discover.new }

  def spawn_server(port)
    @_count ||= 0
    server = TCPServer.new port

    DNSSD.announce server, "Avalanche #{@_count}", port
    DNSSD.register(
      "Avalanche Service #{@_count}", '_avalanche._tcp.', nil, port)

    server
  end

  def fqdn
    "#{Socket.gethostname}.local"
  end
end
