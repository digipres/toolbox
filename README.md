DigiPres Toolbox
----------------

A Docker image designed to make it easy to experiment with tools for Digital Preservation.  Designed to be used via the [DigiPres Sandbox](https://github.com/digipres/sandbox) and the [DigiPres Workbench](https://github.com/digipres/workbench).

## Supported Tools

### Pre-installed

Only light-weight tools are pre-installed, so the Docker image size (and hence Sandbox launch times) can be kept low.

 - [Siegfried](https://www.itforarchivists.com/siegfried)
 - [File](https://www.darwinsys.com/file/)
 - [TrID](http://mark0.net/soft-trid-e.html)
 - [MediaInfo](https://github.com/MediaArea/MediaInfo)
 - [CLOC](https://github.com/AlDanial/cloc)

### Verified Installable

These aren't installed by default, but the [Sandbox](https://github.com/digipres/sandbox) shows how to install them.

 - [Apache Tika](https://tika.apache.org/)
 - [DROID](http://digital-preservation.github.io/droid/)
 - [Fido](https://github.com/openpreserve/fido)
 - [ffmpeg](https://ffmpeg.org) including [ffprobe](https://ffmpeg.org/ffprobe.html)
 - [GitHub Linguist](https://github.com/github/linguist)

### To Consider

- VeraPDF
- JHOVE
- Handbrake
- MediaConch

## Inspirations

- The PLANETS Testbed ([briefing paper](https://www.dcc.ac.uk/guidance/briefing-papers/technology-watch-papers/planets-testbed), [article](https://journal.code4lib.org/articles/83))
- [VIPER](https://viper.openpreservation.org/)
