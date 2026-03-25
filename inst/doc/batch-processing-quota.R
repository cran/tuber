## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## ----quota-tracking, eval=FALSE-----------------------------------------------
# library(tuber)
# 
# # Check current quota usage
# quota_status <- yt_get_quota_usage()
# print(quota_status)
# 
# # View details
# quota_status$quota_used      # Units used today
# quota_status$quota_limit     # Your daily limit (default: 10,000)
# quota_status$quota_remaining # Units remaining
# quota_status$reset_time      # When quota resets (midnight Pacific Time)

## ----set-quota, eval=FALSE----------------------------------------------------
# # Set a custom quota limit
# yt_set_quota_limit(50000)
# 
# # Reset quota tracking (e.g., after midnight)
# yt_reset_quota()

## ----api-key, eval=FALSE------------------------------------------------------
# # Set up API key (get one from Google Cloud Console)
# yt_set_key("YOUR_API_KEY")
# 
# # Use API key for read operations
# video_stats <- get_video_details(
#   video_ids = "dQw4w9WgXcQ",
#   auth = "key"
# )
# 
# channel_stats <- get_channel_stats(
#   channel_ids = "UCuAXFkgsw1L7xaCfnd5JJOw",
#   auth = "key"
# )

## ----oauth, eval=FALSE--------------------------------------------------------
# # Set up OAuth2 (opens browser for authentication)
# yt_oauth("YOUR_CLIENT_ID", "YOUR_CLIENT_SECRET")
# 
# # Write operations require OAuth
# create_playlist(
#   title = "My New Playlist",
#   description = "A collection of favorites",
#   status = "private"
# )
# 
# # Access your own channel's unlisted videos
# list_my_videos()

## ----batch-videos, eval=FALSE-------------------------------------------------
# # Get details for multiple videos at once
# video_ids <- c("dQw4w9WgXcQ", "M7FIvfx5J10", "kJQP7kiw5Fk")
# 
# # Single API call for multiple videos (more efficient)
# videos <- get_video_details(
#   video_ids = video_ids,
#   part = c("snippet", "statistics"),
#   auth = "key"
# )
# 
# # Analyze results
# head(videos)

## ----bulk-analysis, eval=FALSE------------------------------------------------
# # Comprehensive video analysis
# analysis <- bulk_video_analysis(
#   video_ids = video_ids,
#   include_comments = FALSE,
#   auth = "key"
# )
# 
# # Access results
# analysis$video_data    # Detailed video information
# analysis$benchmarks    # Performance percentiles
# analysis$summary       # Overall statistics
# 
# # Channel analysis
# channel_analysis <- analyze_channel(
#   channel_id = "UCuAXFkgsw1L7xaCfnd5JJOw",
#   max_videos = 50,
#   auth = "key"
# )
# 
# # Compare multiple channels
# comparison <- compare_channels(
#   channel_ids = c("UC1", "UC2", "UC3"),
#   metrics = c("subscriber_count", "video_count", "view_count"),
#   auth = "key"
# )

## ----pagination, eval=FALSE---------------------------------------------------
# # Request more items than API allows per page (50)
# # tuber automatically makes multiple API calls
# playlist_items <- get_playlist_items(
#   playlist_id = "PLrAXtmErZgOeiKm4sgNOknGvNjby9efdf",
#   max_results = 200,  # Will make 4 API calls
#   auth = "key"
# )
# 
# # Get many comments with automatic pagination
# comments <- get_comment_threads(
#   filter = c(video_id = "dQw4w9WgXcQ"),
#   max_results = 500,  # Will paginate automatically
#   auth = "key"
# )

## ----extract-simple, eval=FALSE-----------------------------------------------
# # Get simplified output
# videos <- get_video_details(
#   video_ids = "dQw4w9WgXcQ",
#   simplify = TRUE,
#   auth = "key"
# )
# 
# # Access fields directly
# videos$title
# videos$viewCount
# videos$likeCount
# videos$channelTitle

## ----extract-raw, eval=FALSE--------------------------------------------------
# # Get raw API response
# videos_raw <- get_video_details(
#   video_ids = "dQw4w9WgXcQ",
#   simplify = FALSE,
#   auth = "key"
# )
# 
# # Navigate nested structure
# video <- videos_raw$items[[1]]
# video$snippet$title
# video$snippet$thumbnails$high$url
# video$statistics$viewCount
# video$contentDetails$duration

## ----field-patterns, eval=FALSE-----------------------------------------------
# # Video details
# videos$snippet.title          # Title
# videos$snippet.description    # Description
# videos$statistics.viewCount   # View count
# videos$statistics.likeCount   # Like count
# videos$contentDetails.duration # Duration (ISO 8601)
# 
# # Channel details
# channels$snippet.title           # Channel name
# channels$statistics.subscriberCount
# channels$statistics.videoCount
# channels$brandingSettings.channel.description
# 
# # Comment extraction
# comments$snippet.topLevelComment.snippet.textDisplay
# comments$snippet.topLevelComment.snippet.authorDisplayName
# comments$snippet.topLevelComment.snippet.likeCount

## ----retry, eval=FALSE--------------------------------------------------------
# # Automatic retry with exponential backoff
# result <- with_retry(
#   get_video_details(video_ids = "dQw4w9WgXcQ", auth = "key"),
#   max_retries = 3,
#   base_delay = 1
# )

## ----quota-handling, eval=FALSE-----------------------------------------------
# # Check before making requests
# quota <- yt_get_quota_usage()
# if (quota$quota_remaining < 100) {
#   warning("Low quota! Consider waiting until reset at: ", quota$reset_time)
# }
# 
# # Wrap expensive operations
# tryCatch({
#   results <- yt_search(term = "R programming", max_results = 50)
# }, error = function(e) {
#   if (grepl("quota", e$message, ignore.case = TRUE)) {
#     message("Quota exceeded. Try again after: ", yt_get_quota_usage()$reset_time)
#   }
# })

## ----rate-limiting, eval=FALSE------------------------------------------------
# # Add delays between requests
# video_ids <- c("id1", "id2", "id3", "id4", "id5")
# 
# results <- lapply(video_ids, function(vid) {
#   Sys.sleep(0.5)  # 500ms delay between requests
#   get_video_details(video_ids = vid, auth = "key")
# })

## ----caching, eval=FALSE------------------------------------------------------
# # Configure cache
# tuber_cache_config(
#   enabled = TRUE,
#   max_size = 100,
#   ttl = 3600  # 1 hour TTL
# )
# 
# # Cached functions (no API call if recently fetched)
# cats <- list_videocats_cached(auth = "key")
# langs <- list_langs_cached(auth = "key")
# regions <- list_regions_cached(auth = "key")
# channel <- get_channel_info_cached(channel_id = "UCxyz", auth = "key")
# 
# # Check cache status
# tuber_cache_info()
# 
# # Clear cache when needed
# tuber_cache_clear()

## ----example-channel, eval=FALSE----------------------------------------------
# # Full channel analysis
# analysis <- analyze_channel(
#   channel_id = "UCuAXFkgsw1L7xaCfnd5JJOw",
#   max_videos = 100,
#   auth = "key"
# )
# 
# # Summary statistics
# cat("Channel:", analysis$channel_info$title, "\n")
# cat("Subscribers:", analysis$channel_info$subscriberCount, "\n")
# cat("Average views:", analysis$performance_metrics$avg_views_per_video, "\n")
# cat("Engagement rate:", analysis$performance_metrics$engagement_rate, "\n")

## ----example-trending, eval=FALSE---------------------------------------------
# # Analyze trending topics
# trends <- analyze_trends(
#   search_terms = c("machine learning", "AI", "data science"),
#   time_period = "month",
#   max_results = 25,
#   region_code = "US",
#   auth = "key"
# )
# 
# # View trend summary
# print(trends$trend_summary)
# 
# # Most trending term
# best_trend <- trends$trend_summary[1, ]
# cat("Top trending:", best_trend$search_term, "\n")
# cat("Total views:", best_trend$total_views, "\n")

## ----example-batch, eval=FALSE------------------------------------------------
# # Get all videos from a playlist
# playlist_videos <- get_playlist_items(
#   playlist_id = "PLrAXtmErZgOeiKm4sgNOknGvNjby9efdf",
#   max_results = 100,
#   auth = "key"
# )
# 
# # Extract video IDs
# video_ids <- sapply(playlist_videos$items, function(x) {
#   x$contentDetails$videoId
# })
# 
# # Get detailed stats for all videos in one call
# video_stats <- get_video_details(
#   video_ids = video_ids,
#   part = c("statistics", "contentDetails"),
#   auth = "key"
# )
# 
# # Analyze performance
# total_views <- sum(as.numeric(video_stats$viewCount), na.rm = TRUE)
# avg_duration <- mean(as.numeric(video_stats$duration), na.rm = TRUE)

## ----help, eval=FALSE---------------------------------------------------------
# # Check function documentation
# ?get_video_details
# ?yt_search
# ?with_retry
# 
# # View package vignettes
# browseVignettes("tuber")

