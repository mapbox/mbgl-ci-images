This repository contains Docker files for running [Mapbox GL](https://github.com/mapbox/mapbox-gl-native) integration tests on [CircleCI](https://circleci.com/gh/mapbox/mapbox-gl-native).



### Guidelines

* ⚠️ **Never overwrite published tags.** Instead, we use a revision system, using a Docker Hub repository for every set of images. The name of the repository is the 10 first characters of the Git SHA.
* **Anchor images in hierarchy.** We use a hierarchy of images so that shared components (e.g. curl/zip/node) are only contained in one layer. CircleCI caches images, and using a shared base image means that we'll have to download fewer images from Docker Hub. See the hierarcy below.
* **Do not delete old images from Docker Hub**. Retaining old images on Docker Hub means that we can still build older branches.
* **Reduce ephemeral/temporary data** by combining multiple commands into one `RUN` command. Unfortunately, Circle CI doesn't support `--squash`, so we'll have to make sure that we're not creating unused files. E.g. when you run `apt-get update`, also run `rm -rf /var/lib/apt/lists/*` in the same step to remove the repository metadata.



### Hierarchy

* **ubuntu:16.04** (~130MB)
  * **base**:  curl/zip/node/python/pip (~800MB)
    * **linux**: build tools, OpenGL header + runtime (~190MB)
      * **linux-clang-3.9** (~390MB)
      * **linux-clang-4** (~470MB)
      * **linux-gcc-4.9** (~100MB)
      * **linux-gcc-5** (0 MB)
      * **linux-gcc-6** (~500MB)
      * ... (other compilers)
    * **java**: Java runtime, JDK, Google Cloud SDK (~330MB)
      * **android-ndk-r16**: Android NDK r16 (~2.35GB)
      * ... (other NDK images)



### Adding a new image

When you want to add a new image, e.g. a new compiler version or a new Android NDK version, duplicate or rename an existing folder, and change the `Dockerfile` in it to suite your needs. There's no need to keep previous versions of e.g. the Android NDK around. Legacy branches of mapbox-gl-native will use legacy Docker images that contain the legacy NDKs.

### Workflow

Whenever an image in the hierarchy changes, we're completely rebuilding the entire image hierarchy to benefit from Circle's Docker image caching. Builds are triggered when you start a **pull request**. However, builds are paused, and you'll have to manually click on the Resume button on Circle CI to start building. We do this to prevent building images too frequently, or when merging changes to master.

Every set of images has a "Revision ID", which is based on the first 10 characters of the Git SHA. You can also see this ID by looking into the "Revision ID" step on any Circle CI build in the workflow.

When the workflow you're building **fails**, please remove the associated repository from Docker Hub to prevent heaps of unused Docker images piling up.

Once a set of images completes building, it's time to update mapbox-gl-native. To do so, create a pull request that changes the Revision ID to the new one. If it succeeds, it's time "merge" the pull request in this repository that changed the image files. Instead of creating merge commits or merges via the GitHub UI, please do a fast-forward merge by switching to the master branch and running `git merge --ff-only <branchname>`. This allows use to remain a 1:1 relation between the Docker image Revision IDs and the Commit SHAs in this repository.