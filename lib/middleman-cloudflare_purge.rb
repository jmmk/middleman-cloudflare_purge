require 'middleman-core'

class CloudflarePurge < Middleman::Extension
    option :force, false, 'Force a full purge'

    def initialize(app, options_hash={}, &block)
        super
    end
end

::Middleman::Extensions.register(:cloudflare_purge, CloudflarePurge)
