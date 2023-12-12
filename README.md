This repository contains Docker files for running [Mapbox GL](https://github.com/mapbox/mapbox-gl-native) integration tests on [CircleCI](https://circleci.com/gh/mapbox/mapbox-gl-native).

### Guidelines

* ⚠️ **Never overwrite published tags.** Instead, we use a revision system, using a Docker Hub repository for every set of images. The name of the repository is the name of the image, and the versions is the first 10 bytes of the Git SHA.
* **Do not delete old images from Docker Hub**. Retaining old images on Docker Hub means that we can still build older branches.
* **Reduce ephemeral/temporary data** by combining multiple commands into one `RUN` command. Unfortunately, Circle CI doesn't support `--squash`, so we'll have to make sure that we're not creating unused files. E.g. when you run `apt-get update`, also run `rm -rf /var/lib/apt/lists/*` in the same step to remove the repository metadata.

### Adding a new image

When you want to add a new image, e.g. a new compiler version or a new Android NDK version, duplicate an existing file in the `images` directory, and change it to suit your needs. There's usually no need to keep previous versions of e.g. the Android NDK around. Legacy branches of mapbox-gl-native will use legacy Docker images that contain the legacy NDKs.

### Updating a new image

When you want to update an existing image, e.g. update dependencies, new feature, etc. edit an existing file in the `images` directory, and change it to suit your needs. If the image you're modifying serves as a base for other images (i.e. used in `FROM` command like in [android-sdk](https://github.com/mapbox/mbgl-ci-images/blob/master/images/android-sdk#L1)) you also need to build the derived images, for example [PR#88](https://github.com/mapbox/mbgl-ci-images/pull/88).

### Workflow

To trigger a build, include `[docker:imagename]` in the commit message and push to Github. Only the most recent commit of a branch will be built.

Every set of images has a "Revision ID", which is based on the first 10 characters of the Git SHA. You can also see this ID by looking into the "Revision ID" step on any Circle CI build in the workflow.

When the workflow you're building **fails**, please remove images that you generated but don't need anymore from Docker Hub to prevent heaps of unused Docker images piling up.

### Local development

To speed up local development, you can run `scripts/apt-proxy.sh` to launch a local APT proxy that caches package downloads. Then run `./build.sh <imagename>` to build the image locally.
