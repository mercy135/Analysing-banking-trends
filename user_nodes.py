import pandas as pd
import warnings
warnings.filterwarnings("ignore")


# Function to read the CSV file into a DataFrame
def read_csv():
    # read the user_nodes.csv file using pandas library and return it
    df = pd.read_csv('user_nodes.csv')
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


def data_cleaning():

    df = drop_duplicates()

    # Step 3: Drop specified columns from the DataFrame("has_loan", "is_act")
    df.drop(columns=['has_loan', 'is_act'], inplace=True)
    #Rename columns names id_,area_id_,node_id_,act_date',deact_date to  consumer_id,region_id,node_id,start_date,end_date
    df=df.rename(columns={'id_':'consumer_id', 'area_id_':'region_id', 'node_id_' :'node_id', 'act_date':'start_date','deact_date':'end_date'}) 
    df.to_csv('user_nodes_cleaned.csv', encoding='utf-8', index=False) 
    #df.to_csv('user_nodes_cleaned.csv', index=False)
    return df
