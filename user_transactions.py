import pandas as pd
import warnings
warnings.filterwarnings("ignore")


# Function to read the CSV file into a DataFrame
def read_csv():
    # read the user_transactions.csv file using pandas library and return it
    df = pd.read_csv('user_transactions.csv')
    return df


# Function to check for null (missing) values in the DataFrame
def check_null_values():
    # do not edit the predefined function name
    df = read_csv()
    # Check for null values using the isnull() method and sum them for each column

    df=df.isnull().sum()
    return df
# Function to check for duplicate rows in the DataFrame
def check_duplicates():
    # do not edit the predefined function name
    df = read_csv()
    # Calculate the number of duplicate rows using the duplicated() method and sum them
    duplicates = None
    df = df.duplicated().sum()
    return df


# Function to drop duplicate rows from the DataFrame
def drop_duplicates():
    # do not edit the predefined function name
    df = read_csv()
    # Drop duplicate rows using the drop_duplicates() method with inplace=True
    df.drop_duplicates(inplace=True)
    return df

    return df


def data_cleaning():
    """
    Data Cleaning Function:
    Cleans the DataFrame by dropping specified columns and renaming others.

    Returns:
    DataFrame: The cleaned DataFrame after dropping and renaming columns.
    """
    # Step 1: Get the DataFrame with duplicate rows removed and rows with null values dropped
    df = drop_duplicates()

    # Step 2: Columns to remove from the DataFrame
    #columns needs to be removed "has_credit_card" and  "account_type"
    # Drop specified columns from the DataFrame
    df.drop(columns=['has_credit_card', 'account_type'], inplace=True)
    #Rename columns id_,t_date,t_type,t_amt to consumer_id,transaction_date,transaction_type,transaction_amount
     

    # Step 5: Rename columns using the new column names
    df=df.rename(columns={'id_':'consumer_id', 't_date':'transaction_date', 't_type' :'transaction_type', 't_amt':'transaction_amount'}) 
    df.to_csv('user_transaction_cleaned.csv', encoding='utf-8', index=False) 
    #df.to_csv('user_transaction_cleaned.csv', index=False)
    return df


