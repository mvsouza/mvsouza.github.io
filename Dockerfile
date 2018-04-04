FROM mvsouza/myjekyll:2

workdir /app
copy . .
run bundler
run npm install
run grunt
cmd jekyll serve -c "_config.yml,_config.local.yml"
