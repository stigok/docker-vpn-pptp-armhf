OWNER = sshow
NAME = vpn-pptp-arm
IMAGE = $(OWNER)/$(NAME)

VERSION = 0.1

all: build

build:
	docker build -t $(IMAGE):$(VERSION) .

clean:
	docker rm -f $(NAME)-test

testrun:
	docker run -d \
		--privileged \
		--net=host \
		--name="$(NAME)-test" \
		-p 1723:1723 \
		-v $(PWD)/etc/pptpd.conf:/etc/pptpd.conf \
		-v $(PWD)/etc/ppp/pptpd-options:/etc/ppp/pptpd-options \
		-v $(PWD)/chap-secrets:/etc/ppp/chap-secrets \
		--tmpfs /var/log:rw,noexec,nosuid \
		-v $(PWD)/wtmp.log:/var/log/wtmp \
		--restart=unless-stopped \
		--env TZ=Europe/Oslo \
		$(IMAGE):$(VERSION)

