Gem::Specification.new do |gem|
    gem.name = 'middleman-cloudflare_purge'
    gem.version = '0.0.5'
    gem.authors = ['Michael McLellan']
    gem.email = 'jmikem825@gmail.com'
    gem.description = 'Purge updated files from your Cloudflare cache'
    gem.summary = 'Cloudflare cache purging for Middleman'
    gem.homepage = 'https://github.com/jmmk/middleman-cloudflare_purge'
    gem.license = 'MIT'

    gem.files = `git ls-files`.split($/)
    gem.require_paths = ['lib']

    gem.add_runtime_dependency 'middleman-core', '~> 3.0'
end
