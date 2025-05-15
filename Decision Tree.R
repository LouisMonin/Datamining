# Practical Study with R: Decision Trees (CART and Random Forest)

# 1. Exploring the IRIS dataset

# Load the IRIS dataset
data(iris)

# View characteristics of the dataset
dim(iris)  # Dimensions (number of rows and columns)
names(iris)  # Column names
str(iris)  # Structure of the dataset
attributes(iris)  # Attributes of the dataset

# 2. Splitting the dataset into training and testing sets

# Set seed for reproducibility
set.seed(1234)

# Randomly split the data into training (70%) and testing (30%)
ind <- sample(2, nrow(iris), replace = TRUE, prob = c(0.7, 0.3))
trainData <- iris[ind == 1, ]
testData <- iris[ind == 2, ]

# View the training and testing datasets
trainData
testData

# 3. Building a Decision Tree (CART)

# Define the formula for the decision tree
myFormula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width

# Load the rpart library
library(rpart)

# Fit a decision tree model using the training data
iris_rpart <- rpart(myFormula, data = trainData, control = rpart.control(minsplit = 5))

# Display the model attributes and structure
attributes(iris_rpart)
print(iris_rpart)

# 4. Plotting the decision tree

# Load the rpart.plot library for plotting decision trees
library(rpart.plot)

# Plot the decision tree with extra information on the leaves
prp(iris_rpart, extra = 1)

# 5. Predictions and confusion matrices

# Make predictions on the training data
trainPred <- predict(iris_rpart, newdata = trainData, type = "class")
table(trainPred, trainData$Species)  # Confusion matrix for training set

# Make predictions on the test data
testPred <- predict(iris_rpart, newdata = testData, type = "class")
table(testPred, testData$Species)  # Confusion matrix for test set

# 6. Exercise 1: Adjusting the complexity parameter (cp)

# Display the complexity parameter (cp) of the decision tree
iris_rpart$control$cp

# Plot the error against the complexity parameter to visualize the impact
plotcp(iris_rpart)

# Adjust the complexity parameter cp to 0.2 and rebuild the model
iris_rpart <- rpart(myFormula, data = trainData, control = rpart.control(minsplit = 5, cp = 0.2))

# 7. Exercise 2: Evaluating the model with the evaluator function
# Assuming evaluator function is defined in a previous script or exercise
# evaluator(iris_rpart, testData)  # Uncomment if evaluator function is available

# 8. Building a Random Forest model

# Load the randomForest library
library(randomForest)

# Fit a Random Forest model using the training data
rf <- randomForest(Species ~ ., data = trainData, ntree = 100)

# Display the model and its attributes
print(rf)
attributes(rf)

# 9. Variable importance in Random Forest

# Display the importance of each variable
importance(rf)

# Plot the variable importance
varImpPlot(rf)

# 10. Exercise 3: Varying parameters in Random Forest

# Varying ntree (number of trees) and mtry (number of variables to consider at each node)
rf_vary_params <- randomForest(Species ~ ., data = trainData, ntree = 500, mtry = 2)

# Display the model results
print(rf_vary_params)

# Apply evaluator function to compare the results on the test set
# evaluator(rf_vary_params, testData)  # Uncomment if evaluator function is available

# 11. Exercise 4: Apply the same analysis to the PimaIndiansDiabetes dataset

# Load the mlbench library to access the PimaIndiansDiabetes dataset
library(mlbench)

# Load the PimaIndiansDiabetes dataset
data(PimaIndiansDiabetes)

# Explore the dataset
dim(PimaIndiansDiabetes)  # Dimensions of the dataset
str(PimaIndiansDiabetes)  # Structure of the dataset

# Split the dataset into training and testing sets
set.seed(1234)
ind_pima <- sample(2, nrow(PimaIndiansDiabetes), replace = TRUE, prob = c(0.7, 0.3))
trainData_pima <- PimaIndiansDiabetes[ind_pima == 1, ]
testData_pima <- PimaIndiansDiabetes[ind_pima == 2, ]

# Fit a decision tree model on the Pima dataset
myFormula_pima <- Outcome ~ .  # Use all variables for classification
iris_rpart_pima <- rpart(myFormula_pima, data = trainData_pima, control = rpart.control(minsplit = 5))

# Plot the decision tree for the Pima dataset
prp(iris_rpart_pima, extra = 1)

# Predictions and confusion matrix for Pima dataset
trainPred_pima <- predict(iris_rpart_pima, newdata = trainData_pima, type = "class")
table(trainPred_pima, trainData_pima$Outcome)

testPred_pima <- predict(iris_rpart_pima, newdata = testData_pima, type = "class")
table(testPred_pima, testData_pima$Outcome)

# Fit a Random Forest model on the Pima dataset
rf_pima <- randomForest(Outcome ~ ., data = trainData_pima, ntree = 100)
print(rf_pima)
importance(rf_pima)
varImpPlot(rf_pima)

