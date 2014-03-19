class CloudflarePurge < Middleman::Extension
    def initialize(app, options_hash={}, &block)
        super
    end

    alias :included :registered
end

::Middleman::Extensions.register(:cloudflare_purge, CloudflarePurge)
