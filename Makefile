clean:
	rm -rf _site/

build:
	docker run --rm --volume="${PWD}:/srv/jekyll" -it jekyll/jekyll jekyll build

serve:
	docker run --rm --volume="${PWD}:/srv/jekyll" -p 3000:4000 -it jekyll/jekyll jekyll serve --watch
