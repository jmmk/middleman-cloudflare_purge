require 'middleman-core/cli'
require 'middleman-cloudflare_purge/extension'

module Middleman
    module Cli
        class CloudflarePurge < Thor
            include Thor::Actions

            check_unknown_options!

            namespace :cloudflare_purge

            def self.exit_on_failure?
                true
            end

            desc 'cloudflare_purge [--all]', 'Purges files from the Cloudflare cache. By default only purges updated files.'
            method_option :all,
                type: :boolean,
                desc: 'Purge ALL files from Cloudflare cache'

            def cloudflare_purge
                shared_inst = ::Middleman::Application.server.inst

                if shared_inst.respond_to? :cloudflare_purge_options
                    ::Middleman::CloudflarePurge.purge(options)
                else
                    raise Thor::Error.new 'You need to activate the cloudflare_purge extension in config.rb'
                end
            end
        end
    end
end
