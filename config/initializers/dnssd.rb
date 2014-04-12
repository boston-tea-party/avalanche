require 'dnssd_middleware'
Avalanche::Application.config.middleware.use DnssdMiddleware
