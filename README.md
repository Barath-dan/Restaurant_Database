# Little Lemon Restaurant Database

## Overview
The Little Lemon Database Project is designed to manage the operations of the Little Lemon restaurant, focusing on a robust table booking system. This project utilizes stored procedures, transactions, virtual tables for viewing customer orders, and data visualizations through Tableau, providing a comprehensive solution for restaurant management.

## Features
### Table Booking System: 
A user-friendly interface for managing reservations, allowing users to:
- **Check Bookings**: Get Table booking Status
- **Add Bookings**: Reserve tables for customers.
- **Update Bookings**: Modify existing reservations as needed.
- **Cancel Bookings**: Efficiently handle cancellations.
### Stored Procedures:
Efficiently handle complex queries and operations related to table bookings.
Promote code reuse and performance optimization.
Key procedures include:
- **Add Customers**: Adding new Customers into the database.
- **Add Booking**: For inserting new reservations into the database.
- **Update Booking**: For modifying existing bookings.
- **Cancel Booking**: For removing reservations from the system.
- **Available Tables**: Shows Available Tables for selected date.
- **Check Booking**: Chacks Booking status for given date and table number.
- **Transactions**: Commit changes to the database.

### Virtual Tables: 
Summarize and display customer orders for enhanced data visibility and analysis.

### Database Client: 
A Python-based client for interacting with the database and executing queries.

### Tableau Visualization: 
Create interactive dashboards to visualize booking data, customer insights, and sales performance.

## Technologies Used
- **Database**: MySQL
- **Backend**: Python
- **Data Visualization**: Tableau
- **Version Control**: Git

## Contributing
Contributions are welcome! Please fork the repository and submit a pull request for any enhancements, bug fixes, or new features.
