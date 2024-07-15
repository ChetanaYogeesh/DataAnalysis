/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SELECT
`name`
,`membercost`
FROM `Facilities`
WHERE coalesce(`membercost`,0.0) > 0.0

/*
RESULTS :
name membercost
Tennis Court 1 5.0
Tennis Court 2 5.0
Massage Room 1 9.9
Massage Room 2 9.9
Squash Court 3.5
*/


/* Q2: How many facilities do not charge a fee to members? */

SELECT count(`name`) FROM `Facilities` WHERE coalesce(`membercost`,0.0) > 0.0

/*
RESULTS :
5
*/

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT
`facid`
,`name`
,`membercost`
,`monthlymaintenance`
FROM `Facilities`
WHERE `membercost` < `monthlymaintenance`*0.02
AND coalesce(`membercost`,0.0) > 0.0


/*
#RESULTS :
name 20_pct_mtn_cost membercost
Massage Room 1 60.00 9.9
Massage Room 2 60.00 9.9

*/



/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */


SELECT *  FROM  `Facilities`  WHERE  `facid`  IN ( 1, 5 )

/*
#RESULTS :

name membercost guestcost facid initialoutlay monthlymaintenance
Tennis Court 2 5.0 25.0 1 8000 200
Massage Room 2 9.9 80.0 5 4000 3000

*/

/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */



SELECT name,
CASE WHEN monthlymaintenance < 100 THEN 'Cheap'
	 WHEN monthlymaintenance > 100 THEN 'Expensive'
END AS label
FROM Facilities

#Results
/*
name label
Tennis Court 1 Expensive
Tennis Court 2 Expensive
Badminton Court Cheap
Table Tennis Cheap
Massage Room 1 Expensive
Massage Room 2 Expensive
Squash Court Cheap
Snooker Table Cheap
Pool Table Cheap
*/

/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT
firstname
,surname
FROM Members
WHERE joindate = (SELECT MAX(joindate) FROM Members)


/*
#Results

Darren Smith
*/

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT f.name
, concat(m.firstname,' ',m.surname) AS member
, count(b.memid) AS times_used
FROM Bookings b
LEFT JOIN Members m ON b.memid = m.memid
JOIN Facilities f ON b.facid = f.facid
WHERE f.name LIKE 'TENNIS%'
AND b.memid >0
GROUP BY 1,2
ORDER BY 2

/* RESULTS SNIPPET


name
member
times_used
Tennis Court 1
Anne Baker
6
Tennis Court 2
Anne Baker
35
Tennis Court 1
Burton Tracy
31
Tennis Court 2
Burton Tracy
3
Tennis Court 1
Charles Owen
17
Tennis Court 2
Charles Owen
41
Tennis Court 2
Darren Smith
19
Tennis Court 2
David Farrell

*/

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT f.name AS Name
, CONCAT( m.firstname,  ' ', m.surname ) AS Member
, ( CASE WHEN b.memid =0
THEN f.guestcost
ELSE f.membercost
END ) * COUNT( bookid ) AS Cost
FROM Bookings b
JOIN Facilities f ON f.facid = b.facid
JOIN Members m ON m.memid = b.memid
WHERE DATE( starttime ) =  '2012-09-14'
GROUP BY 1 , 2
HAVING Cost > 30
ORDER BY Cost DESC

/* RESULTS

Name Member Cost
Massage Room 1 GUEST GUEST 240.0
Massage Room 2 GUEST GUEST 80.0
Squash Court GUEST GUEST 52.5
Tennis Court 1 GUEST GUEST 50.0
Tennis Court 2 GUEST GUEST 50.0
*/

/* Q9: This time, produce the same result as in Q8, but using a subquery. */


SELECT abc.name,(select CONCAT( m.firstname,  ' ', m.surname ) from Members m where m.memid =abc.memid) AS Member,sum(abc.cost) AS Cost
FROM
(	SELECT f.name, 'MEMBER', b.memid, count(bookid)*f.membercost AS cost
		FROM `Bookings` b
		JOIN Facilities f ON f.facid = b.facid
		WHERE b.memid > 0 AND DATE( b.starttime ) =  '2012-09-14'
		GROUP BY 1,2,3
	UNION
	SELECT f.name, 'GUEST',b.memid,count(bookid)*f.guestcost AS cost
		FROM `Bookings` b
		JOIN Facilities f ON f.facid = b.facid
		WHERE b.memid = 0 AND DATE( b.starttime ) =  '2012-09-14'
		GROUP BY 1,2,3
) abc
GROUP BY 1,2
HAVING Cost > 30


/* RESULTS

Name Member Cost
Massage Room 1 GUEST GUEST 240.0
Massage Room 2 GUEST GUEST 80.0
Squash Court GUEST GUEST 52.5
Tennis Court 1 GUEST GUEST 50.0
Tennis Court 2 GUEST GUEST 50.0
*/


/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */


SELECT abc.name,sum(abc.revenue) AS Revenue
FROM
(
	SELECT f.name, f.membercost,count(bookid), count(bookid)*f.membercost AS revenue, 'MEMBER'
		FROM `Bookings` b
		JOIN Facilities f ON f.facid = b.facid
		WHERE b.memid > 0
		GROUP BY 1,2
UNION
	SELECT f.name, f.guestcost, count(bookid),count(bookid)*f.guestcost AS revenue, 'GUEST'
		FROM `Bookings` b
		JOIN Facilities f ON f.facid = b.facid
		WHERE b.memid = 0
		GROUP BY 1,2
) abc
GROUP BY 1
HAVING Revenue < 1000

/*
RESULTS

Badminton Court 604.5
Pool Table 265.0
Snooker Table 115.0
Table Tennis 90.0
*/
