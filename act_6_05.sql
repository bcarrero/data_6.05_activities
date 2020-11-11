use bank;
/*
6.05 Activity 1
In this activity, you will be using data from files_for_activities/mysql_dump.sql. 
Refer to the case study files to find more information. Please answer the following questions.
Create a procedure that takes as an input a district name and outputs the total loss in that district. 
Try it with "Kutna Hora".
*/

select * from loan;

select d.A2 as district_name, round((sum(l.amount)-sum(l.payments)),2) as loss from loan as l
  join account as a on l.account_id = a.account_id
  join district as d on a.district_id = d.A1
  where d.A2="Kutna Hora" and l.status='B'
  group by district_name;

drop procedure if exists total_loss_district;
delimiter //
create procedure total_loss_district (in district_name varchar(50))
begin
  select d.A2 as district_name, round((sum(l.amount)-sum(l.payments)),2) as loss from loan as l
  join account as a on l.account_id = a.account_id
  join district as d on a.district_id = d.A1
  where d.A2 COLLATE utf8mb4_general_ci = district_name
	and l.status='B'
  group by district_name;
end; 
//
delimiter ;

call total_loss_district("Kutna Hora");

/* 6.05 Activity 2
Keep working on the same dataset.
Change the stored procedure from Activity 1 to use variables in it.
*/
drop procedure if exists total_loss_district_v;
delimiter //
create procedure total_loss_district_v (in dist_name varchar(50))
begin
  declare district_loss float default 0.0;
  select round((sum(l.amount)-sum(l.payments)),2) into district_loss from loan as l
  join account as a on l.account_id = a.account_id
  join district as d on a.district_id = d.A1
  where d.A2 COLLATE utf8mb4_general_ci = dist_name
	and l.status='B';
  select district_loss;
end; 
//
delimiter ;

#declare district_loss float default 0.0;
call total_loss_district_v("Kutna Hora");


