## ---- eval=FALSE---------------------------------------------------------
#  install.packages("NetworkInference")

## ---- eval=FALSE---------------------------------------------------------
#  #install.packages(devtools)
#  devtools::install_github('desmarais-lab/NetworkInference')

## ---- results='hide', message=FALSE--------------------------------------
library(NetworkInference)

# Simulate random cascade data
df <- simulate_rnd_cascades(50, n_node = 20)
node_names <- unique(df$node_name)

# Cast data into `cascades` object
## From long format
cascades <- as_cascade_long(df, node_names = node_names)

## From wide format
df_matrix <- as.matrix(cascades) ### Create example matrix
cascades <- as_cascade_wide(df_matrix, node_names = node_names)

## ------------------------------------------------------------------------
result <- netinf(cascades, trans_mod = "exponential", lambda = 1, n_edges = 5)

## ---- eval=FALSE---------------------------------------------------------
#  print(result)

## ---- results="asis", echo=FALSE-----------------------------------------
pander::pandoc.table(result)

## ---- message=FALSE------------------------------------------------------
library(NetworkInference)
# Load the `policies` dataset (?policies for details).
data(policies)
state_names <- rownames(policies)

## ---- eval=FALSE---------------------------------------------------------
#  policies[1:7, 1:7]

## ---- results="asis", echo=FALSE-----------------------------------------
pander::pandoc.table(head(policies[1:7, 1:7]))

## ------------------------------------------------------------------------
policy_cascades <- as_cascade_wide(policies, node_names = state_names)

## ------------------------------------------------------------------------
summary(policy_cascades)

## ---- fig.align='center', fig.width=7, fig.height=4----------------------
cascade_ids <- colnames(policies)
selection <- cascade_ids[c(16, 186)]
plot(policy_cascades, label_nodes = TRUE, selection = selection)

## ---- fig.align='center', fig.width=7, fig.height=4----------------------
selection <- cascade_ids[5:15]
plot(policy_cascades, label_nodes = FALSE, selection = selection)

## ------------------------------------------------------------------------
npe <- count_possible_edges(cascades)
npe

## ------------------------------------------------------------------------
results <- netinf(policy_cascades, trans_mod = "exponential", n_edges = 100, 
                  lambda = 1)

## ---- eval=FALSE, echo=TRUE----------------------------------------------
#  head(results)

## ---- results = "asis", echo=FALSE---------------------------------------
pander::pandoc.table(head(results))

## ---- fig.align='center', fig.width=7, fig.height=4----------------------
plot(results, type = "improvement")

## ------------------------------------------------------------------------
diffusion_network <- netinf(policy_cascades, trans_mod = "exponential", 
                            n_edges = 25, lambda = 1)

## ---- fig.width=7, fig.height=5.5----------------------------------------
#install.packages('igraph')
# For this functionality the igraph package has to be installed
# This code is only executed if the package is found:
if(requireNamespace("igraph", quietly = TRUE)) {
    plot(diffusion_network, type = "network")
}

## ---- message=FALSE, eval=FALSE------------------------------------------
#  if(requireNamespace("igraph", quietly = TRUE)) {
#      library(igraph)
#      g <- graph_from_data_frame(d = results[, 1:2])
#      plot(g, edge.arrow.size=.3, vertex.color = "grey70")
#  }

