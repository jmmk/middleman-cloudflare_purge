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
                    z: options.domain,
                    a: 'fpurge_ts',
                    v: 1
                }

                res = Net::HTTP.post_form(uri, params)
                body = JSON.parse(res.body)

                if body['result'] == 'success'
                    puts 'Success!'
                else
                    abort body['msg']
                end
            end

            module Helpers
                def cloudflare_purge_activated
                    true
                end
            end
        end
    end
end
