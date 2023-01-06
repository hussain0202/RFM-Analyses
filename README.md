# Customer Segmentation & RFM Analysis
Implementing the customer segmentation on the business' data using RFM analysis with R and making inferences about the best, loyal, potential, and churned out customers for the business.

In this age of competition, it is very important for the businesses to understand their customers.If businesses can divide the customers into different groups, they can understand the needs of their customers better.
Segmentation could be done on the basis of purchasing behaviour, recurrence of orders and others.

In this, we will work on the step by step method to perform analysis for customer segmentation in R. RFM analysis segment the customers based on 3 factors
-Recency(How recently has the customer shopped in the store)
-Frequency(How frequently does the customer shops at the store)
-Monetary(How much money has a customer spent in that store).
- Read the data into a data frame. The data for this analysis has been taken from Kaggle. The data is of sales held in USA. We first read the data into a data frame and read it’s summary statistics to understand the data better.
- Data cleaning and preprocessing

After Looking at the summary statistics of the data frame, we can see 2 problems in the data:
- null values
- Invalid data — negative values for quantities.

We have to remove the null values if they exist and also we have to ommit those values which contain negative quantity values. since my data does not contain any of these problems, so i will move to next step.

3- Calculate Recency, Frequency and Monetary values for every customer We now calculate the following values:
* **Recency**   : difference between the analysis date and the most recent date, that the customer has shopped in the store. The analysis date here has been taken as the maximum date available for the variable InvoiceDate.
- **Frequency** : Number of transactions performed by every customer.
- **Monetary**  : Total money spent by every customer in the store.

4- Calculate the RFM score
We can see that all the quantities calculated above— Recency, frequency and monetary has different ranges. We first convert
these quantities to scores based on their quartiles. For this, we can do it by using two methods. Either by manually or using r function cut2. Here I did this manually. For this, we need to start with looking at the summary of these values.

All the values for frequency and monetary in the first quartile are given Fscores and Mscores 1, in 2nd quartile- scores 2, in 3rd quartile scores 3 and in 4rth quartile scores 4.
For recency, as we know that more recent customer will have less recency value than the customer who has not shopped in a while. Therefore for recency, all the values in the 1st quartile are given Rscore 4, 2nd quartile — 3, 3rd quartile 2 and fourth quartile 1.
The variables R_score, F_score and M_score all have values between 1–4 now. We now want to combine the 3 score values into a single score — RFM score. This is done by using mutate function in r.

By using my dataset, we can see that most of the customers(23%) fall into the category of detractors. And only 7.7% are hesitants.
