ENV['ASCIIDOCTOR_MANPAGE_PATH'] ||= '/usr/share/man/man1/asciidoctor.1.gz'
ENV['ASCIIDOCTOR_LIB_DIR'] ||= '/usr/lib/ruby/vendor_ruby'
load 'Rakefile'
task :default => 'test:all'
