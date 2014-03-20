require 'middleman-core'
require 'net/http'

module Middleman
    module CloudflarePurge
        class Options < Struct.new(
            :token,
            :email,
            :domain,
        )
        end

        class << self
            def options
                @@options
            end

            def registered(app, options_hash = {}, &block)
                options = Options.new(options_hash)
                yield options if block_given?

                @@options = options

                app.send :include, Helpers

                load_config
            end
            alias :included :registered

            def load_config
                root_path = ::Middleman::Application.root
                config_file = File.join(root_path, '.cloudflare_purge')

                if File.exists?(config_file)
                    config = YAML.load(File.open(config_file, 'r'))
                    config.each do |k, v|
                        options[k] = v
                    end
                else
                    return {}
                end
            end

            def purge(opts)
                uri = URI('https://www.cloudflare.com/api_json.html')
                params = {
                    tkn: options.token,
                    email: options.email,
                    z: options.domain
                }
                puts options.token
                puts options.email
                puts options.domain

                if opts[:all]
                    params[:a] = 'fpurge_ts'
                    params[:v] = 1
                else
                    params[:a] = 'zone_file_purge'
                    params[:url]
                end

                res = Net::HTTP.post_form(uri, params)
                if res.code == 200
                    body = JSON.parse(res.body)

                    if body['result'] == 'success'
                        puts 'Success!'
                    else
                        abort body['msg'] + "\nCheck your configuration settings."
                    end
                else
                    abort "Couldn't connect to Cloudflare"
                end
            end

            module Helpers
                def cloudflare_purge_options
                    ::Middleman::CloudflarePurge.options
                end
            end
        end
    end
end
