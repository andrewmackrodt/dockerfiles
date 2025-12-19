TAG_MAJOR=true

# define default action, implemented in Makefile.mk
build:

pre-push:
	docker tag andrewmackrodt/nodejs:22 andrewmackrodt/nodejs:maintenance
	docker tag andrewmackrodt/nodejs:24 andrewmackrodt/nodejs:lts
	docker tag andrewmackrodt/nodejs:25 andrewmackrodt/nodejs:current

post-push:
	docker push andrewmackrodt/nodejs:maintenance
	docker push andrewmackrodt/nodejs:lts
	docker push andrewmackrodt/nodejs:current

include ../Makefile.mk
