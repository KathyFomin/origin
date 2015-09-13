IF OBJECT_ID('tempdb..#orders') IS NOT NULL DROP TABLE #orders
IF OBJECT_ID('tempdb..#invoices') IS NOT NULL DROP TABLE #invoices

SELECT OrderID INTO #orders from Order_Master where SessionID = 880425 and ExtField2 = '006929509IL'

-- 15281
SELECT DISTINCT TX.InvoiceID, O.OrderID, CASE WHEN InvoiceID < 6688427 THEn 1 ELSE 2 END AS Part
into #invoices
FROM txReportTable TX inner join #orders O on TX.OrderID = O.OrderID
where InvoiceID NOT IN (6679813) -- we used this invoice for testing
order by InvoiceID

UPDATE IH SET [Sent] = 0
--select *
FROM EDDtblv_InvoiceHeader_810 IH inner join #invoices I on IH.InvoiceID = I.InvoiceID
where Part = 1

--UPDATE IH SET [Sent] = 0
--select *
--FROM EDDtblv_InvoiceHeader_810 IH inner join #invoices I on IH.InvoiceID = I.InvoiceID
--where Part = 2


