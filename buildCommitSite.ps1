$lastcommit = git rev-parse HEAD
jekyll build
cd _site
"" >> .nojekyll
git add -A
git commit -m "commit($lastcommit)"
git push origin master
cd ..