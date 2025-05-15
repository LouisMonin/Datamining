# Exercise 1: Precipitation of French Cities

# Load the dataset FrenchCities
Dataset <- read.table("FrenchCities.csv", header = TRUE, sep = ';', row.names = 1)

# Center and scale the variables (exclude the first column which is qualitative)
Scaled.Data <- Dataset
Scaled.Data[,-1] <- scale(Dataset[,-1])  # Standardize the variables (centering and scaling)
Scaled.Data <- as.data.frame(Scaled.Data)  # Convert to data frame after modification

# Compute the Euclidean distance matrix between observations
d <- dist(Scaled.Data, method = "euclidean")

# Perform hierarchical clustering with Ward's D2 method
res <- hclust(d, method = "ward.D2")

# Display the dendrogram to visualize the clusters
plot(res)

# Display the fusion heights for each iteration
plot(res$height)

# Choose the number of clusters, for example, k = 3
groupes1 <- cutree(res, k = 3)  # Replace 3 with the desired number of clusters

# Load the necessary libraries for PCA and exploration
install.packages("FactoMineR")
library("FactoMineR")
library("explor")

# Perform PCA on the centered and scaled data (excluding the "CLIMAT" column)
res.PCA <- PCA(Scaled.Data[,-1])

# Visualize the PCA results
explor(res.PCA)

# Retrieve the coordinates of cities on the first 2 principal components
Scaled.Data2 <- scale(res.PCA$ind$coord[, 1:2])  # Keep only the first 2 components

# Compute the Euclidean distance matrix on the new coordinates
d2 <- dist(Scaled.Data2, method = "euclidean")

# Perform hierarchical clustering with Ward's D2 method on the new coordinates
res2 <- hclust(d2, method = "ward.D2")

# Display the dendrogram to see clusters on the new coordinates
plot(res2)
plot(res2$height)

# Choose the number of clusters, for example, k = 3
groupes2 <- cutree(res2, k = 3)  # Replace 3 with the optimal number of clusters

# Plot the clusters before dimensionality reduction (using PCA coordinates)
X11()  # Open a graphic window on Windows or Linux
plot(res.PCA$ind$coord[, 1], res.PCA$ind$coord[, 2], col = groupes1, main = "Before Reduction")
text(res.PCA$ind$coord[, 1], res.PCA$ind$coord[, 2], row.names(Scaled.Data), col = groupes1)

# Plot the clusters after dimensionality reduction (with the first 2 PCA components)
X11()
plot(res.PCA$ind$coord[, 1], res.PCA$ind$coord[, 2], col = groupes2, main = "After Reduction")
text(res.PCA$ind$coord[, 1], res.PCA$ind$coord[, 2], row.names(Scaled.Data), col = groupes2)

# Add the cluster column (groupes2) to the dataset
Scaled.Data <- cbind(Scaled.Data, groupes2)
Scaled.Data <- as.data.frame(Scaled.Data)
Scaled.Data$groupes2 <- as.factor(Scaled.Data$groupes2)

# Perform a new PCA with the last column (clusters) as an additional qualitative variable
res.PCA <- PCA(Scaled.Data[,-1], quali.sup = 34)

# Visualize the results of the PCA after adding the clusters
explor(res.PCA)

# Cross-tabulate the climate variable with the clusters
table(Scaled.Data$CLIMAT, groupes2)  # Cross-tabulation between climate and clusters


# Exercise 2: French Cheeses

# Load the dataset for cheeses (adjust the file path if needed)
Fromages <- read.table("fromages.txt", header = TRUE, sep = ';', row.names = 1)

# Center and scale the variables
Scaled.Fromages <- Fromages
Scaled.Fromages[,-1] <- scale(Fromages[,-1])  # Exclude the first column if it is qualitative
Scaled.Fromages <- as.data.frame(Scaled.Fromages)  # Convert to data.frame

# Compute the Euclidean distance matrix on the cheese data
d_fromages <- dist(Scaled.Fromages, method = "euclidean")

# Perform hierarchical clustering with Ward's D2 method on the cheese data
res_fromages <- hclust(d_fromages, method = "ward.D2")

# Display the dendrogram for the cheeses
plot(res_fromages)

# Choose the number of clusters, for example, k = 3
groupes_fromages <- cutree(res_fromages, k = 3)  # Replace 3 with the desired number of clusters

# Perform PCA on the cheese data
res.PCA_fromages <- PCA(Scaled.Fromages[,-1])

# Visualize the PCA results
explor(res.PCA_fromages)

# Retrieve the coordinates of the cheeses on the first 2 principal components
Scaled.Fromages2 <- scale(res.PCA_fromages$ind$coord[, 1:2])  # Keep only the first 2 components

# Compute the Euclidean distance matrix on the new coordinates
d_fromages2 <- dist(Scaled.Fromages2, method = "euclidean")

# Perform hierarchical clustering on the new coordinates
res_fromages2 <- hclust(d_fromages2, method = "ward.D2")

# Display the dendrogram for the new clustering
plot(res_fromages2)

# Choose the number of clusters, for example, k = 3
groupes_fromages2 <- cutree(res_fromages2, k = 3)

# Plot the clusters before dimensionality reduction
X11()  # Open a graphic window under Windows or Linux
plot(res.PCA_fromages$ind$coord[, 1], res.PCA_fromages$ind$coord[, 2], col = groupes_fromages, main = "Before Reduction")
text(res.PCA_fromages$ind$coord[, 1], res.PCA_fromages$ind$coord[, 2], row.names(Scaled.Fromages), col = groupes_fromages)

# Plot the clusters after dimensionality reduction (with the first 2 PCA components)
X11()
plot(res.PCA_fromages$ind$coord[, 1], res.PCA_fromages$ind$coord[, 2], col = groupes_fromages2, main = "After Reduction")
text(res.PCA_fromages$ind$coord[, 1], res.PCA_fromages$ind$coord[, 2], row.names(Scaled.Fromages), col = groupes_fromages2)
