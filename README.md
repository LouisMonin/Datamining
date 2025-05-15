# Datamining
Study of clustering algorithms

Decision Trees and Random Forests for Classification
Overview

This repository demonstrates the application of Decision Trees (CART) and Random Forests for classification tasks using the IRIS dataset and PimaIndiansDiabetes dataset. The primary focus is on building, tuning, and evaluating machine learning models to classify species in the IRIS dataset and predict diabetes outcomes in the Pima Indians dataset.
Datasets

    IRIS Dataset:

        This well-known dataset contains 150 observations of iris flowers, with four features: Sepal.Length, Sepal.Width, Petal.Length, and Petal.Width. The task is to classify the flowers into one of three species: setosa, versicolor, or virginica.

    PimaIndiansDiabetes Dataset:

        This dataset includes data about diabetes for 768 women of Pima Indian heritage. The features include Pregnancies, Glucose, BloodPressure, SkinThickness, Insulin, BMI, DiabetesPedigreeFunction, Age, and the target variable Outcome (whether or not the patient has diabetes).

Key Concepts

    Decision Trees (CART):

        Classification and Regression Trees (CART) are used to create a model where the data is split into subsets based on the feature values. The splits are made recursively to generate a tree structure.

        The CART algorithm is implemented using the rpart library in R.

    Random Forests:

        Random Forest is an ensemble learning technique that creates multiple decision trees and combines them to make a final prediction. It is particularly robust to overfitting.

        The Random Forest algorithm is applied using the randomForest library in R.

Workflow

    Data Exploration:

        Basic exploration of the datasets using functions like dim(), names(), str(), and attributes() to understand their structure and features.

    Data Splitting:

        The dataset is randomly split into training (70%) and testing (30%) sets to evaluate model performance.

    Model Building:

        Decision Tree (CART):

            The decision tree model is built using the rpart() function, which applies the CART algorithm. The model is tuned using the cp (complexity parameter) to control tree pruning.

        Random Forest:

            The Random Forest model is built using the randomForest() function, with hyperparameters such as ntree (number of trees) and mtry (number of variables to consider at each split) being adjusted.

    Model Evaluation:

        The models are evaluated using confusion matrices, and predictions are made on both the training and test datasets.

        The performance of the models is compared using metrics such as accuracy and variable importance.

    Parameter Tuning:

        The complexity parameter cp of the decision tree is adjusted to control tree depth and avoid overfitting.

        In Random Forests, parameters like ntree and mtry are varied to optimize the model.

    Visualization:

        Decision Tree: The tree structure is visualized using rpart.plot to understand how the model splits the data.

        Random Forest: Variable importance is plotted using varImpPlot to identify the most important features for prediction.

Exercises

    Exercise 1: Adjusting the Decision Tree Complexity:

        Adjust the cp parameter of the decision tree model and visualize the error as a function of cp using plotcp().

        Rebuild the decision tree with the new cp value.

    Exercise 2: Model Evaluation:

        Apply the custom evaluator function (referenced in a previous tutorial) to evaluate model performance on the test set.

    Exercise 3: Tuning Random Forest Parameters:

        Vary the ntree (number of trees) and mtry (number of variables to consider) parameters of the Random Forest model.

        Compare the results on the test set.

    Exercise 4: Apply Models on PimaIndiansDiabetes Dataset:

        Repeat the process for the PimaIndiansDiabetes dataset from the mlbench library. Build decision trees and Random Forests and evaluate their performance.

Requirements

    R: Version 3.x or higher.

    Required R packages:

        rpart

        rpart.plot

        randomForest

        mlbench

        FactoMineR (for PCA)

        explor (for PCA visualization)
