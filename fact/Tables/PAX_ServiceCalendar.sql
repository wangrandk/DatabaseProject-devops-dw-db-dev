CREATE TABLE [fact].[PAX_ServiceCalendar] (
    [ServiceCalendarKey]  INT IDENTITY (1, 1) NOT NULL,
    [OperatingDayDateKey] INT NOT NULL,
    [OperatingDayTypeKey] INT NOT NULL,
    [OperatingDayType1]   INT NOT NULL,
    [OperatingDayType2]   INT NOT NULL,
    [OperatingDayType3]   INT NOT NULL,
    CONSTRAINT [PK_PAX_ServiceCalendar] PRIMARY KEY CLUSTERED ([ServiceCalendarKey] ASC, [OperatingDayDateKey] ASC)
);


GO

