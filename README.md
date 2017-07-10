This repository contains Docker files for running [Mapbox GL](https://github.com/mapbox/mapbox-gl-native) integration tests on [CircleCI](https://circleci.com/gh/mapbox/mapbox-gl-native).



### Guidelines

* ⚠️ **Never overwrite published tags.** Instead, we use a revision system, prefixing all names with `rN`, with `N` being a linearly increasing number.
* **Anchor images in hierarchy.** We use a hierarchy of images so that shared components (e.g. curl/zip/node) are only contained in one layer. CircleCI caches images, and using a shared base image means that we'll have to download fewer images from DockerHub. See the hierarcy below.
* **Do not delete old images from DockerHub**. Retaining old images on DockerHub means that we can still build older branches.
* **Squash individual images** with `--squash`. This means that all layers within an image are squashed into one layer, and reduces the file size dramatically, in particular when you are generating temporary files during installation (e.g. `apt-get`, SDK downloads). In the same vein, clean up temporary files at the end or within the same layer to keep our image sizes small.



### Hierarchy

* **ubuntu:16.04** (~130MB)
  * **base**:  curl/zip/node/python/pip (~800MB)
    * **linux**: build tools, OpenGL header + runtime (~190MB)
      * **linux-clang-3.9** (~390MB)
      * **linux-clang-4** (~470MB)
      * **linux-gcc-4.9** (~100MB)
      * **linux-gcc-5** (0 MB)
      * **linux-gcc-6** (~500MB)
      * **linux-gl-js** (~400MB)
      * ... (other compilers)
    * **java**: Java runtime, JDK, Google Cloud SDK (~330MB)
      * **android**: Android SDK (~1.3GB)
        * **android-ndk-r13b**: Android NDK r13b (~2.35GB)
          * **android-ndk-r13b-gradle**: Gradle dependencies of our project (~320MB)
        * **android-ndk-r15beta1**: Android NDK r15 beta1
          * **android-ndk-r15beta1-gradle**: Gradle dependencies of our project
        * ... (other NDK images)



### Adding a new image

When you want to add a new image, e.g. a new compiler version or a new Android NDK version, duplicate an existing folder, and change the `Dockerfile` in it to suite your needs. To build a `linux-clang-5` image locally, first ensure that the base image revision you're using is tagged as the `latest` image (all Dockerfiles start with a `FROM mbgl/ci:latest-...` directive):

```
docker tag mbgl/ci:latest-linux mbgl/ci:r2-linux
```

Then, you can attempt building your image:

```
docker build -t mbgl/ci:latest-linux-clang-5 linux-clang-5
```

Once you're satisfied with the image, rebuild it in a squashed way, tag it as the release image and push it:

```
docker build -t mbgl/ci:latest-linux-clang-5 --squash linux-clang-5
docker tag mbgl/ci:r2-linux-clang-5 mbgl/ci:latest-linux-clang-5
docker push mbgl/ci:r2-linux-clang-5
```

⚠️ Never push `latest` images!

If the image you're creating has not existed before, you can reuse the existing revision.



### Creating a new revision

Sometimes it's necessary to create an entirely new revision. This is the case when you want to upgrade components in the base images, such as `curl`, `python`, or a new Android SDK or Java version, as well as when you add new tools somewhere in the hierarchy.

When creating a new revision, delete any images that you don't need anymore in the current test run. Old branches will continue to use the Docker images in the previous revision, so there's no need to preserve e.g. old NDKs in the current branch.

To build a new revision, change the `all.sh` script to only include the relevant images, and run with

```
REVISION=3 ./all.sh
```

