## :sweet_potato: tuber: Access YouTube API via R

[![Build status](https://ci.appveyor.com/api/projects/status/pgr0wih12gtwvvvx?svg=true)](https://ci.appveyor.com/project/soodoku/tuber)
[![Build Status](https://travis-ci.org/soodoku/tuber.svg?branch=master)](https://travis-ci.org/soodoku/tuber)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/tuber)](https://cran.r-project.org/package=tuber)
![](http://cranlogs.r-pkg.org/badges/grand-total/tuber)
[![codecov](https://codecov.io/gh/soodoku/tuber/branch/master/graph/badge.svg)](https://codecov.io/gh/soodoku/tuber)

Access YouTube API via R. Get comments posted on YouTube videos, information on how many times a video has been liked, search for videos with particular content, and much more. You can also scrape captions from a few videos. To learn more about the YouTube API, see [https://developers.google.com/youtube/v3/](https://developers.google.com/youtube/v3/).

### Installation

To get the current development version from GitHub:

```r
# install.packages("devtools")
devtools::install_github("soodoku/tuber", build_vignettes = TRUE)
```

To get a quick overview of some important functions in tuber, see the vignette:
```r
vignette("tuber-ex", package="tuber")
```

### Using tuber

To get going, get the application id and password from Google Developer Console (see [https://developers.google.com/youtube/v3/getting-started](https://developers.google.com/youtube/v3/getting-started)). Enable all the YouTube APIs. Also enable Freebase API. Then set the application id and password via the `yt_oauth` function. For more information about YouTube OAuth, see [YouTube OAuth Guide](https://developers.google.com/youtube/v3/guides/authentication).

```r
yt_oauth("app_id", "app_password")
```

**Get Statistics of a Video**

```r
get_stats(video_id="N708P-A45D0")
```

**Get Information About a Video**

```r
get_video_details(video_id="N708P-A45D0")
```

**Get Captions of a Video**

```r
get_captions(video_id="yJXTXN4xrI8")
```

**Search Videos**
```r
yt_search("Barack Obama")
```

**Get Comments**
```r
get_comment_threads(filter=c(video_id="N708P-A45D0"))
```

### License
Scripts are released under the [MIT License](http://opensource.org/licenses/MIT).

### Contributor Code of Conduct

The project welcomes contributions from everyone! In fact, it depends on it. To maintain this welcoming atmosphere, and to collaborate in a fun and productive way, we expect contributors to the project to abide by the [Contributor Code of Conduct](http://contributor-covenant.org/version/1/0/0/).