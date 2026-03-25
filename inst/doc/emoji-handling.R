## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# library(tuber)
# 
# # Get comments from a video
# comments <- get_all_comments(video_id = "your_video_id")
# 
# # Check which comments contain emojis
# comments$has_emoji <- has_emoji(comments$textDisplay)
# 
# # Count emojis per comment
# comments$emoji_count <- count_emojis(comments$textDisplay)
# 
# # Filter to emoji-rich comments
# emoji_comments <- comments[comments$emoji_count > 0, ]

## ----eval=FALSE---------------------------------------------------------------
# has_emoji("Hello world")
# # FALSE
# 
# has_emoji("Great video! \U0001F44D")
# # TRUE
# 
# has_emoji(c("No emoji", "Has emoji \U0001F600", "Also none"))
# # c(FALSE, TRUE, FALSE)

## ----eval=FALSE---------------------------------------------------------------
# count_emojis("Hello world")
# # 0
# 
# count_emojis("Rating: \U0001F600\U0001F600\U0001F600")
# # 3
# 
# count_emojis(c("None", "\U0001F44D", "\U0001F600\U0001F601"))
# # c(0, 1, 2)

## ----eval=FALSE---------------------------------------------------------------
# extract_emojis("Hello \U0001F44B World \U0001F30D!")
# # list(c("\U0001F44B", "\U0001F30D"))
# 
# extract_emojis(c("No emoji", "\U0001F600\U0001F601"))
# # list(character(0), c("\U0001F600", "\U0001F601"))

## ----eval=FALSE---------------------------------------------------------------
# remove_emojis("Hello \U0001F44B World!")
# # "Hello  World!"
# 
# remove_emojis(c("No emoji", "Has \U0001F600 emoji"))
# # c("No emoji", "Has  emoji")

## ----eval=FALSE---------------------------------------------------------------
# replace_emojis("Hello \U0001F44B World!", replacement = "[emoji]")
# # "Hello [emoji] World!"
# 
# replace_emojis("Rate: \U0001F600\U0001F600\U0001F600", replacement = "*")
# # "Rate: ***"

## ----eval=FALSE---------------------------------------------------------------
# comments <- get_all_comments(video_id = "your_video_id")
# comments$emoji_count <- count_emojis(comments$textDisplay)
# 
# # Top 10 most emoji-heavy comments
# top_emoji <- comments[order(-comments$emoji_count), ][1:10, ]

## ----eval=FALSE---------------------------------------------------------------
# # Remove emojis for text analysis
# comments$clean_text <- remove_emojis(comments$textDisplay)
# 
# # Now use clean_text for sentiment analysis or word clouds

## ----eval=FALSE---------------------------------------------------------------
# # Extract all emojis from comments
# all_emojis <- unlist(extract_emojis(comments$textDisplay))
# 
# # Count frequency
# emoji_freq <- table(all_emojis)
# sort(emoji_freq, decreasing = TRUE)[1:10]

## ----eval=FALSE---------------------------------------------------------------
# problematic_text <- c("caf\xe9", "na\xefve")
# safe_text <- safe_utf8(problematic_text)

## ----eval=FALSE---------------------------------------------------------------
# raw_text <- "Great video! &lt;3 &amp; more..."
# clean_text <- clean_youtube_text(raw_text)
# # "Great video! <3 & more..."

## ----eval=FALSE---------------------------------------------------------------
# # Check locale
# Sys.getlocale("LC_CTYPE")
# 
# # Set UTF-8 locale on macOS/Linux
# Sys.setlocale("LC_CTYPE", "en_US.UTF-8")

