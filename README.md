## Consul / PHP demo

A vagrant cluster demoing a single "demo" service discovering one of two "foo" services. 

The vms are provisioned with vagrant and puppet, the foo services are registered using a service definition config provided by the consul puppet module, and the demo service discovers "foo" through the dns server provided by the consul agent. Dnsmasq is leveraged to integrate the consul dns server so vanilla dns requests can be used.

A single demo application is used for the "demo" service and two "foo" services (it contains a "DemoResource" and a "FooResource") to make tinkering with the demo easier. 

### Getting Started
Make sure you have...
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [Composer](https://getcomposer.org/download/)
<!-- break -->

	git clone https://github.com/fliglio/fliglio-consul-vagrant.git
	cd fliglio-consul-vagrant
	./puppet-deps.sh
	composer create-project fliglio/consul-app --dev demo
	vagrant up


- `puppet-deps.sh` will pull in puppet module dependencies in `./puppet/modules` for vagrant to leverage
- `composer create-project...` installs the demo php app in `./demo` (the vagrant vhosts will point to this)
- `vagrant up` will stand up your cluster

### Now What?
- Dashboard
	- [consul](http://172.20.20.11:8500/ui/#/dc1/services)
- Demo
	- [demo](http://172.20.20.20:8080/demo)
	- [demo health](http://172.20.20.20:8080/api/health)
	- [foo0 svc](http://172.20.20.21:8080/foo)
	- [foo1 svc](http://172.20.20.22:8080/foo)

Refresh the [demo page](http://172.20.20.20:8080/demo) a few times and see the foo svc ip change as it resolves the service via. consul.