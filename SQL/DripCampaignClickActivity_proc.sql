-- Identifies and returns information about contacts or leads who have interacted with a Drip Email Campaigns.

-- Drop the procedure if it already exists to avoid conflicts
drop procedure if exists proc.zz_proc_mktg_auto_clicked_all_drips;

-- Set the delimiter to '//' to handle the procedure definition
delimiter //

-- Create a new stored procedure named 'proc.zz_proc_mktg_auto_clicked_all_drips'
create procedure proc.zz_proc_mktg_auto_clicked_all_drips(in days_since_last_click tinyint)
begin
    -- Select the truncated contact or lead ID and the latest click datetime
    select
        coalesce(l.contact_id_trunc, l.lead_id_trunc) as 'id', -- Use COALESCE to select either contact_id_trunc or lead_id_trunc, whichever is not NULL
        max(mc.clicked_datetime) as 'last_click' -- Get the latest click datetime
    from 
        sn.mc_campaign_activity mc -- From the marketing campaign activity table
    join 
        sf.lead_contact_account_email l -- Join with the lead contact account email table
        on mc.email_hash = l.email -- Match records using the email hash
    where 
        mc.campaign like 'Drip Campaign #%' -- Filter for campaigns that match the pattern 'Drip Campaign #%'
        and mc.clicked_datetime is not null -- Ensure the click datetime is not null
        and l.email_status like 'Subscribed%' -- Ensure the email status is subscribed
    group by 
        1 -- Group by the first column in the select statement (id)
    having 
        count(mc.email_hash) = 3 -- Ensure the email hash appears exactly 3 times
        and now() between max(mc.clicked_datetime) + interval days_since_last_click day 
        and max(mc.clicked_datetime) + interval (days_since_last_click + 3) day; -- Filter for records where the current time is within the specified interval after the last click

end//

-- Reset the delimiter back to ';' after the procedure definition
delimiter ;
