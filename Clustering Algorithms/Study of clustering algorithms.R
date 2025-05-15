# Etude pratique : Clustering avec R

# --------------------------------------------------------------------
# 1. Exploration de l'ensemble des données IRIS
# --------------------------------------------------------------------

# Chargement du dataset iris
data(iris)

# 1.1. Caractéristiques des données
dim(iris)  # Affiche les dimensions de l'ensemble de données
names(iris)  # Affiche les noms des colonnes
str(iris)  # Affiche la structure du dataset
attributes(iris)  # Affiche les attributs de l'objet

# 1.2. Contenu par ligne ou par colonne
iris[1:5,]  # Affiche les 5 premières lignes
head(iris)  # Affiche les premières lignes (par défaut 6 lignes)
tail(iris)  # Affiche les dernières lignes
iris$Sepal.Length[1:10]  # Affiche les 10 premières valeurs de Sepal.Length

# 1.3. Statistiques de base
summary(iris)  # Résumé statistique du dataset
var(iris$Sepal.Length)  # Variance de la variable Sepal.Length
hist(iris$Sepal.Length)  # Histogramme de Sepal.Length

# 1.4. Quantiles
quantile(iris$Sepal.Length)  # Calcul des quantiles
quantile(iris$Sepal.Length, c(0.1, 0.3, 0.65))  # Quantiles spécifiques

# 1.5. Fréquences des espèces
table(iris$Species)  # Table de fréquence pour la variable Species
pie(table(iris$Species))  # Diagramme circulaire de la fréquence de Species

# 1.6. Visualisations
# Densité de Sepal.Length
plot(density(iris$Sepal.Length))

# Barplot des fréquences de Species
barplot(table(iris$Species))

# Boxplot de Sepal.Length par Species
boxplot(Sepal.Length ~ Species, data = iris)

# Scatter plot de Sepal.Length et Sepal.Width par espèce
with(iris, plot(Sepal.Length, Sepal.Width, col = Species, pch = as.numeric(Species)))

# 3D scatter plot de Petal.Width, Sepal.Length et Sepal.Width
library(scatterplot3d)
scatterplot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width)

# Parallel coordinates plot
library(MASS)
parcoord(iris[1:4], col = iris$Species)

# --------------------------------------------------------------------
# Exercice 1 : Etude du Clustering
# --------------------------------------------------------------------

# 1. Appliquer l'algorithme K-means avec k=7
iris2 <- iris
iris2$Species <- NULL  # Suppression de la colonne Species pour le clustering
(kmeans.result <- kmeans(iris2, 7))  # Application de K-means avec 7 clusters

# 2. Attributs du modèle K-means
kmeans.result$centers  # Les centres des clusters
kmeans.result$cluster  # Les clusters assignés
kmeans.result$totss  # Somme totale des carrés
kmeans.result$withinss  # Somme des carrés à l'intérieur des clusters
kmeans.result$tot.withinss  # Somme des carrés à l'intérieur de tous les clusters
kmeans.result$betweenss  # Somme des carrés entre les clusters
kmeans.result$size  # Taille des clusters

# 3. Matrice de correspondance entre les classes réelles et les clusters
table(iris$Species, kmeans.result$cluster)

# 4. Visualisation des résultats
# Représentation graphique des clusters
plot(iris2[c("Sepal.Length", "Sepal.Width")], col = kmeans.result$cluster)

# Afficher les centres des clusters
points(kmeans.result$centers[,c("Sepal.Length", "Sepal.Width")],
       col = 1:7, pch = 8, cex = 2)

# 5. Appliquer la méthode de classification hiérarchique ascendant sur 40 exemples
set.seed(42)  # Fixer la graine pour la reproductibilité
idx <- sample(1:dim(iris)[1], 40)  # Sélectionner 40 observations
irisSample <- iris[idx,]  # Créer un sous-ensemble
irisSample$Species <- NULL  # Supprimer la colonne Species

# Appliquer l'algorithme de classification hiérarchique
hc <- hclust(dist(irisSample), method = "ave")  # Méthode de distance moyenne

# 6. Visualisation du dendrogramme
plot(hc, labels = iris$Species[idx])  # Afficher le dendrogramme avec les étiquettes

# Ajouter une coupure pour 3 clusters
rect.hclust(hc, k = 3)

# Récupérer les groupes de clusters
groups <- cutree(hc, k = 3)

# --------------------------------------------------------------------
# Exercice 2 : Clustering sur le dataset PimaIndiansDiabetes
# --------------------------------------------------------------------

# 1. Charger le dataset PimaIndiansDiabetes de la librairie mlbench
install.packages("mlbench")
library(mlbench)
data(PimaIndiansDiabetes)

# Exploration rapide des données
dim(PimaIndiansDiabetes)  # Dimensions du dataset
str(PimaIndiansDiabetes)  # Structure des données

# 2. Appliquer K-means avec k = 3
pimaData <- PimaIndiansDiabetes
pimaData$Outcome <- NULL  # Supprimer la colonne Outcome pour le clustering
(kmeans.result.pima <- kmeans(pimaData, 3))  # Application de K-means avec 3 clusters

# Visualisation des résultats
plot(pimaData[c("Glucose", "BMI")], col = kmeans.result.pima$cluster)

# 3. Appliquer la méthode de classification hiérarchique sur PimaIndiansDiabetes
hc.pima <- hclust(dist(pimaData), method = "ave")  # Méthode de distance moyenne

# Visualisation du dendrogramme
plot(hc.pima)

# Ajouter une coupure pour 3 clusters
rect.hclust(hc.pima, k = 3)

# Récupérer les groupes de clusters
groups.pima <- cutree(hc.pima, k = 3)

# --------------------------------------------------------------------
# Résumé des consignes et explications
# --------------------------------------------------------------------

# 1. L'objectif de cette étude pratique est d'appliquer les algorithmes de clustering
#    (K-means et classification hiérarchique) sur les datasets Iris et PimaIndiansDiabetes
#    pour découvrir des groupes de données similaires en fonction des caractéristiques.
# 
# 2. Vous devez suivre les étapes d'exploration des données en utilisant des fonctions comme
#    `summary()`, `hist()`, `plot()`, etc., pour mieux comprendre les caractéristiques des données.
# 
# 3. Appliquez l'algorithme de clustering K-means avec différents nombres de clusters (k=7 pour Iris,
#    k=3 pour PimaIndiansDiabetes) et analysez les résultats.
# 
# 4. Ensuite, appliquez la classification hiérarchique pour observer la structure des données et
#    visualisez les dendrogrammes.
# 
# 5. Comparez les résultats du clustering en termes de qualité et d'interprétation des groupes.

