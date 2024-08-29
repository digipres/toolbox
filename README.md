DigiPres Toolbox
----------------

A Docker image designed to make it easy to experiment with tools for Digital Preservation.  Designed to be used via the [DigiPres Sandbox](https://github.com/digipres/sandbox) and the [DigiPres Workbench](https://github.com/digipres/workbench).

Build locally with e.g.

```
docker build . -t toolbox
```

Then run with

```
docker run -it toolbox bash
```

## Supported Tools

Large (>>1GB) images don't seem to run well on Binder, so we can't install everything we'd like to. e.g. `ffmpeg` takes up 0.5GB!

These sizes can be determined by using separate installation lines in the `Dockerfile` and then using commands like this to see what happened and what size the additional layer is:

```
docker history --no-trunc toolbox | grep ffmpeg
```

### Pre-installed

 - [CLOC](https://github.com/AlDanial/cloc)
 - [Fido](https://github.com/openpreserve/fido)
 - [File](https://www.darwinsys.com/file/)
 - [MediaInfo](https://github.com/MediaArea/MediaInfo)
 - [RClone](https://rclone.org/)
 - [Siegfried](https://www.itforarchivists.com/siegfried)
 - [TrID](http://mark0.net/soft-trid-e.html)

### Verified Installable

These aren't installed by default because of their size, but the [Sandbox](https://github.com/digipres/sandbox) indicates how to download and install them.

 - [Apache Tika](https://tika.apache.org/)
 - [DROID](http://digital-preservation.github.io/droid/)
 - [ffmpeg](https://ffmpeg.org) including [ffprobe](https://ffmpeg.org/ffprobe.html)
 - [pdfcpu](https://pdfcpu.io)

### Cannot Be Installed

These require root access to install but take up too much space

 - [GitHub Linguist](https://github.com/github/linguist) (200-400MB in size depending on base image, mostly down to requiring a full build environment)

### To Consider

- VeraPDF
- JHOVE
- Handbrake
- MediaConch
- [EPUBCheck](https://www.w3.org/publishing/epubcheck/)

## Inspirations

- The PLANETS Testbed ([briefing paper](https://www.dcc.ac.uk/guidance/briefing-papers/technology-watch-papers/planets-testbed), [article](https://journal.code4lib.org/articles/83))
- [VIPER](https://viper.openpreservation.org/)
