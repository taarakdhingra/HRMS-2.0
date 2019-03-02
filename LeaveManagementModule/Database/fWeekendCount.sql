CREATE FUNCTION fWeekendCount
(
@startDate datetime,
@endDate datetime
)
RETURNS int   
AS   
BEGIN
    DECLARE @count int = 0;
    WHILE @startDate <= @endDate
        BEGIN
        IF DatePart(WEEKDAY,@startDate) =  1 OR DatePart(WEEKDAY,@startDate) =  7
        SET @count = @count + 1
        SET @startDate = DateAdd(d,1,@startDate)
        END

RETURN @count 
END
GO
/* Sample Call For Weekend Count */
SELECT dbo.fWeekendCount('2019/02/12','2019/03/02') AS WeekendCount

/* Sample Call For Weekend Count */
DECLARE @weekendCount int = 0;
SET @weekendCount = dbo.fWeekendCount('2019/02/12','2019/03/02');
SELECT @weekendCount AS WeekendCount