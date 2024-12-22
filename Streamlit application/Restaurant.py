import streamlit as st
import pymysql
import pandas as pd
# Database connection
@st.cache_resource
def init_connection():
    return pymysql.connect(
        host=st.secrets['database']['host'],
        user=st.secrets['database']['user'],
        password=st.secrets['database']['password'],
        database=st.secrets['database']['db_name'],
        port = st.secrets['database']['port']
    )
 
conn = init_connection()

# Function to execute stored procedures
def execute_stored_procedure(proc_name, params):
    with conn.cursor() as cursor:
        cursor.callproc(proc_name, params)
        results = []
        for result in cursor:
            results.append(result)
        conn.commit()
        return results

def execute_standard_query(query):
    cursor = conn.cursor()
    try:
        cursor.execute(query)
        result = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]
        return result, columns
    finally:
        cursor.close()

# Streamlit App Layout
image_url = "https://raw.githubusercontent.com/Barath-dan/Restaurant_Database/main/assets/golden-cutlery-with-textile-plate-dark-background-top-view.jpg"
st.markdown(
    f"""
    <style>
        .stApp {{
            background-image: url("{image_url}");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
        }}
    </style>
    """, unsafe_allow_html=True
)
Admin_options=["View Menu","Staff Details","View Bookings","View Customer Data"]
Customer_options = ["New Customer Registration", "Add Booking", "Check Available Tables","Update My Booking", "Cancel My Booking", "Admin Login"]
choice = st.sidebar.radio("Menu", ["🏠Home Page","👤Customer Login","🔒Admin Login"])

if choice == "🏠Home Page":
    st.title("Restaurant Table Booking System")
    st.subheader("Welcome to the Restaurant Table Booking Application")
    st.write("Use the sidebar to navigate.")
    st.subheader("Tips to use this app:")
    st.markdown(
    """
    - 🆕**New Customers**: Please create your customer ID before proceeding to book a table. Your customer ID is required to access all functionalities of this app. 🪪
    - 🔒**Booking Limitations**: We can accommodate only **10 guests per day**.🕒
    - 🍽️**Tables Availability**: Currently, there are **10 tables** available. Stay tuned as we expand in the future!🚀✨
    - 🔐**Admin Password**: (500×2)+200+(10×3)+4?🤔
    """
    )
elif choice == "👤Customer Login":

    st.title("Restaurant Table Booking System")
    st.subheader("Dear customer, we are excited to serve you!!!!!")
    Choice=st.sidebar.radio("Select an Option",Customer_options)
    if Choice == "Add Booking":
        st.subheader("Add a New Booking")
        with st.form("add_booking_form"):
            booking_date = st.date_input("Booking Date")
            table_number = st.number_input("Table Number", min_value=1,max_value=10, step=1)
            customer_id = st.number_input("Customer ID", min_value=1, step=1)
            submit = st.form_submit_button("Add Booking")

            if submit:
                try:
                    # Call the stored procedure
                    result = execute_stored_procedure("AddBooking", (booking_date, table_number, customer_id))

                    # Assume the first row contains the status message
                    if result:
                        message = result[0][0]  # Fetch the message from the first row
                        if "added" in message.lower():
                            st.success(message) # Show in green
                        else:
                            st.error(message)  # Show in red for errors
                    else:
                        st.error("No response from the database.")
                except Exception as e:
                    st.error(f"Error: {e}")

    elif Choice == "Check Available Tables":
        st.subheader("Check Available Tables")
        with st.form("available_tables_form"):
            booking_date = st.date_input("Booking Date")
            submit = st.form_submit_button("Check Availability")

            if submit:
                try:
                    result = execute_stored_procedure("Available_Tables", (booking_date,))
                    if result:
                        # Specify column names matching the output of your procedure
                        columns = ["Available_Tables"]
                        df = pd.DataFrame(result, columns=columns)
                        
                        st.write("Available Tables:")
                        st.dataframe(df)  # Display as an interactive table
                    else:
                        st.warning("No tables are available for the selected date.")
                except Exception as e:
                    st.error(f"Error: {e}")

    elif Choice == "Cancel My Booking":
        st.subheader("Cancel a Booking")
        with st.form("cancel_booking_form"):
            booking_date = st.date_input("Booking Date")
            customer_id = st.number_input("Customer ID", min_value=1, step=1)
            submit = st.form_submit_button("Cancel Booking")

            if submit:
                try:
                    result = execute_stored_procedure("Cancel_Booking", (customer_id,booking_date))
                    if result:
                        message = result[0][0]  # Fetch the message from the first row
                        if "cancelled" in message.lower():
                            st.success(message)  # Show in green
                        else:
                            st.error(message)  # Show in red for errors
                    else:
                        st.error("No response from the database.")
                except Exception as e:
                    st.error(f"Error: {e}")

    elif Choice == "New Customer Registration":
        st.subheader("Please enter your details")
        with st.form("add_customer_form"):
            first_name = st.text_input("First Name")
            last_name = st.text_input("Last Name")
            age = st.number_input("Age", min_value=0, step=1)
            mobile_number = st.number_input("Mobile Number", min_value=0, max_value=999999999)
            email = st.text_input("Email")
            submit = st.form_submit_button("Add Customer")
            mobile_number_str = str(mobile_number)
            if len(mobile_number_str) != 9:
                st.error("Mobile Number must have exactly 9 digits.")
            # Check if mobile_number is not provided (i.e., None or empty)
            if not mobile_number:
                st.error("Mobile Number is required.")
            elif submit:
                try:
                    # Execute stored procedure to add a new customer
                    result = execute_stored_procedure("AddNewCustomer", (first_name, last_name, age, mobile_number, email))
                    if result:
                        if len(result[0]) == 2:  # New customer created
                            new_customer_id, message = result[0]
                            st.success(f"{message}. Your Customer ID is: {new_customer_id}")
                        elif len(result[0]) == 1:  # Customer already exists
                            message = result[0][0]
                            st.error(message)
                        else:
                            st.error("Unexpected database response.")
                    else:
                        st.error("No response from the database.")
                except Exception as e:
                    st.error(f"Error: {e}")

    elif Choice == "Check Available Tables":
        st.subheader("Check Available Tables")
        with st.form("available_tables_form"):
            booking_date = st.date_input("Booking Date")
            submit = st.form_submit_button("Check Availability")

            if submit:
                try:
                    result = execute_stored_procedure("Available_Tables", (booking_date,))
                    if result:
                        # Specify column names matching the output of your procedure
                        columns = ["Available_Tables"]
                        df = pd.DataFrame(result, columns=columns)
                        
                        st.write("Available Tables:")
                        st.dataframe(df)  # Display as an interactive table
                    else:
                        st.warning("No tables are available for the selected date.")
                except Exception as e:
                    st.error(f"Error: {e}")

    elif Choice == "Update My Booking":
        st.subheader("Update your Booking")
        with st.form("update_booking_form"):
            old_date=st.date_input("Enter your previous booking date")
            new_booking_date = st.date_input("Enter your New Booking Date")
            customer_id = st.number_input("Customer ID",min_value=1)
            table_num=st.number_input("Enter the table number", min_value=1,max_value=10,step=1)
            submit = st.form_submit_button("Update my Booking")

            if submit:
                try:
                    result = execute_stored_procedure("Update_Booking", (old_date,new_booking_date,customer_id,table_num))
                    if result:
                        message = result[0][0]  # Fetch the message from the first row
                        if "updated" in message.lower():
                            st.success(message)  # Show in green
                        else:
                            st.error(message)  # Show in red for errors
                    else:
                        st.error("No response from the database.")
                except Exception as e:
                    st.error(f"Error: {e}")

elif choice=="🔒Admin Login":
    admin_password=st.sidebar.number_input("Enter Admin password",min_value=0)
    if admin_password==1234:
        A_choice=st.sidebar.radio("Choose an option",Admin_options)
#"View Menu","Staff Details","View Bookings","View Customer Data","View Total Orders","View Order status"
        if A_choice=="View Menu":
            st.header("Menu Items")
            query = "SELECT * FROM menu"
            q_res,columns = execute_standard_query(query)
            df = pd.DataFrame(q_res, columns=columns)
            st.write(df)
        elif A_choice=="Staff Details":
            st.header("Staff Details")
            query = "SELECT * FROM staff"
            q_res,columns = execute_standard_query(query)
            df = pd.DataFrame(q_res, columns=columns)
            st.write(df)
        elif A_choice=="View Bookings":
            st.header("Bookings Data")
            query = "SELECT * FROM bookings"
            q_res,columns = execute_standard_query(query)
            df = pd.DataFrame(q_res, columns=columns)
            st.write(df)
        elif A_choice=="View Customer Data":
            st.header("Customer Data")
            query = "SELECT * FROM customer"
            q_res,columns = execute_standard_query(query)
            df = pd.DataFrame(q_res, columns=columns)
            st.write(df)
    else:
        st.sidebar.write("Wrong Password")
else:
    st.sidebar.write("Select a valid option")


    
