FROM alpine:3.7

run apk add --no-cache yaml-dev yajl build-base python python-dev ruby nodejs ruby-rdoc ruby-irb ruby-dev
run gem install bundler
run npm install -g grunt-cli

workdir /app
copy . .
run bundler
run npm install
run grunt
cmd jekyll serve -c "_config.yml,_config.local.yml"


