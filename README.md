Database description: 
 
The hotel booking system involves various entities and their interrelationships. the system includes hotels 
where each hotel has a unique id, name, location, contact number, and rating, and must have one or more 
associated rooms, each room identified by a unique id, room number, type, price per night, and availability 
status, and each room belongs to exactly one hotel. guests have personal details like id, name, contact, id proof 
information, and may have zero or more bookings, each booking associated with exactly one room and have 
attributes like booking date, check-in and check-out dates, status, and total cost. each booking can be linked to 
zero or more payments, where each payment is uniquely identified, recorded with a date, amount, and method, 
reflecting a one-to-many relationship, highlighting that while a booking may or may not have payments, each 
payment must correspond to a specific booking. The staff member identified by id, name, position, contact 
number and work at specific hotels where each staff member is associated with exactly one hotel, but a hotel 
must have at least one staff member. guests may also leave reviews for hotels, where each review includes a 
rating, comments, and a date. a guest may provide zero or more reviews, each linked to a specific hotel and 
hotel can have number of reviews from guests.  
 
1-  Design a complete ERD diagram of the above Hotel booking system includes ( entities, attributes, keys, 
relationships and their attributes, cardinality and participation ) 
 
2-  Map the ERD diagram into logical schema applying the conversion rules and also apply the normalization 
rules ( first normal form, second normal form, third normal form ) showing the final tables structure along 
with the referential relationships  
 
3-  Implement the physical schema of this database by converting the logical schema into sql code that create 
the above database, and apply the following constraints: 
 
- All Ids are Identity 
- All Foreign keys are not identity 
- All foreign keys have cascade rule on delete and update 
- Hotel name, room umber, guest email should be not duplicated within the system. 
- Hotel name, Location, Contact number, Room number, Room type, ID Proof Type, ID Proof Number 
Booking date, Status, Payment date, Amount, Review date should always have a value 
- For the following attributes each one have to meet certain requirement: 
✓ Room Type should only allow predefined values (e.g., 'Single', 'Double', 'Suite') 
✓ Booking tatus should only allow values like 'Pending', 'Confirmed', 'Canceled', 'Check-in', 'Check-out' 
✓ Price Per Night and payment Amount must be greater than zero 
✓ Ensure Check In Date is less than or equal to Check Out Date 
✓ Review Rating should be between 1 and 5. 
- Set default values for certain fields: 
✓ Room Is Available = TRUE, Booking Status = 'Pending'  
✓ Review: If Comments is not provided, set to 'No comments' 
