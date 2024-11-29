lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'yaml'

Gem::Specification.new do |s|
    s.name = 'mimo_wheel'
    s.version = File.read(File.expand_path('../VERSION', __FILE__)).strip
    s.summary = 'Ruby mimo_wheel'
    s.description = 'Ruby mimo_wheel'
    s.license = 'MIT'
    s.authors = ['Murph.Lu']
    s.email = ['murph.lu@163.com']
    s.files = Dir['lib/*', 'lib/*/*', 'LICENSE', 'README.md']
    s.bindir = "bin"
    s.executables = ['mimowheel']
    s.require_paths = ['lib']
    s.homepage = 'https://github.com/MurphLu/ruby_toolbox.git'
    s.metadata = {
        'source_code_uri' => 'https://github.com/MurphLu/ruby_toolbox.git',
        "homepage_uri" => 'https://github.com/MurphLu/ruby_toolbox.git',
    }
    s.required_ruby_version = '>= 2.6.0'
    s.add_dependency('yaml', '~> 0.1.0')
    s.add_dependency('colored', '~> 1.2')
    s.add_dependency('commander', '~> 4.4')
    s.add_dependency('rmagick', '~>5')
end