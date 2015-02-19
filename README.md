## Consul / PHP

### Usage

run `deps-puppet.sh` to grab puppet dependencies, `php-install.sh` to pull down the php demo app, then `vagrant up`

	./deps-puppet.sh
	./php-install.sh
	vagrant up

- deps.sh will pull in puppet module dependencies
- build.sh builds the demo spring boot app: (just runs ./gradlew build)

add the following to your `/etc/hosts` file

	172.20.20.20 demo.local
	172.20.20.21 foo0.local
	172.20.20.22 foo1.local


### links (once it's up)
- Dashboard
	- [consul](http://172.20.20.11:8500/ui/#/dc1/services)
- Demo
	- [demo](http://demo.local/api/demo)
	- [demo health](http://demo.local/api/health)


