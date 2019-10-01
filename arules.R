# install arules package
install.packages("arules")
install.packages("arulesViz")
library(arules)
library(arulesViz)

# load Groceries data
data("Groceries")
# inspect data using inspect() function
# because Groceries is of transactions data type
inspect(head(Groceries))

# read data into transactions type
# tdata <- read.transactions("transactions_data.txt", sep="\t")

# convert dataframe into transactions type
# tData <- as (myDataFrame, "transactions")

# get items most frequently appear in all transactions
# using the eclat() function
frequent_items <- eclat(Groceries)
inspect(head(frequent_items))
# plot top10 items
itemFrequencyPlot(Groceries, topN=10, type="absolute", main="Item Frequency")

# use apriori() function to establishe rules
rules <- apriori(Groceries, 
                 # use parameter argument to specify parameters
                 parameter = list(
                   # minimum support for the rules is 0.001
                   supp = 0.001, 
                   # minimum confidence for the rules is 0.5
                   conf = 0.5))

# sort rules by confidence in decreasing order
inspect(head(rules, by = "confidence"))
rules_conf <- sort(rules, by = "confidence", decreasing = TRUE)
inspect(head(rules_conf))

# sort rules by lift in decreasing order
rules_lift <- sort(rules, by = "lift", decreasing = TRUE)
inspect(head(rules_lift))

# find rules given items
# using the appearance argument
wholemilk_rules <- apriori(Groceries,
                           parameter = list(supp = 0.001, conf = 0.15, minlen = 2),
                           # use appearance argument
                           appearance = list(
                             # get the rhs items
                             default = "rhs",
                             # when lhs is whole milk
                             lhs = "whole milk"
                           ))
inspect(head(wholemilk_rules, by = "confidence"))

# plot top 20 confidence rules
plot(rules_conf[1:20],
     method = "graph",
     control = list(type = "items"))



