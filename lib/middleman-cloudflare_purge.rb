require 'middleman-core'
require 'middleman-cloudflare_purge/commands'

::Middleman::Extensions.register(:cloudflare_purge) do
    require 'middleman-cloudflare_purge/extension'
    ::Middleman::CloudflarePurge
end
