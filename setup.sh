# bin/sh

rm mimo_wheel-0.0.1.gem
gem build
gem uninstall mimo_wheel
gem install ./mimo_wheel-0.0.1.gem -n /usr/local/bin

# mimowheel
# mimowheel a
# mimowheel git
