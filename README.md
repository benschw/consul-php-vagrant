## Consul / PHP demo

A vagrant cluster demoing a single "demo" service discovering one of two "foo" services. The vms are provisioned with vagrant and puppet, the foo services are registered using a service definition config provided by the consul puppet module, and the demo service discovers "foo" through the dns server provided by the consul agent. Dnsmasq is leveraged to integrate the consul dns server natural dns request can be used.

### Usage

run `deps-puppet.sh` to grab puppet dependencies, `php-install.sh` to pull down the php demo app, then `vagrant up`

	./deps-puppet.sh
	./php-install.sh
	vagrant up

- `deps-puppet.sh` will pull in puppet module dependencies in `./puppet/modules` for vagrant to leverage
- `php-install.sh` installs the demo php app in `./demo` (the vagrant vhosts will point to this via `/vagrant/demo`)

add the following to your `/etc/hosts` file to make browsing to the demo service easier (or just use the ip)

	172.20.20.20 demo.local


### links (once it's up)
- Dashboard
	- [consul](http://172.20.20.11:8500/ui/#/dc1/services)
- Demo
	- [demo](http://demo.local:8080/demo)
	- [demo health](http://demo.local:8080/api/health)
	- [foo0 svc](http://172.20.20.21:8080/foo)
	- [foo1 svc](http://172.20.20.22:8080/foo)

