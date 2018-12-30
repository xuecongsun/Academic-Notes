library(rwteet)    #twitter API
library(ggplot2)
library(dplyr)
library(rvest)     #web scraping
library(tm)        #corpus
library(tidytext)  #tokenize
library(SnowballC) #stemming
library(topicmodels) #topic modelling
library(stm)       #structural topic modelling
library(stringr)   #dictionary-based analysis
library(widyr)     #word embedding
library(broom)     #identify synonyms in skip-gram word embedding
library(cleanNLP)  #Speech tagging

########################################################
#                                                      #
#           rtweet package                             #
#                                                      #
########################################################
## credential
app_name<-"YOURAPPNAMEHERE"
consumer_key<-"YOURKEYHERE"
consumer_secret<-"YOURSECRETHERE"
access_token<-"YOURACCESSTOKENHERE"
access_token_secret<-"YOURACCESSTOKENSECRETHERE"
create_token(app=app_name, consumer_key=consumer_key, consumer_secret=consumer_secret)

## search tweets
tweets=search_tweets(q = totalstringloop,
              "lang:en",
              geocode=lookup_coords("usa"),
              n = 10000, 
              include_rts = FALSE,
              type = "recent", 
              retryonratelimit = TRUE)

## time series frequency plot
ts_plot(korea_tweets, "3 hours") +
  ggplot2::theme_minimal() +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of Tweets about Korea from the Past Day",
    subtitle = "Twitter status (tweet) counts aggregated using three-hour intervals",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

## map
rtusaloc <- lat_lng(alltweetsdegotslur)
par(mar = c(0, 0, 0, 0))
map("state", lwd = .25)
with(rtusalocwhite, points(lng, lat, pch = 20, cex = .75, col = "blue"))
with(rtusalocblack, points(lng, lat, pch = 20, cex = .75, col = "black"))
with(rtusalocjewish, points(lng, lat, pch = 20, cex = .75, col = "orange"))
with(rtusalocasian, points(lng, lat, pch = 20, cex = .75, col = "red"))
with(rtusalochispan, points(lng, lat, pch = 20, cex = .75, col = "purple"))
legend("bottomright",legend=c("White", "Jewish", "Asian", "Black", "Hispanic"),
       col=c("blue", "orange","red","black", "purple"), pch=20, cex=0.75)
title(main="Location Distribution of Tweets of Top 3 Racial Slurs for 5 Races")

## get someone's timeline and profile and tweets he liked and his followers
sanders_tweets <- get_timelines(c("sensanders"), n = 5)
sanders_twitter_profile <- lookup_users("sensanders")
sanders_favorites<-get_favorites("sensanders", n=5)
sanders_follows<-get_followers("sensanders")

## get trending topics
get_trends("New York")

## check rate limit
rate_limits<-rate_limit()

########################################################
#                                                      #
#           web scraping                               #
#                                                      #
########################################################

# method 1: parsing using xpath
## read html
wikipedia_page<-read_html("https://en.wikipedia.org/wiki/World_Health_Organization_ranking_of_health_systems_in_2000")
## use developer tools in browser to find xpath of the part you want to scrape and get node and pointer 
section_of_wikipedia<-html_node(wikipedia_page, xpath='//*[@id="mw-content-text"]/div/table')
## convert node into table
health_rankings<-html_table(section_of_wikipedia)

# method 2: parsing using CSS selector
duke_page<-read_html("https://www.duke.edu")
## get node and pointer
duke_events<-html_nodes(duke_page, css="li:nth-child(1) .epsilon")
## convert to text
html_text(duke_events)

# method 3: selenium when you want to have interaction with browser such as key in things and search automatically

########################################################
#                                                      #
#           Basic Text Analysis - Tokenization         #
#                                                      #
########################################################

# corpus (not tokenized)
trump_corpus <- Corpus(VectorSource(as.vector(trumptweets$text))) 
## remove stopwords (can define language whereas tidytext can't)
trump_corpus <- tm_map(trump_corpus, removeWords, stopwords("english"))
## remove punctuation
trump_corpus <- tm_map(trump_corpus, content_transformer(removePunctuation))
## remove numbers
trump_corpus <- tm_map(trump_corpus, content_transformer(removeNumbers))
## move to lower cases
trump_corpus <- tm_map(trump_corpus,  content_transformer(tolower)) 
## remove white spaces
trump_corpus <- tm_map(trump_corpus, content_transformer(stripWhitespace))
## stemming (again can choose language but tidytext can't)
trump_corpus  <- tm_map(trump_corpus, content_transformer(stemDocument), language = "english")

# tidytext
## tokenize
tidy_trump_tweets<- trumptweets %>%
  select(created_at,text) %>%
  unnest_tokens("word", text)
## word count
tidy_trump_tweets %>%
  count(word) %>%
  arrange(desc(n))
## remove stopwords
data("stop_words")
tidy_trump_tweets<-tidy_trump_tweets %>%
  anti_join(stop_words)
## remove numbers
tidy_trump_tweets<-tidy_trump_tweets[-grep("\\b\\d+\\b", tidy_trump_tweets$word),]
## all lower cases in tidytext so no need to change case
## remove white spaces
tidy_trump_tweets$word <- gsub("\\s+","",tidy_trump_tweets$word)
## stemming
tidy_trump_tweets<-tidy_trump_tweets %>%
  mutate_at("word", funs(wordStem((.), language="en")))

# document-term matrix
## corpus (inspect doesn't work for tidytext DTM)
trump_DTM <- DocumentTermMatrix(trump_corpus, control = list(wordLengths = c(2, Inf)))
inspect(trump_DTM[1:5,3:8])
## tidytext
tidy_trump_DTM<-
  tidy_trump_tweets %>%
  count(created_at, word) %>%
  cast_dtm(created_at, word, n)

########################################################
#                                                      #
#           Topic Modelling                            #
#                                                      #
########################################################

# Basic Topic Modelling - you have to have a DTM of the dataset first
## run topic modelling (Latent Dirichlet Allocation)
tweet_topic_model_white = LDA(tidy_DTM_white, k=3, control = list(seed = 321))
tweet_topics_white <- tidy(tweet_topic_model_white, matrix = "beta")  
##beta is the probability of each word associating with each topic
## visualization
tweet_top_terms <- 
  tweet_topics_white %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

tweet_top_terms %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip()

# Structural topic modelling
google_doc_id <- "1LcX-JnpGB0lU1iDnXnxB6WFqBywUKpew" # google file ID
poliblogs<-read.csv(sprintf("https://docs.google.com/uc?id=%s&export=download", google_doc_id), stringsAsFactors = FALSE)
## preprocessing
processed <- textProcessor(poliblogs$documents, metadata = poliblogs)
out <- prepDocuments(processed$documents, processed$vocab, processed$meta)
docs <- out$documents
vocab <- out$vocab
meta <-out$meta
## run a structural topic modelling
First_STM <- stm(documents = out$documents, vocab = out$vocab,
                 K = 10, prevalence =~ rating + s(day) ,
                 max.em.its = 75, data = out$meta,
                 init.type = "Spectral", verbose = FALSE)
## plot top words
plot(First_STM)
## find exemplary passages
findThoughts(First_STM, texts = poliblogs$documents,
             n = 2, topics = 3)
## choose k
findingk <- searchK(out$documents, out$vocab, K = c(10, 30),
                    prevalence =~ rating + s(day), data = meta, verbose=FALSE)

plot(findingk)
## work with metadata
predict_topics<-estimateEffect(formula = 1:10 ~ rating + s(day), stmobj = First_STM, metadata = out$meta, uncertainty = "Global")
## plot
plot(predict_topics, covariate = "rating", topics = c(3, 5, 9),
     model = First_STM, method = "difference",
     cov.value1 = "Liberal", cov.value2 = "Conservative",
     xlab = "More Conservative ... More Liberal",
     main = "Effect of Liberal vs. Conservative",
     xlim = c(-.1, .1), labeltype = "custom",
     custom.labels = c('Topic 3', 'Topic 5','Topic 9'))
## plot topic prevalence over time
plot(predict_topics, "day", method = "continuous", topics = 3,
     model = z, printlegend = FALSE, xaxt = "n", xlab = "Time (2008)")
monthseq <- seq(from = as.Date("2008-01-01"),
                to = as.Date("2008-12-01"), by = "month")
monthnames <- months(monthseq)
axis(1,at = as.numeric(monthseq) - min(as.numeric(monthseq)),
     labels = monthnames)

########################################################
#                                                      #
#           Dictionary-based Analysis                  #
#                                                      #
########################################################

# tf-idf: tokenize first and then tf-idf
tidy_trump_tfidf<- trumptweets %>%
  select(created_at,text) %>%
  unnest_tokens("word", text) %>%
  anti_join(stop_words) %>%
  count(word, created_at) %>%
  bind_tf_idf(word, created_at, n)
## rank tf_idf
top_tfidf<-tidy_trump_tfidf %>%
  arrange(desc(tf_idf))
## find top tf_idf words
top_tfidf$word[1]

# detect words in our defined dictionary
economic_dictionary<-c("economy","unemployment","trade","tariffs")
economic_tweets<-trumptweets[str_detect(trumptweets$text, economic_dictionary),]

# sentiment analysis
head(get_sentiments("afinn"))
## tokenize text first and use bing to count the number of positive/negative words in text
trump_tweet_sentiment <- tidy_trump_tweets %>%
  inner_join(get_sentiments("bing")) %>%
  count(created_at, sentiment) 
## visualization
tidy_trump_tweets$date<-as.Date(tidy_trump_tweets$created_at, 
                                format="%Y-%m-%d %x")
## aggregate negative sentiment by day
trump_sentiment_plot <-
  tidy_trump_tweets %>%
  inner_join(get_sentiments("bing")) %>% 
  filter(sentiment=="negative") %>%
  count(date, sentiment)
ggplot(trump_sentiment_plot, aes(x=date, y=n))+
  geom_line(color="red")+
  theme_minimal()+
  ylab("Frequency of Negative Words in Trump's Tweets")+
  xlab("Date")

########################################################
#                                                      #
#           Word Embedding                             #
#                                                      #
########################################################

# skip-gram word embedding
## create context window with length 8
tidy_skipgrams <- elected_no_retweets %>%
  unnest_tokens(ngram, text, token = "ngrams", n = 8) %>%
  mutate(ngramID = row_number()) %>% 
  tidyr::unite(skipgramID, postID, ngramID) %>%
  unnest_tokens(word, ngram)
## calculate unigram probabilities (used to normalize skipgram probabilities later)
unigram_probs <- elected_no_retweets %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) %>%
  mutate(p = n / sum(n))
## calculate probabilities
skipgram_probs <- tidy_skipgrams %>%
  pairwise_count(word, skipgramID, diag = TRUE, sort = TRUE) %>%
  mutate(p = n / sum(n))
## normalize probabilities
normalized_prob <- skipgram_probs %>%
  filter(n > 20) %>%
  rename(word1 = item1, word2 = item2) %>%
  left_join(unigram_probs %>%
              select(word1 = word, p1 = p),
            by = "word1") %>%
  left_join(unigram_probs %>%
              select(word2 = word, p2 = p),
            by = "word2") %>%
  mutate(p_together = p / p1 / p2)
## words that are most likely to occur within a context window of eight words around Trump
normalized_prob %>% 
  filter(word1 == "trump") %>%
  arrange(-p_together)

# put all those wordsin multi-dimension space
pmi_matrix <- normalized_prob %>%
  mutate(pmi = log10(p_together)) %>%
  cast_sparse(word1, word2, pmi)
library(irlba)
#remove missing data
pmi_matrix@x[is.na(pmi_matrix@x)] <- 0
#run SVD
pmi_svd <- irlba(pmi_matrix, 256, maxit = 500)
#next we output the word vectors:
word_vectors <- pmi_svd$u
rownames(word_vectors) <- rownames(pmi_matrix)

# identify synonyms
search_synonyms <- function(word_vectors, selected_vector) {
  similarities <- word_vectors %*% selected_vector %>%
    tidy() %>%
    as_tibble() %>%
    rename(token = .rownames,
           similarity = unrowname.x.)
  similarities %>%
    arrange(-similarity)    
}
## use function
pres_synonym <- search_synonyms(word_vectors,word_vectors["president",])


########################################################
#                                                      #
#           Parsing Sentence                           #
#                                                      #
########################################################

# Part of Speech Tagging (not too accurate with Twitter)
## Penn Tree Bank is a dictionary that matches all words to their tags such as noun, adj
#cnlp_download_udpipe()
cnlp_init_udpipe()
## don't have to tokenize first. This will return you the tag of each element in text
annotation <- cnlp_annotate(elected_official_tweets$text[1])
pos<-cnlp_get_token(annotation)
head(pos, 10)

# sentence parsing
## this returns you tag of each word with reference of its function and context in sentence
dependency<-cnlp_get_dependency(annotation)

# named entity recognition
## need to use java thus terminal
##sudo R CMD javareconf
cnlp_download_corenlp()
cnlp_init_corenlp()
annotation <- cnlp_annotate(elected_official_tweets$text[1])
entitities<-cnlp_get_entity(annotation)
entitities

########################################################
#                                                      #
#           Text Network                               #
#                                                      #
########################################################

## word_race is combined tokenized toxic tweets
## this command is to remove tokenized words that are not in the top list we want to analyze
text                   <- word_race %>% filter (word_race$word%in%total_top2$word)
## plot connection of words. If want to plot sourrces, change node_type
prepped                <- PrepText(text, groupvar = "racelabel", 
                                   textvar = "word", 
                                   node_type = "words", 
                                   tokenizer = "words", 
                                   pos = "nouns", 
                                   remove_stop_words = TRUE, 
                                   compound_nouns = FALSE)

text_network           <- CreateTextnet(prepped)

## visualize the Text network in 3D

VisTextNet(text_network, label_degree_cut = 0, alpha = 1)
vis                   <- VisTextNetD3(text_network)

top_words_modularity_classes <- InterpretText(text_network, prepped)
head(top_words_modularity_classes)

textnet               <- read.csv("~/Desktop/textnet.csv", comment.char="#")
textnet_grouped       <- textnet %>% 
  group_by(screen_name)

prepped_people        <- PrepText(textnet_grouped, 
                                  groupvar = "screen_name", 
                                  textvar = "text", 
                                  node_type = "groups", 
                                  tokenizer = "words", 
                                  pos = "nouns", 
                                  remove_stop_words = TRUE, 
                                  compound_nouns = TRUE)

text_network_people   <- CreateTextnet(prepped_people)
VisTextNet(text_network_people, label_degree_cut = 0, alpha = 1)

top_words_modularity_classes <- InterpretText(text_network_people, prepped_people)
head(top_words_modularity_classes)

text_centrality       <- TextCentrality(text_network_people)


