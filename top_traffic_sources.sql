-- First we start by selecting a small portion of data in this case website_session_id between 1000 and 2000 just to check what we have in there--
SELECT
	utm_content, 
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS orders,
	COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT website_sessions.website_session_id) AS session_to_order_cnv_rate
FROM website_sessions
	LEFT JOIN orders
		ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.website_session_id BETWEEN 1000 AND 2000 -- arbitrary
GROUP by 1
ORDER by 2 DESC;

-- Part 1 --

select 
	 utm_source,
     utm_campaign,
     http_referer,
     COUNT(DISTINCT website_session_id) AS sessions
from website_sessions
where created_at < '2012-04-12'
group by 
	utm_source,
    utm_campaign,
	http_referer
order by sessions desc;

-- Part 2--

SELECT 
	COUNT(DISTINCT website_sessions.website_session_id) AS sessions, 
    COUNT(DISTINCT orders.order_id) AS orders,
    (COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT website_sessions.website_session_id))*100 AS CVR
FROM website_sessions
LEFT JOIN 
	orders
ON orders.website_session_id = website_sessions.website_session_id
where website_sessions.created_at < '2012-04-14'
AND utm_source = 'gsearch'
AND utm_campaign = 'nonbrand';
