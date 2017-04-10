# docker-jekyll

A docker container with Jekyll 3.0.2 to make it easier to deal with all of the versioning issues Jekyll 3 seems to have. To just use the container visit [frumpel/jekyll-3.02](https://hub.docker.com/r/frumpel/jekyll-3.0.2/) at dockerhub.

# Quickstart:

Use something like this:

```
docker pull frumpel/jekyll-3.0.2
docker run -it --rm -v $(pwd):/jekyll-src -v $(pwd)/_site:/jekyll-dst -p4000:4000 frumpel/jekyll-3.0.2:0.3
```

Warning: because jekyll is now configured such that the destination directory is outside the source directory (even if in your filesystem they happen to be nested) jekyll will get into a regeneration loop where the changed files in the destination directory are the trigger for another run. To avoid this, please ensure that your _config.yml contains `exclude: ["_site"]`.

Note: the default command string is

```
jekyll serve -s /jekyll-src -d /jekyll-dst --force_polling --host 0.0.0.0
```

The last one is particularly important to ensure that you can connect to jekyll from outside the container. You can move this setting into your _config.yml as needed.

# Detailed explanation:

```
docker run -it --rm -v $(pwd):/jekyll-src -v $(pwd)/_site:/jekyll-dst -p4000:4000 frumpel/jekyll-3.0.2:0.2
```

* `-it` - run interactively and persistently
* `--rm` - make sure that the container is removed from the docker ps list after exiting
* `-v  $(pwd):/jekyll-src` - mount the current working directory (via the shell escape sequence $() calling the pwd command) to the /jekyll-src directory in the container
* `-v  $(pwd)/_site:/jekyll-dst` - mount the _site subdirector of the current working directory (via the shell escape sequence $() calling the pwd command) to the /jekyll-dst directory in the container
* `-p 4000:4000` - expose the jekyll process running on port 4000 inside the container to port 4000 on the docker host
* `frumpel/jekyll-3.0.2` - this container

The container will default to running `serve -s /jekyll-src -d /jekyll-dst --watch` so most of the time you should not have to do anything more:

* `serve -s /jekyll-src -d /jekyll-dst --force_polling --host 0.0.0.0` - this will start a server on default port 4000 on all interfaces, convert the contents of the "source" in /jekyll-src (=current working directory in this example) in the container to "destination" in /jekyll-dst (which is the _site subdirectory of the current working directory in this example), then watch for any changes and keep updating the destination as well as serving the new content. Note that this is using `--force_polling` instead of `--watch` which seems to work better in containers running on VMs sharing an underlaying host filesystem.

If you want to override any commands you can simply override the jekyll command line parameters like this:

```
docker run -it --rm -v $(pwd):/jekyll-src -v $(pwd)/_site:/jekyll-dst -p4000:4000 frumpel/jekyll-3.0.2:0.2 help
```

# Creating the container from this definition

Clone this repository, cd into it and use standard docker invocation:

```
docker build -t frumpel/jekyll-3.0.2:testing .
```

