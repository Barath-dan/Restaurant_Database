# Little Lemon Database Project

## Overview  
The Little Lemon Database Project is designed to streamline the operations of the Little Lemon restaurant, focusing on a robust and efficient table booking system. This project leverages:  
- **Stored Procedures** for efficient database management.  
- **Transactions** for data consistency.  
- **Virtual Tables** for enhanced data visibility.  
- **Streamlit Web Application** for a user-friendly interface.  
- **Cloud Hosting** through **Aiven Cloud Services** for reliability and scalability.  

---

## Features  

### 1. Streamlit Integration  
The project includes a Streamlit-based web application with secure login options for **customers** and **administrators**:  

#### Customer Login Features:  
- **New Customer Registration:** Easy onboarding for new customers.  
- **Check Available Tables:** View table availability for specific dates.  
- **Add New Bookings:** Quickly reserve tables.  
- **Cancel Bookings:** Effortlessly cancel existing reservations.  
- **Update Bookings:** Modify reservation details such as date, time, or party size.  

#### Admin Login Features:  
- **View Menu Table:** Access and manage the restaurant’s menu.  
- **View Staff Table:** Monitor and manage staff details.  
- **Total Booking Details:** Track all bookings, including past and upcoming reservations.  
- **Customer Details:** Access a detailed list of customer profiles.  

---

### 2. Table Booking System  
A comprehensive system for managing reservations, with the following functionalities:  
- **Check Bookings:** Retrieve table booking status for specific dates and tables.  
- **Add Bookings:** Reserve tables for customers.  
- **Update Bookings:** Modify details of existing reservations.  
- **Cancel Bookings:** Efficiently handle reservation cancellations.  

---

### 3. Stored Procedures  
Utilizes MySQL stored procedures to optimize database operations and improve performance:  
- **Add Customers:** Add new customers to the database.  
- **Add Booking:** Insert new table reservations.  
- **Update Booking:** Modify existing bookings.  
- **Cancel Booking:** Remove bookings from the system.  
- **Available Tables:** Check table availability for specific dates.  
- **Check Booking:** Retrieve the booking status for a given date and table.  

---

### 4. Virtual Tables  
Provides summarized views of customer orders and booking details for improved data visibility and analysis.  

---

### 5. Database Client  
A Python-based client for interacting with the database, allowing seamless query execution and data retrieval.  

---

## Technologies Used  
- **Database:** MySQL  
- **Backend:** Python  
- **Frontend:** Streamlit  
- **Cloud Hosting:** Aiven Cloud Services  
- **Version Control:** Git  

---

## Contributing  
Contributions are welcome!  
1. Fork the repository.  
2. Create a new branch for your feature or bug fix.  
3. Submit a pull request with a detailed description of your changes.
