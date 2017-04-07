# docker-jekyll

A docker container with Jekyll 3.0.2 to make it easier to deal with all of the versioning issues Jekyll 3 seems to have. To just use the container visit [frumpel/jekyll-3.02](https://hub.docker.com/r/frumpel/jekyll-3.0.2/) at dockerhub.

# Quickstart:

Use something like this:

```
docker pull frumpel/jekyll-3.0.2
docker run -it --rm -v $(pwd):/jekyll -p4000:4000 frumpel/jekyll-3.0.2 serve -s /jekyll -d /jekyll/_site --watch
```

Note: On CentOS7 networking may be borked and you may need to use --net=host but note that this may make it harder to get to the container from outside your VM

```
docker run -it --rm -v $(pwd):/jekyll -p4000:4000 --net=host  frumpel/jekyll-3.0.2 serve -s /jekyll -d /jekyll/_site --watch
```

# Detailed explanation:

```
docker run -it --rm -v $(pwd):/jekyll -p4000:4000 frumpel/jekyll-3.0.2 serve -s /jekyll -d /jekyll/_site --watch
```

* `-it` - run interactively and persistently
* `--rm` - make sure that the container is removed from the docker ps list after exiting
* `-v  $(pwd):/jekyll` - mount the current working directory (via the shell escape sequence $() calling the pwd command) to the /jekyll directory in the container
* `-p 4000:4000` - expose the jekyll process running on port 4000 inside the container to port 4000 on the docker host
* `frumpel/jekyll-3.0.2` - this container
* `serve -s /jekyll -d /jekyll/_site` - this is the command that you would pass to jekyll: start a server on default port, convert the contents of the "source" in /jekyll (=current working directory in this example) in the container to "destination" in /jekyll/_site (which is the _site subdirectory of the current working directory), then watch for any changes and keep updating the destination


