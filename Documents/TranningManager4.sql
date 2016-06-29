USE [master]
GO
/****** Object:  Database [TranningManager]    Script Date: 6/29/2016 6:19:51 PM ******/
CREATE DATABASE [TranningManager]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TranningManager', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\TranningManager.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TranningManager_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\TranningManager_log.ldf' , SIZE = 1088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TranningManager] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TranningManager].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TranningManager] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TranningManager] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TranningManager] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TranningManager] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TranningManager] SET ARITHABORT OFF 
GO
ALTER DATABASE [TranningManager] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TranningManager] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [TranningManager] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TranningManager] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TranningManager] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TranningManager] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TranningManager] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TranningManager] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TranningManager] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TranningManager] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TranningManager] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TranningManager] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TranningManager] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TranningManager] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TranningManager] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TranningManager] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TranningManager] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TranningManager] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TranningManager] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TranningManager] SET  MULTI_USER 
GO
ALTER DATABASE [TranningManager] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TranningManager] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TranningManager] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TranningManager] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [TranningManager]
GO
/****** Object:  UserDefinedTableType [dbo].[GlobalEmployee]    Script Date: 6/29/2016 6:19:51 PM ******/
CREATE TYPE [dbo].[GlobalEmployee] AS TABLE(
	[UserID] [int] NULL,
	[EmpStatus] [varchar](20) NULL,
	[EmpType] [varchar](20) NULL,
	[JobLocation] [varchar](20) NULL,
	[JobCode] [varchar](20) NULL,
	[DomainID] [varchar](20) NULL,
	[OrganizationID] [int] NULL,
	[UserName] [nvarchar](100) NULL,
	[Active] [varchar](20) NULL,
	[Address] [nvarchar](2000) NULL,
	[City] [nvarchar](2000) NULL,
	[State] [nvarchar](2000) NULL,
	[PostalCode] [varchar](20) NULL,
	[Country] [varchar](20) NULL,
	[Supervisor] [int] NULL,
	[HireDate] [varchar](20) NULL,
	[Terminated] [varchar](20) NULL,
	[Email] [varchar](50) NULL,
	[HasAccess] [varchar](20) NULL,
	[Locked] [varchar](20) NULL,
	[RegionID] [varchar](100) NULL,
	[RoleID] [varchar](100) NULL,
	[ProfileStatus] [varchar](20) NULL,
	[PositionID] [varchar](20) NULL,
	[IsFullTime] [varchar](20) NULL,
	[NativeDeeplinkUser] [varchar](20) NULL,
	[GamificationUserID] [varchar](20) NULL,
	[Regular] [varchar](20) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[LocalEmployee]    Script Date: 6/29/2016 6:19:51 PM ******/
CREATE TYPE [dbo].[LocalEmployee] AS TABLE(
	[EmployeeID] [varchar](50) NULL,
	[CardID] [int] NULL,
	[FirstName] [varchar](100) NULL,
	[MiddleName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[EmailAddress] [varchar](100) NULL,
	[NTID] [varchar](15) NULL,
	[OrganizationName] [varchar](100) NULL,
	[Supervisor] [varchar](50) NULL,
	[IsActive] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TrainingBasicData]    Script Date: 6/29/2016 6:19:51 PM ******/
CREATE TYPE [dbo].[TrainingBasicData] AS TABLE(
	[ScheduledOfferingID] [int] NULL,
	[Title] [nvarchar](2000) NULL,
	[ItemType] [varchar](50) NULL,
	[ItemID] [int] NULL,
	[RevisionDate] [datetime] NULL,
	[RevisionNumber] [int] NULL,
	[Seg] [int] NULL,
	[Description] [nvarchar](2000) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[InstructorFirstName] [nvarchar](50) NULL,
	[InstructorLastName] [nvarchar](50) NULL,
	[InstructorMiddleName] [nvarchar](50) NULL,
	[Location] [varchar](20) NULL,
	[GlobalID] [int] NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[Organization] [varchar](50) NULL,
	[LegalEntity] [varchar](50) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[USP_IMPORT_GLOBALEMPLOYEE]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_IMPORT_GLOBALEMPLOYEE]
	@DataTable as GlobalEmployee READONLY
AS
BEGIN
	select DISTINCT UserID, OrganizationID, Supervisor, Email
	INTO #EmployeeGlobal
	FROM @DataTable

	insert into EmployeeGlobal(GlobalID,EmailAddress, [Initiator])
	SELECT E.UserID,Email, 'VH0000'
	FROM #EmployeeGlobal E
	LEFT JOIN EmployeeGlobal E1 ON E.UserID = E1.GlobalID
	WHERE E1.GlobalID IS NULL

	UPDATE E
	SET GlobalID = EG.GlobalID
	FROM [dbo].[Employee] E
	JOIN [dbo].[EmployeeGlobal] EG ON E.EmailAddress = EG.EmailAddress
END



GO
/****** Object:  StoredProcedure [dbo].[USP_IMPORT_LOCALEMPLOYEE]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_IMPORT_LOCALEMPLOYEE]
	@DataTable as LocalEmployee READONLY
AS
BEGIN
	select DISTINCT [EmployeeID], [CardID], [FirstName], [MiddleName], [LastName], [EmailAddress], [NTID], [OrganizationName], [Supervisor], [IsActive]
	INTO #LocalEmployee
	FROM @DataTable
	
	UPDATE Emp
	SET [FirstName] = E.[FirstName], [LastName] = E.[LastName], [MiddleName] = E.[MiddleName], [EmailAddress] = E.[EmailAddress], [NTID] = E.[NTID], 
	[OrganizationName] = E.[OrganizationName], [CardID] = E.[CardID], [Supervisor] = E.[Supervisor], [IsActive] = E.[IsActive], ModifiedBy = 'VH0000', ModifiedDate = GETDATE()
	FROM #LocalEmployee E
	JOIN [dbo].[Employee] Emp ON E.[EmployeeID] = Emp.[EmployeeID]

	insert into [dbo].[Employee]([EmployeeID], [FirstName], [LastName], [MiddleName], [EmailAddress], [NTID], [OrganizationName], [CardID], [Supervisor], [Initiator], [CreatedDate], [IsActive])
	SELECT E.[EmployeeID], E.[FirstName], E.[LastName], E.[MiddleName], E.[EmailAddress], E.[NTID], E.[OrganizationName], E.[CardID], E.[Supervisor],'VH0000', GETDATE(), E.[IsActive]
	FROM #LocalEmployee E
	LEFT JOIN [dbo].[Employee] Emp ON E.[EmployeeID] = Emp.[EmployeeID]
	WHERE Emp.[EmployeeID] IS NULL
END
/****** End - Edited by Viet  ******/


GO
/****** Object:  StoredProcedure [dbo].[USP_IMPORT_TIME]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_IMPORT_TIME]
        -- Add the parameters for the stored procedure here
        @SwipeDate Varchar(10) = null
AS
BEGIN TRY
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;
 
        
        If @SwipeDate is not null and Exists (Select 1 from dbo.Temp_BadgeReaderData where cast(col2 as DATE) = @SwipeDate )
        Begin
                        --Declare @RBVHEntity int = [dbo].[UFN_COM_GetParameterValue]('RBVH');
                        --Declare @ENGEntity int = [dbo].[UFN_COM_GetParameterValue]('GS_ENG');
 
            DECLARE @TmpEmployeeSwipeDetails table (
                            [EmployeeID] [char](20) NULL,
                            [CardNo] [int] NULL,
                            [SwipeDate] [date] NULL,
                            [SwipeTime] [time](7) NULL,
                            [SwipeMode] [varchar](10) NULL,
                            [Remarks] [varchar](1000) NULL,
                            [CreatedDate] [datetime] NULL,
                            [CreatedBy] [int] NULL)
                                                                                
            Insert into  @TmpEmployeeSwipeDetails
            (EmployeeID, CardNo, SwipeDate,
            SwipeTime, SwipeMode, Remarks)
            Select Emp.EmployeeID,cast(col13 as int) AccessCardNo 
            ,cast(col2 as DATE) SwipeDate,
            min(cast(substring(replace(col3,'W',''),0,3) +':'
            +substring(replace(col3,'W',''),3,2)  +':'
            +substring(replace(col3,'W',''),5,2)  as time)) SwipeTime
            ,'IN' SwipeMode ,'Empno - '+Emp.EmployeeID+';'+ col15 +';' +col16 as Remarks
            from dbo.Temp_BadgeReaderData (NoLock) 
            --join dbo.T_COM_Master_EmployeeAccessCard (NoLock)  A on AccessCardNo = cast(col13 as int)  and IsActive = 1
            join [dbo].[Employee](NoLock) Emp on Emp.[CardID] = cast(col13 as int) and Emp.IsActive = 1
            --join dbo.T_COM_Master_Location (NoLock) Loc on Loc.LocationId = Emp.LocationId                  
            where col8 = 'entry reader 1'
            and col11 = 'Access'
            --and Loc.EntityID IN (@RBVHEntity, @ENGEntity)
            and cast(col2 as DATE) = @SwipeDate--Cast(GETDATE()-1 as DATE)
            group by col2,col8,cast(col13 as int),'Empno - '+ Emp.EmployeeID+';'+ col15 +';' +col16,Emp.EmployeeID
            union
            Select Emp.EmployeeID,
            cast(col13 as int) AccessCardNo 
            ,cast(col2 as DATE) SwipeDate,
            max(cast(substring(replace(col3,'W',''),0,3) +':'
            +substring(replace(col3,'W',''),3,2)  +':'
            +substring(replace(col3,'W',''),5,2)  as time)) SwipeTime
            ,'OUT' SwipeMode , 'Empno - '+Emp.EmployeeID+';'+ col15 +';' +col16 as Remarks
            from dbo.Temp_BadgeReaderData (NoLock) 
            --join dbo.T_COM_Master_EmployeeAccessCard (NoLock)  A on AccessCardNo = cast(col13 as int)  and IsActive = 1
            join [dbo].[Employee](NoLock) Emp on Emp.[CardID] = cast(col13 as int) and Emp.IsActive = 1                     
            --join dbo.T_COM_Master_Location (NoLock) Loc on Loc.LocationId = Emp.LocationId
            where col8 = 'exit reader 1'
            and col11 = 'Access'
            --and Loc.EntityID IN (@RBVHEntity, @ENGEntity)
            and cast(col2 as DATE) = @SwipeDate--Cast(GETDATE()-1 as DATE)
            group by col2,col8,cast(col13 as int),'Empno - '+Emp.EmployeeID+';'+ col15 +';' +col16,Emp.EmployeeID
 
        End
        
		DECLARE @ROOMID uniqueidentifier
		select top 1 @ROOMID = RoomID from [dbo].[Room]

        INSERT INTO  [dbo].[Transaction] (EmployeeID,CardID,[Time],RoomID,InOut)
        Select  Emp.EmployeeID, Emp.CardID, convert(varchar,SwipeDate,111)+' '+ convert(varchar, SwipeTime,120 )as Scan_Time,@ROOMID,
        case SwipeMode when 'IN' then 1 else 0 end as InOut
        from @TmpEmployeeSwipeDetails S
        join [dbo].[Employee] (NoLock)  Emp on S.[CardNo] = Emp.CardID --121142
        --join dbo.T_COM_Master_Employee(NoLock) Emp on Emp.EmployeeNo = E.Bar_Code 
        left join [dbo].[Transaction] (NoLock)  T on T.EmployeeID = Emp.EmployeeID 
            and convert(varchar,SwipeDate,111)+' '+ convert(varchar, SwipeTime,120 ) = [Time] 
            and InOut = case SwipeMode when 'IN' then 1 else 0 end 
        where T.[TransactionID] is  null 
                
        Truncate Table dbo.Temp_BadgeReaderData  
END TRY
BEGIN CATCH
        DECLARE @ErrMsg VARCHAR(max)= ERROR_MESSAGE()
 
        RAISERROR(@ErrMsg, 11, 1)
END CATCH
/****** Object:  Table [dbo].[ApplicationMenu]    Script Date: 6/28/2016 6:13:45 PM ******/
SET ANSI_NULLS ON

GO
/****** Object:  StoredProcedure [dbo].[USP_IMPORT_TRAININGBASICDATA]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_IMPORT_TRAININGBASICDATA]
	@DataTable as TrainingBasicData READONLY
AS
BEGIN
	select DISTINCT Title
	INTO #Course
	FROM @DataTable
	
	insert into Course(Name,Note,IsActive)
	SELECT C.Title,'',1
	FROM #Course C
	LEFT JOIN Course C1 ON C1.Name = C.Title
	WHERE C1.CourseID IS NULL

	select DISTINCT [ScheduledOfferingID],[StartDate],[EndDate],Title
	INTO #Schedule
	FROM @DataTable

	INSERT INTO Schedule_Testing ([ScheduledOfferingID],[StartDate],[EndDate],Title)
	SELECT DISTINCT S.[ScheduledOfferingID], S.[StartDate],S.[EndDate],S.Title
	FROM #Schedule S
	JOIN Course C ON C.Name = S.Title
	LEFT JOIN Schedule S1 ON S1.[StartTime] = S.[StartDate] AND S1.[EndTime] = S.[EndDate] AND S.Title = S1.[CourseName]
	WHERE S1.ScheduleID IS NULL

	--insert into Schedule([ScheduleID],StartTime,  EndTime,   CourseID,TeacherID, CourseName, [Initiator] )
	--SELECT DISTINCT S.[ScheduledOfferingID], S.[StartDate],S.[EndDate],C.CourseID,'5C2EEC54-4834-4DC4-B5F8-2C3421C748AD',S.Title, 'VH0000'
	--FROM #Schedule S
	--JOIN Course C ON C.Name = S.Title
	--LEFT JOIN Schedule S1 ON S1.[StartTime] = S.[StartDate] AND S1.[EndTime] = S.[EndDate] AND S.Title = S1.[CourseName]
	--WHERE S1.ScheduleID IS NULL

	--select DISTINCT ScheduledOfferingID, GlobalID
	--INTO #TrainingEmployee
	--FROM @DataTable

	--insert into TrainingEmployee([ScheduleID],[EmployeeID])
	--SELECT T.ScheduledOfferingID,T.GlobalID
	--FROM #TrainingEmployee T
	--JOIN Schedule C ON C.[ScheduleID] = T.ScheduledOfferingID
	--JOIN [dbo].[Employee] E ON E.GlobalID = T.GlobalID 
	--LEFT JOIN TrainingEmployee T1 ON T1.EmployeeID = T.GloBalID AND T1.ScheduleID = T.ScheduledOfferingID
	--WHERE T1.ScheduleID IS NULL
END


--select * from Schedule_Testing
--drop proc  [dbo].[USP_IMPORT_TRAININGBASICDATA]

--create  table Schedule_Testing
--(
--	[ScheduledOfferingID] int,
--	[StartDate] datetime,
--	[EndDate] datetime,
--	Title nvarchar(200)
--)

--select * from Schedule_Testing

--select * from Course
GO
/****** Object:  Table [dbo].[ApplicationMenu]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationMenu](
	[ApplicationMenuID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[ParentCode] [nvarchar](500) NULL,
	[Controller] [nvarchar](500) NULL,
	[Initiator] [nchar](20) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ApplicationMenu] PRIMARY KEY CLUSTERED 
(
	[ApplicationMenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[AttendantID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SegmentID] [uniqueidentifier] NOT NULL,
	[RoomID] [uniqueidentifier] NOT NULL,
	[RoomName] [nvarchar](2000) NULL,
	[EmployeeID] [nchar](20) NOT NULL,
	[TimeIn] [datetime] NULL,
	[TimeOut] [datetime] NULL,
	[FullName] [nvarchar](2000) NOT NULL,
	[ScheduleID] [int] NULL,
	[CourseName] [nvarchar](2000) NOT NULL,
	[OrganizationName] [nvarchar](500) NULL,
	[Supervisor] [nvarchar](2000) NULL,
	[AttendantDate] [date] NOT NULL,
	[IsManual] [bit] NOT NULL,
 CONSTRAINT [PK_Attendence] PRIMARY KEY CLUSTERED 
(
	[AttendantID] ASC,
	[SegmentID] ASC,
	[RoomID] ASC,
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Course]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [nvarchar](2000) NOT NULL,
	[Note] [nvarchar](2000) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employee]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [nchar](20) NOT NULL,
	[GlobalID] [int] NULL,
	[CardID] [int] NULL,
	[EmailAddress] [nvarchar](2000) NULL,
	[NTID] [nchar](10) NULL,
	[FirstName] [nvarchar](500) NULL,
	[LastName] [nvarchar](500) NULL,
	[MiddleName] [nvarchar](500) NULL,
	[OrganizationName] [nvarchar](500) NOT NULL,
	[Supervisor] [nvarchar](2000) NULL,
	[Initiator] [nchar](20) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nchar](10) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmployeeGlobal]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeGlobal](
	[GlobalID] [int] NOT NULL,
	[FirstName] [nvarchar](500) NULL,
	[LastName] [nvarchar](500) NULL,
	[OrganizationID] [int] NULL,
	[EmailAddress] [nvarchar](2000) NULL,
	[Initiator] [nchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_EmployeeGlobal] PRIMARY KEY CLUSTERED 
(
	[GlobalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Leave]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Leave](
	[LeaveID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SegmentID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [nchar](20) NOT NULL,
	[ReasonID] [uniqueidentifier] NOT NULL,
	[Remark] [nvarchar](2000) NULL,
	[Initiator] [nchar](20) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Leave] PRIMARY KEY CLUSTERED 
(
	[LeaveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Organization]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organization](
	[OrganizationID] [int] NOT NULL,
	[OrganizationName] [nvarchar](2000) NOT NULL,
	[ParentID] [int] NULL,
	[TypeID] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED 
(
	[OrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrganizationType]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrganizationType](
	[TypeID] [int] NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_OrganizationType] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reason]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reason](
	[ReasonID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [nvarchar](2000) NOT NULL,
	[Initiator] [nchar](20) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Reason] PRIMARY KEY CLUSTERED 
(
	[ReasonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [nvarchar](2000) NOT NULL,
	[Initiator] [nchar](20) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoleMapping]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMapping](
	[RoleID] [uniqueidentifier] NOT NULL,
	[MenuID] [uniqueidentifier] NOT NULL,
	[Initiator] [nchar](20) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_RoleMapping] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC,
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Room]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[RoomID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [nvarchar](2000) NOT NULL,
	[MaxPeople] [int] NULL,
	[Position] [nvarchar](2000) NULL,
	[Initiator] [nchar](20) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Room_TerminalMapping]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room_TerminalMapping](
	[RoomID] [uniqueidentifier] NOT NULL,
	[TerminalID] [uniqueidentifier] NOT NULL,
	[Initiator] [nchar](20) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Room_TerminalMapping] PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC,
	[TerminalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[ScheduleID] [int] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[TeacherID] [uniqueidentifier] NOT NULL,
	[MinPeople] [int] NULL,
	[MaxPeople] [int] NULL,
	[CourseID] [uniqueidentifier] NOT NULL,
	[CourseName] [nvarchar](2000) NOT NULL,
	[Note] [nvarchar](2000) NULL,
	[Initiator] [nchar](20) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nchar](20) NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Schedule_Testing]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule_Testing](
	[ScheduledOfferingID] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Title] [nvarchar](200) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Segment]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Segment](
	[SegmentID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ScheduleID] [int] NOT NULL,
	[CourseName] [nvarchar](2000) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[RoomID] [uniqueidentifier] NOT NULL,
	[Note] [nchar](10) NULL,
	[Item] [nvarchar](2000) NULL,
	[Date] [date] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Segment] PRIMARY KEY CLUSTERED 
(
	[SegmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Teacher](
	[TeacherID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[IsExternal] [bit] NOT NULL,
	[Email] [varchar](200) NOT NULL,
	[Initiator] [nchar](20) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[EmlpoyeeID] [nchar](20) NULL,
 CONSTRAINT [PK_TeacherMaster] PRIMARY KEY CLUSTERED 
(
	[TeacherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Temp_BadgeReaderData]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Temp_BadgeReaderData](
	[col1] [varchar](100) NULL,
	[col2] [varchar](100) NULL,
	[col3] [varchar](100) NULL,
	[col4] [varchar](100) NULL,
	[col5] [varchar](100) NULL,
	[col6] [varchar](100) NULL,
	[col7] [varchar](100) NULL,
	[col8] [varchar](100) NULL,
	[col9] [varchar](100) NULL,
	[col10] [varchar](100) NULL,
	[col11] [varchar](100) NULL,
	[col12] [varchar](100) NULL,
	[col13] [varchar](100) NULL,
	[col14] [varchar](100) NULL,
	[col15] [varchar](100) NULL,
	[col16] [varchar](100) NULL,
	[col17] [varchar](100) NULL,
	[col18] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TerminalMaster]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TerminalMaster](
	[TerminalID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Initiator] [nchar](20) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TerminalMaster_1] PRIMARY KEY CLUSTERED 
(
	[TerminalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrainingEmployee]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrainingEmployee](
	[TrainingEmployeeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ScheduleID] [int] NOT NULL,
	[EmployeeID] [nchar](20) NOT NULL,
	[StopFrom] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TrainingEmployee] PRIMARY KEY CLUSTERED 
(
	[TrainingEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Transaction](
	[TransactionID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[EmployeeID] [char](20) NOT NULL,
	[CardID] [nchar](20) NOT NULL,
	[Time] [datetime] NOT NULL,
	[RoomID] [uniqueidentifier] NOT NULL,
	[InOut] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 6/29/2016 6:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[RoleID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [nchar](20) NOT NULL,
	[Initiator] [nchar](20) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [nchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC,
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Course] ([CourseID], [Name], [Note], [IsActive]) VALUES (N'54b7f6a6-0d28-4eb2-b7f9-4e4b99b75eb2', N'Waiting For Update', N'test', 1)
INSERT [dbo].[Course] ([CourseID], [Name], [Note], [IsActive]) VALUES (N'8c400308-ef7b-48c5-bab5-884680db6a00', N'[RBEI-SWE-ORGWIDE00003] C Programming-B', N'', 1)
INSERT [dbo].[Course] ([CourseID], [Name], [Note], [IsActive]) VALUES (N'c56edfea-57d4-46b9-bb29-f62e00757789', N'Waiting For Update1', N'Waiting For Update', 1)
INSERT [dbo].[Employee] ([EmployeeID], [GlobalID], [CardID], [EmailAddress], [NTID], [FirstName], [LastName], [MiddleName], [OrganizationName], [Supervisor], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'VH0909              ', NULL, 56789, N'test-a.nguyen@vn.bosch.com', N'ATS1HC    ', N'A', N'Nguyen', N'Van', N'RBVH/ETI4.1', NULL, N'VH0000              ', CAST(0x0000A63401050344 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Employee] ([EmployeeID], [GlobalID], [CardID], [EmailAddress], [NTID], [FirstName], [LastName], [MiddleName], [OrganizationName], [Supervisor], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'VH0910              ', NULL, 56790, N'test-b.nguyen@vn.bosch.com', N'ATS2HC    ', N'B', N'Nguyen', N'Van', N'RBVH/ETI4.2', N'VH0909', N'VH0000              ', CAST(0x0000A63401050344 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Employee] ([EmployeeID], [GlobalID], [CardID], [EmailAddress], [NTID], [FirstName], [LastName], [MiddleName], [OrganizationName], [Supervisor], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'VH0911              ', NULL, 56791, N'test-c.nguyen@vn.bosch.com', N'ATS3HC    ', N'C', N'Nguyen', N'Van', N'RBVH/ETI4.1', N'VH0909', N'VH0000              ', CAST(0x0000A63401050344 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Employee] ([EmployeeID], [GlobalID], [CardID], [EmailAddress], [NTID], [FirstName], [LastName], [MiddleName], [OrganizationName], [Supervisor], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'VH0912              ', NULL, 56792, N'test-D.nguyen@vn.bosch.com', N'ATS4HC    ', N'D', N'Nguyen', N'Van', N'RBVH/ETI4.3', N'VH0909', N'VH0000              ', CAST(0x0000A63401050344 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Employee] ([EmployeeID], [GlobalID], [CardID], [EmailAddress], [NTID], [FirstName], [LastName], [MiddleName], [OrganizationName], [Supervisor], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'VH0913              ', NULL, 56793, N'test-e.nguyen@vn.bosch.com', N'ATS5HC    ', N'E', N'Nguyen', N'Thi', N'RBVH/ETI4.4', N'VH0909', N'VH0000              ', CAST(0x0000A63401050344 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Employee] ([EmployeeID], [GlobalID], [CardID], [EmailAddress], [NTID], [FirstName], [LastName], [MiddleName], [OrganizationName], [Supervisor], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'VH0914              ', NULL, 56794, N'test-f.nguyen@vn.bosch.com', N'ATS6HC    ', N'F', N'Nguyen', N'Van', N'RBVH/ETI4.3', N'VH0909', N'VH0000              ', CAST(0x0000A63401050344 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Employee] ([EmployeeID], [GlobalID], [CardID], [EmailAddress], [NTID], [FirstName], [LastName], [MiddleName], [OrganizationName], [Supervisor], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'VH0915              ', NULL, 56795, N'test-i.nguyen@vn.bosch.com', N'ATS7HC    ', N'I', N'Nguyen', N'Van', N'RBVH/ETI3.1', N'VH0909', N'VH0000              ', CAST(0x0000A63401050344 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Employee] ([EmployeeID], [GlobalID], [CardID], [EmailAddress], [NTID], [FirstName], [LastName], [MiddleName], [OrganizationName], [Supervisor], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'VH0916              ', NULL, 56796, N'test-j.nguyen@vn.bosch.com', N'ATS8HC    ', N'J', N'Nguyen', N'Van', N'RBVH/ETI2.1', N'VH0909', N'VH0000              ', CAST(0x0000A63401050344 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Employee] ([EmployeeID], [GlobalID], [CardID], [EmailAddress], [NTID], [FirstName], [LastName], [MiddleName], [OrganizationName], [Supervisor], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'VH0917              ', NULL, 56797, N'test-k.nguyen@vn.bosch.com', N'ATS9HC    ', N'K', N'Nguyen', N'Van', N'RBVH/ETI5.1', N'VH0909', N'VH0000              ', CAST(0x0000A63401050344 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Employee] ([EmployeeID], [GlobalID], [CardID], [EmailAddress], [NTID], [FirstName], [LastName], [MiddleName], [OrganizationName], [Supervisor], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'VH0918              ', NULL, 56798, N'test-l.nguyen@vn.bosch.com', N'ATS10HC   ', N'L', N'Nguyen', N'Van', N'RBVH/ETI4.1', N'VH0909', N'VH0000              ', CAST(0x0000A63401050344 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10061334, NULL, NULL, NULL, N'SANDRA.MUIR2@AU.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10088826, NULL, NULL, NULL, N'UWE.HAUSER@CN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10538294, NULL, NULL, NULL, N'LEWIS.HENRY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10538856, NULL, NULL, NULL, N'BALA.SURESHR@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10539140, NULL, NULL, NULL, N'TD.RAMESHA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10539464, NULL, NULL, NULL, N'MALLIKARJUNA.GURU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10540911, NULL, NULL, NULL, N'SAGAR.PATIL5@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10541004, NULL, NULL, NULL, N'ATUL.SHARMA3@IN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10568431, NULL, NULL, NULL, N'MURUGAVEL.C@IN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10568917, NULL, NULL, NULL, N'KUMAR.RAJEEV@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10646902, NULL, NULL, NULL, N'TAKASHI.HIRANO@JP.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10690164, NULL, NULL, NULL, N'VU.PHAMHUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10799444, NULL, NULL, NULL, N'PHUC.DUONGHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10799452, NULL, NULL, NULL, N'VINH.NGUYENHA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10800109, NULL, NULL, NULL, N'NAM.NGUYENHOANG2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10830703, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10830740, NULL, NULL, NULL, N'HIEN.NGUYENTHITHU2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10830777, NULL, NULL, NULL, N'TRAM.HUYNHTHIKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10830861, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10870096, NULL, NULL, NULL, N'NHAN.PHANTHITHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10870698, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10918871, NULL, NULL, NULL, N'THU.DANGHUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10921341, NULL, NULL, NULL, N'HANH.TRANVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10948775, NULL, NULL, NULL, N'TRANG.PHAMHA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10948777, NULL, NULL, NULL, N'TRU.HANGTRI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10980648, NULL, NULL, NULL, N'THANH.NGUYENTHUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11007567, NULL, NULL, NULL, N'NHAT.NGUYENDANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11007568, NULL, NULL, NULL, N'ANH.NGUYENHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11007570, NULL, NULL, NULL, N'THACH.LEKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11007572, NULL, NULL, NULL, N'TRI.NGUYENLEMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11007573, NULL, NULL, NULL, N'MINH.PHANTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11007575, NULL, NULL, NULL, N'HAI.PHAMTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11012075, NULL, NULL, NULL, N'HOANG.PHANTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11012078, NULL, NULL, NULL, N'LOC.HUYNHMAIPHUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11012082, NULL, NULL, NULL, N'KHA.TRANMANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11025671, NULL, NULL, NULL, N'HANG.NGUYENTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11025674, NULL, NULL, NULL, N'LAP.PHAMNGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11025675, NULL, NULL, NULL, N'QUYEN.NGUYENTHILE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11025676, NULL, NULL, NULL, N'NGUYEN.BUIVUONGTHAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11028156, NULL, NULL, NULL, N'THANG.TRANMANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11028158, NULL, NULL, NULL, N'PHUC.LUUVINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11028179, NULL, NULL, NULL, N'Y.NGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11035759, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11036708, NULL, NULL, NULL, N'HUONG.HOANGLAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11036711, NULL, NULL, NULL, N'HIEN.NGUYENTHITHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11036715, NULL, NULL, NULL, N'LAN.TRANTHE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11037678, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11054581, NULL, NULL, NULL, N'HANG.NGUYENTHITHUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11054991, NULL, NULL, NULL, N'HUONG.NGUYENTHILAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055192, NULL, NULL, NULL, N'THOA.PHAMHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055244, NULL, NULL, NULL, N'TRINH.NGUYENTHIMY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055260, NULL, NULL, NULL, N'PHUONG.VOTHILAM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055269, NULL, NULL, NULL, N'RBVN.CTG5@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055280, NULL, NULL, NULL, N'LUONG.LEVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055285, NULL, NULL, NULL, N'VU.VODUYANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055286, NULL, NULL, NULL, N'BINH.LECONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055288, NULL, NULL, NULL, N'LUAN.NGUYENTHE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055289, NULL, NULL, NULL, N'VU.LAMQUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055290, NULL, NULL, NULL, N'NGA.HOANGTHITHUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055291, NULL, NULL, NULL, N'ANH.DUONGMINH2@JP.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055292, NULL, NULL, NULL, N'DONG.HUYNHTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055293, NULL, NULL, NULL, N'HAI.TRANDAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055294, NULL, NULL, NULL, N'HUY.TRUONGDINHQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055295, NULL, NULL, NULL, N'KIEN.NGUYENHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055296, NULL, NULL, NULL, N'HUNG.NGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055297, NULL, NULL, NULL, N'TUAN.VOLETHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055299, NULL, NULL, NULL, N'THACH.HUYNHCONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055301, NULL, NULL, NULL, N'ANH.NGUYENTHINGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055303, NULL, NULL, NULL, N'THIEN.NGUYENTHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055305, NULL, NULL, NULL, N'MY.NGUYENXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055306, NULL, NULL, NULL, N'HUNG.LAMQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055307, NULL, NULL, NULL, N'TAI.NGUYENHUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055310, NULL, NULL, NULL, N'VIET.BUIQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055311, NULL, NULL, NULL, N'QUANG.NGUYENTANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055313, NULL, NULL, NULL, N'THAI.PHAM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055314, NULL, NULL, NULL, N'TUYEN.LETHIMONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055315, NULL, NULL, NULL, N'MINH.VOTRONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055316, NULL, NULL, NULL, N'TUAN.NGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055318, NULL, NULL, NULL, N'TIEN.PHANDOAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055319, NULL, NULL, NULL, N'THAI.NGUYENQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055321, NULL, NULL, NULL, N'TAM.NGUYENNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055325, NULL, NULL, NULL, N'MINH.HOANGLE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055326, NULL, NULL, NULL, N'GIANG.NGUYENTHITRA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055327, NULL, NULL, NULL, N'HANG.NGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055329, NULL, NULL, NULL, N'NGOC.THACHBICH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055330, NULL, NULL, NULL, N'NGA.NGUYENXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055331, NULL, NULL, NULL, N'LINH.BUIPHUOCHOANG2@JP.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055332, NULL, NULL, NULL, N'VAN.VUTHIBICH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055333, NULL, NULL, NULL, N'NGOC.DUONGTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055336, NULL, NULL, NULL, N'NGA.NGUYENTHITHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055339, NULL, NULL, NULL, N'PHUONG.NGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055340, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055342, NULL, NULL, NULL, N'HIEP.LEHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055346, NULL, NULL, NULL, N'NGU.TRANHUYNHNGAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055348, NULL, NULL, NULL, N'THUONG.BUIMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055349, NULL, NULL, NULL, N'DIEU.LUONGDANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055352, NULL, NULL, NULL, N'PHONG.DUONGTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055353, NULL, NULL, NULL, N'ANH.NGUYENTHINGOC2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055355, NULL, NULL, NULL, N'VINH.BUITHIXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055356, NULL, NULL, NULL, N'QUYNH.NGUYENNHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
GO
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055357, NULL, NULL, NULL, N'KHANG.LENGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055358, NULL, NULL, NULL, N'THANH.HUYNHTHINGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055363, NULL, NULL, NULL, N'LONG.PHAMTHAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055365, NULL, NULL, NULL, N'VINH.BIENXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055366, NULL, NULL, NULL, N'NHAN.HATHITHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055367, NULL, NULL, NULL, N'TUNG.BUINGHIEM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055371, NULL, NULL, NULL, N'CUONG.NGUYENPHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055372, NULL, NULL, NULL, N'TRONG.DUONGMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055374, NULL, NULL, NULL, N'NGUYEN.HOHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055375, NULL, NULL, NULL, N'GIANG.NGUYENTUANLE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055378, NULL, NULL, NULL, N'DUC.PHANBA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055379, NULL, NULL, NULL, N'DAO.BUINGOCQUYNH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055380, NULL, NULL, NULL, N'PHUONG.NGUYENMINH3@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055381, NULL, NULL, NULL, N'HUYEN.TRANTHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055382, NULL, NULL, NULL, N'TRAM.PHAMTHIBICH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055383, NULL, NULL, NULL, N'TRUNG.TRANVINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055386, NULL, NULL, NULL, N'KHOA.DINHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055388, NULL, NULL, NULL, N'THI.TRANXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055389, NULL, NULL, NULL, N'VIET.NGUYENHUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055391, NULL, NULL, NULL, N'LUAT.VOVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055392, NULL, NULL, NULL, N'HIEU.NGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055393, NULL, NULL, NULL, N'TOAN.DANGNHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055394, NULL, NULL, NULL, N'TOAN.LIEUDAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055396, NULL, NULL, NULL, N'NGHI.DONGOCDONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055397, NULL, NULL, NULL, N'TUNG.NGUYENTHANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055399, NULL, NULL, NULL, N'THINH.NGUYENCHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055400, NULL, NULL, NULL, N'KHIEM.NGUYENHUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055401, NULL, NULL, NULL, N'NGAN.NGUYENTHE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055403, NULL, NULL, NULL, N'DUY.TRANTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055405, NULL, NULL, NULL, N'NGOC.NGUYENTHIMY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055406, NULL, NULL, NULL, N'TRANG.DUONGTHIHOAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055410, NULL, NULL, NULL, N'DUY.LEQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055413, NULL, NULL, NULL, N'HOC.BUIVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055415, NULL, NULL, NULL, N'LINH.PHAMTHIPHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055416, NULL, NULL, NULL, N'THINH.NGUYENQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055417, NULL, NULL, NULL, N'PHUONG.NGUYENHOAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055418, NULL, NULL, NULL, N'PHUONG.TRANTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055419, NULL, NULL, NULL, N'THANH.PHANSI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055420, NULL, NULL, NULL, N'TAM.PHANTHIDIEU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055421, NULL, NULL, NULL, N'KHOI.DOQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055423, NULL, NULL, NULL, N'TUAN.NGUYENVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055424, NULL, NULL, NULL, N'HANH.THAIMY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055426, NULL, NULL, NULL, N'TRUNG.TRANTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055427, NULL, NULL, NULL, N'TUAN.NGUYENHOANGANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055428, NULL, NULL, NULL, N'NGUYET.TRANTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055429, NULL, NULL, NULL, N'VU.HUYNHQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055430, NULL, NULL, NULL, N'NHUNG.VOTHIXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055431, NULL, NULL, NULL, N'LOI.TRANVINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055432, NULL, NULL, NULL, N'AN.LAMTRUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055433, NULL, NULL, NULL, N'VAN.TOTRONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055434, NULL, NULL, NULL, N'LUON.NGUYENVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055435, NULL, NULL, NULL, N'THI.NGUYENDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055436, NULL, NULL, NULL, N'MAI.NGUYENNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055437, NULL, NULL, NULL, N'VI.QUANGTHITUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055438, NULL, NULL, NULL, N'YEN.NGUYENTHIHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055441, NULL, NULL, NULL, N'QUANG.LUUMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055447, NULL, NULL, NULL, N'HUY.LETHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055448, NULL, NULL, NULL, N'THU.TRANDINHTHIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055449, NULL, NULL, NULL, N'THOA.DINHTHIKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055450, NULL, NULL, NULL, N'THINH.LAMQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055451, NULL, NULL, NULL, N'THUAN.SUBA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055452, NULL, NULL, NULL, N'QUYEN.LEMAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055453, NULL, NULL, NULL, N'TRAM.NGUYENTHITHUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055457, NULL, NULL, NULL, N'TRUNG.NGUYENQUOC2@JP.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055458, NULL, NULL, NULL, N'CHANH.THAIVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055459, NULL, NULL, NULL, N'TRI.HUAMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055460, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055461, NULL, NULL, NULL, N'AN.LETRI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055463, NULL, NULL, NULL, N'DAT.NGOTHIVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055464, NULL, NULL, NULL, N'TRUNG.DAOTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055470, NULL, NULL, NULL, N'HOANG.TRIEUTICH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055471, NULL, NULL, NULL, N'MUI.CHAUSANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055472, NULL, NULL, NULL, N'NHI.VUTHIYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055474, NULL, NULL, NULL, N'TUNG.NGUYENSON@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055475, NULL, NULL, NULL, N'KHOI.NGUYENDUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055476, NULL, NULL, NULL, N'THIEN.NGUYENDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055479, NULL, NULL, NULL, N'PHUC.TRUONGVINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055480, NULL, NULL, NULL, N'TRI.LECAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055481, NULL, NULL, NULL, N'TOAN.TRUONGVIET@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055483, NULL, NULL, NULL, N'VU.NGUYENANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055485, NULL, NULL, NULL, N'TRUONG.LEXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055487, NULL, NULL, NULL, N'THAI.LE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055488, NULL, NULL, NULL, N'BIEN.NGHIEM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055490, NULL, NULL, NULL, N'DUY.NGUYENANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055491, NULL, NULL, NULL, N'NGOC.NGUYENHOANGBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055494, NULL, NULL, NULL, N'KHANH.PHANMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055495, NULL, NULL, NULL, N'CHI.NGUYENTHIKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055496, NULL, NULL, NULL, N'THAM.NGUYENTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055497, NULL, NULL, NULL, N'HUONG.HUYNHXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055498, NULL, NULL, NULL, N'QUYEN.TRANTHUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055499, NULL, NULL, NULL, N'TRINH.BUINGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055502, NULL, NULL, NULL, N'HUYEN.NGUYENTHIBICH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055505, NULL, NULL, NULL, N'LINH.NGUYENXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055506, NULL, NULL, NULL, N'DUC.LEHOANGMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055507, NULL, NULL, NULL, N'HUY.VOXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055508, NULL, NULL, NULL, N'DUY.LUUQUOCMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055509, NULL, NULL, NULL, N'QUYNH.NGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055511, NULL, NULL, NULL, N'TU.NGUYENTHICAM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055512, NULL, NULL, NULL, N'TON.TATHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055513, NULL, NULL, NULL, N'VINH.LAIQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
GO
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055518, NULL, NULL, NULL, N'DUYEN.HUYNHTHIKHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055521, NULL, NULL, NULL, N'HIEP.HUYNHCONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055522, NULL, NULL, NULL, N'LINH.MAIHOANG2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055523, NULL, NULL, NULL, N'DUC.CAOKY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055524, NULL, NULL, NULL, N'KHOA.LETRUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055526, NULL, NULL, NULL, N'TUAN.DOANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055527, NULL, NULL, NULL, N'KHOA.LETHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055528, NULL, NULL, NULL, N'MEN.VIENVINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055530, NULL, NULL, NULL, N'TAN.NGUYENDUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055531, NULL, NULL, NULL, N'THAO.NGUYENVYVY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055532, NULL, NULL, NULL, N'PHUC.HOANGNGUYENVINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055533, NULL, NULL, NULL, N'TRI.VOVIET@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055534, NULL, NULL, NULL, N'TAM.TRANNHAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055535, NULL, NULL, NULL, N'DAT.TRANTAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055536, NULL, NULL, NULL, N'HIEN.PHAMDUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055537, NULL, NULL, NULL, N'TAI.LETRONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055541, NULL, NULL, NULL, N'NAM.NGUYENHOAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055543, NULL, NULL, NULL, N'KHOA.NGUYENDICHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055544, NULL, NULL, NULL, N'NGUYEN.VOTHAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055545, NULL, NULL, NULL, N'ANH.LEDIEP@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055546, NULL, NULL, NULL, N'MAI.NGONGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055547, NULL, NULL, NULL, N'PHUONG.VOTHINGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055548, NULL, NULL, NULL, N'MAI.NGUYENTHANHPHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055550, NULL, NULL, NULL, N'VUONG.NGUYENHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055551, NULL, NULL, NULL, N'TAN.HUYNHDUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055552, NULL, NULL, NULL, N'KHANG.DOAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055555, NULL, NULL, NULL, N'HOANG.NGOMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055556, NULL, NULL, NULL, N'YEN.VUNGUYENHAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055558, NULL, NULL, NULL, N'NGHIA.PHANTRONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055560, NULL, NULL, NULL, N'VIET.NGUYENTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055561, NULL, NULL, NULL, N'NGA.DANGTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055562, NULL, NULL, NULL, N'MY.HADIEM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055564, NULL, NULL, NULL, N'ANH.HAQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055565, NULL, NULL, NULL, N'HAI.TRAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055568, NULL, NULL, NULL, N'NGUYEN.LAMTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055572, NULL, NULL, NULL, N'KIEN.NGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055573, NULL, NULL, NULL, N'TRUNG.NGUYENDUC2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055574, NULL, NULL, NULL, N'TUYEN.TRANLAM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055575, NULL, NULL, NULL, N'DIEM.NGUYENLEHOAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055577, NULL, NULL, NULL, N'BAO.TRANHOQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055579, NULL, NULL, NULL, N'GIANG.LETRUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055580, NULL, NULL, NULL, N'VINH.PHANTUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055581, NULL, NULL, NULL, N'AN.HOTHITHUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055582, NULL, NULL, NULL, N'KHANH.PHANQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055584, NULL, NULL, NULL, N'LAN.PHAMDODUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055587, NULL, NULL, NULL, N'DUY.NGOVUTRUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055588, NULL, NULL, NULL, N'HAI.TRUONGMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055590, NULL, NULL, NULL, N'TRUONG.LEDUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055591, NULL, NULL, NULL, N'HUY.LEQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055592, NULL, NULL, NULL, N'VAN.NGUYENLAM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055594, NULL, NULL, NULL, N'ANH.PHAMVOHOAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055596, NULL, NULL, NULL, N'KHIEM.NGUYENTRI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055597, NULL, NULL, NULL, N'KHANH.NGUYENDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055598, NULL, NULL, NULL, N'TUAN.TRANANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055601, NULL, NULL, NULL, N'DUC.THAINGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055602, NULL, NULL, NULL, N'QUY.TRANKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055603, NULL, NULL, NULL, N'TAM.TRANDUYMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055604, NULL, NULL, NULL, N'VIET.NGUYENANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055605, NULL, NULL, NULL, N'THUC.TRUONGVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055607, NULL, NULL, NULL, N'LOC.TRANPHUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055609, NULL, NULL, NULL, N'TRUONG.PHANNHAT2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055610, NULL, NULL, NULL, N'HUY.LYCHAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055613, NULL, NULL, NULL, N'ANH.PHANGIANHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055614, NULL, NULL, NULL, N'SANG.DAOVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055615, NULL, NULL, NULL, N'TRI.TRANMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055616, NULL, NULL, NULL, N'NGHIA.DUONGCAODAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055617, NULL, NULL, NULL, N'KHANH.NGUYENCHAUXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055618, NULL, NULL, NULL, N'GIANG.NGUYENHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055619, NULL, NULL, NULL, N'DUY.NGOQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055621, NULL, NULL, NULL, N'NGOC.DOHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055622, NULL, NULL, NULL, N'TIEN.NGUYENNGOCMY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055623, NULL, NULL, NULL, N'NHI.KHONGTRUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055624, NULL, NULL, NULL, N'TRUNG.NGUYENCONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055626, NULL, NULL, NULL, N'VIET.HOANGQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055627, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055629, NULL, NULL, NULL, N'TU.PHANMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055632, NULL, NULL, NULL, N'PHU.THACHNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055633, NULL, NULL, NULL, N'NGUYEN.TRANDUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055634, NULL, NULL, NULL, N'NHI.QUANGDIEU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055635, NULL, NULL, NULL, N'TRAM.MAINGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055636, NULL, NULL, NULL, N'HIEU.NGUYENTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055638, NULL, NULL, NULL, N'GIANG.NGUYENKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055639, NULL, NULL, NULL, N'LONG.LEDUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055640, NULL, NULL, NULL, N'NGUYEN.NGUYENQUOCBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055641, NULL, NULL, NULL, N'LONG.NGUYENHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055642, NULL, NULL, NULL, N'TRINH.TRANDAC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055644, NULL, NULL, NULL, N'VIET.VUQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055645, NULL, NULL, NULL, N'PHUONG.LUUPHAMXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055646, NULL, NULL, NULL, N'HAI.LUUTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055647, NULL, NULL, NULL, N'TIEP.TRANKHAC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055648, NULL, NULL, NULL, N'PHUOC.VOVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055650, NULL, NULL, NULL, N'LONG.PHANHAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055651, NULL, NULL, NULL, N'HOAI.NGUYENVUTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055652, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055653, NULL, NULL, NULL, N'THANH.PHAMKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055654, NULL, NULL, NULL, N'PHUONG.NGUYENTHINHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055658, NULL, NULL, NULL, N'TIEN.NGUYENMINH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055659, NULL, NULL, NULL, N'SANG.MAIHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055660, NULL, NULL, NULL, N'MAI.DOTHITHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055661, NULL, NULL, NULL, N'TRUNG.TRINHTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
GO
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055662, NULL, NULL, NULL, N'VY.LENGUYENTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055665, NULL, NULL, NULL, N'KHOA.HODIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055667, NULL, NULL, NULL, N'VIET.NGUYENTRONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055668, NULL, NULL, NULL, N'TIN.DINHTRUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055669, NULL, NULL, NULL, N'SU.NGUYENQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055673, NULL, NULL, NULL, N'MAN.TOHOADUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055674, NULL, NULL, NULL, N'TUAN.LEMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055675, NULL, NULL, NULL, N'NHANG.PHAMHOANGNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055680, NULL, NULL, NULL, N'DANG.TRUONGNGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055681, NULL, NULL, NULL, N'THANH.NGUYENTHI2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055682, NULL, NULL, NULL, N'HOA.BUIHUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055683, NULL, NULL, NULL, N'HUNG.NGUYENKHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055684, NULL, NULL, NULL, N'HIEN.CAOQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055685, NULL, NULL, NULL, N'BINH.PHAMVU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055689, NULL, NULL, NULL, N'PON.LAUMENH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055690, NULL, NULL, NULL, N'MAN.HUATHO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055691, NULL, NULL, NULL, N'THAI.DOTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055692, NULL, NULL, NULL, N'BINH.LECHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055694, NULL, NULL, NULL, N'THANG.VUONGVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055697, NULL, NULL, NULL, N'KHOA.TRANANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055698, NULL, NULL, NULL, N'TRUNG.NGUYENDUCQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055699, NULL, NULL, NULL, N'QUY.NGUYENTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055700, NULL, NULL, NULL, N'HUONG.TRANTHUYDIEU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055702, NULL, NULL, NULL, N'PHONG.TANGDIEU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055703, NULL, NULL, NULL, N'SANG.TRANANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055704, NULL, NULL, NULL, N'VU.NGUYENPHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055705, NULL, NULL, NULL, N'THINH.TRANNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055706, NULL, NULL, NULL, N'KHIET.HOANGXUANTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055707, NULL, NULL, NULL, N'HOA.DINHTHIMY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055709, NULL, NULL, NULL, N'NHAN.HOANGNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055710, NULL, NULL, NULL, N'LUON.DUONGNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055711, NULL, NULL, NULL, N'THINH.TRANVU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055712, NULL, NULL, NULL, N'HANH.HUYNHTHIHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055714, NULL, NULL, NULL, N'SIEU.LAYNGHIEP@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055715, NULL, NULL, NULL, N'DUY.PHANKHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055716, NULL, NULL, NULL, N'TRIEU.NGOHUYNHNHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055717, NULL, NULL, NULL, N'HOANG.LETHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055718, NULL, NULL, NULL, N'TRUNG.TRANGHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055722, NULL, NULL, NULL, N'PHU.PHAMLE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055723, NULL, NULL, NULL, N'QUYEN.NGUYENPHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055725, NULL, NULL, NULL, N'YEN.NGUYENPHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055727, NULL, NULL, NULL, N'HIEN.PHANTHIKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055729, NULL, NULL, NULL, N'KHOA.PHAMDANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055730, NULL, NULL, NULL, N'QUANG.TRANVI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055731, NULL, NULL, NULL, N'LONG.NGUYENTHAIVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055732, NULL, NULL, NULL, N'SON.LEVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055733, NULL, NULL, NULL, N'CAN.NGUYENPHUCLONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055734, NULL, NULL, NULL, N'NGAN.TRANTHIKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055736, NULL, NULL, NULL, N'TINH.VOTRUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055737, NULL, NULL, NULL, N'QUANG.THAITUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055740, NULL, NULL, NULL, N'TUNG.LETHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055741, NULL, NULL, NULL, N'DUYEN.TRANTHUYMY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055742, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055743, NULL, NULL, NULL, N'NGON.BUITHUCTRUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055744, NULL, NULL, NULL, N'VINH.VIQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055745, NULL, NULL, NULL, N'THU.LEMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055747, NULL, NULL, NULL, N'LOC.VOBA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055748, NULL, NULL, NULL, N'DUY.LEDANGKHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055751, NULL, NULL, NULL, N'DUNG.NGUYENKIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055752, NULL, NULL, NULL, N'THAN.TRINHVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055753, NULL, NULL, NULL, N'HANH.LETRANMY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055754, NULL, NULL, NULL, N'TIEN.DOANHA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055755, NULL, NULL, NULL, N'NGUYEN.PHANSY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055756, NULL, NULL, NULL, N'DUY.VODINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055758, NULL, NULL, NULL, N'VAN.NGUYENTHICAM2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055760, NULL, NULL, NULL, N'HOA.NGUYENVOTHIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055762, NULL, NULL, NULL, N'VINH.DANGQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055764, NULL, NULL, NULL, N'HOANG.NGUYENVUMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055765, NULL, NULL, NULL, N'ANH.LEDUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055766, NULL, NULL, NULL, N'DAT.BUINHA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055767, NULL, NULL, NULL, N'HUY.TRANNGUYENBINHDUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055768, NULL, NULL, NULL, N'TRUONG.HOANGXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055769, NULL, NULL, NULL, N'TAM.NGOVUBINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055770, NULL, NULL, NULL, N'THAO.PHUNGVUTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055771, NULL, NULL, NULL, N'TRUNG.LEVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055772, NULL, NULL, NULL, N'LIN.DAOO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055774, NULL, NULL, NULL, N'PHONG.TRANTUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055775, NULL, NULL, NULL, N'HAI.PHAMTHE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055776, NULL, NULL, NULL, N'THUAN.NGUYENHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055778, NULL, NULL, NULL, N'TAM.THAIHUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055780, NULL, NULL, NULL, N'TAI.VOTAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055781, NULL, NULL, NULL, N'THUC.THAIVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055782, NULL, NULL, NULL, N'DANG.HOTIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055783, NULL, NULL, NULL, N'DUY.DANGVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055784, NULL, NULL, NULL, N'TAI.VOTAN2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055785, NULL, NULL, NULL, N'QUAN.LAMMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055786, NULL, NULL, NULL, N'ANH.LUONGHUYNH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055787, NULL, NULL, NULL, N'HAI.LEMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055788, NULL, NULL, NULL, N'KHANH.PHAMNHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055790, NULL, NULL, NULL, N'HUYEN.VUONGDIEU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055791, NULL, NULL, NULL, N'HOA.PHANTHITHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055792, NULL, NULL, NULL, N'THANH.DOANNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055793, NULL, NULL, NULL, N'THANH.DODUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055794, NULL, NULL, NULL, N'DANH.NGOTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055795, NULL, NULL, NULL, N'TRIEU.LEDUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055796, NULL, NULL, NULL, N'TRUONG.NGUYENQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055797, NULL, NULL, NULL, N'CUONG.PHANHUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055800, NULL, NULL, NULL, N'QUANG.DOHUUNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055802, NULL, NULL, NULL, N'TUNG.LETHANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055805, NULL, NULL, NULL, N'DUONG.NGUYENPHAMTRUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
GO
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055806, NULL, NULL, NULL, N'NGAN.MAITHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055807, NULL, NULL, NULL, N'HIEP.TRUONGMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055808, NULL, NULL, NULL, N'DUNG.NGUYENDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055809, NULL, NULL, NULL, N'TUE.NGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055810, NULL, NULL, NULL, N'VAN.LETHIHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055813, NULL, NULL, NULL, N'HA.GIANGTONGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055814, NULL, NULL, NULL, N'HOAI.PHAMTHITHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055815, NULL, NULL, NULL, N'Y.HOANGTHITHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055817, NULL, NULL, NULL, N'THINH.VUPHUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055818, NULL, NULL, NULL, N'NHUNG.VUTHIHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055819, NULL, NULL, NULL, N'QUAN.VOLAM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055820, NULL, NULL, NULL, N'TU.MAIAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055821, NULL, NULL, NULL, N'NHI.NGODOANTHIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055823, NULL, NULL, NULL, N'NHON.NGUYENCHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055824, NULL, NULL, NULL, N'VUONG.HOKIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055825, NULL, NULL, NULL, N'HUNG.DOANQUOC2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055828, NULL, NULL, NULL, N'TUAN.HUYNHANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055829, NULL, NULL, NULL, N'LINH.TRANDOAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055830, NULL, NULL, NULL, N'DUNG.VUVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055834, NULL, NULL, NULL, N'LONG.TRANBACH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055835, NULL, NULL, NULL, N'TRUNG.HOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055836, NULL, NULL, NULL, N'NGUYEN.HUYNHDUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055837, NULL, NULL, NULL, N'BINH.HUYNHTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055839, NULL, NULL, NULL, N'PHUONG.NGUYENNAM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055841, NULL, NULL, NULL, N'HA.HUYNHTHIDIEM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055843, NULL, NULL, NULL, N'TAN.LUONGNHUT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055844, NULL, NULL, NULL, N'TRI.DINHQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055845, NULL, NULL, NULL, N'MI.CHAUTHITRA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055847, NULL, NULL, NULL, N'PHUONG.NGUYENTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055848, NULL, NULL, NULL, N'TAN.MAIVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055849, NULL, NULL, NULL, N'HAO.TRANVU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055850, NULL, NULL, NULL, N'MINH.LENGUYENANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055851, NULL, NULL, NULL, N'PHONG.TRANMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055852, NULL, NULL, NULL, N'DIEU.TRUONGTHITHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055853, NULL, NULL, NULL, N'TUAN.LETHANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055854, NULL, NULL, NULL, N'TAM.NGUYENXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055860, NULL, NULL, NULL, N'TAN.TUNGONHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055861, NULL, NULL, NULL, N'THAO.BUITHIMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055863, NULL, NULL, NULL, N'YEN.NGUYENPHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055865, NULL, NULL, NULL, N'TRAN.PHAMBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055867, NULL, NULL, NULL, N'TRAM.NGUYENTHIBICH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055868, NULL, NULL, NULL, N'LOAN.HOANGTHIPHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055869, NULL, NULL, NULL, N'AN.VODINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055870, NULL, NULL, NULL, N'DUONG.VOTHITHUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055871, NULL, NULL, NULL, N'HAU.HATRUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055872, NULL, NULL, NULL, N'CHHE.GOIDU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055874, NULL, NULL, NULL, N'HUY.LEHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055875, NULL, NULL, NULL, N'NGUYEN.NGUYENDIEPLE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055877, NULL, NULL, NULL, N'THIEN.HOTAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055880, NULL, NULL, NULL, N'VUONG.NGUYENDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055882, NULL, NULL, NULL, N'CHUNG.HAVU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055883, NULL, NULL, NULL, N'CUONG.NGUYENROANMANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055884, NULL, NULL, NULL, N'NGOAN.TONGVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055885, NULL, NULL, NULL, N'TRI.LEMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055886, NULL, NULL, NULL, N'TOAN.VOTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055887, NULL, NULL, NULL, N'SAN.TRANCONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055889, NULL, NULL, NULL, N'BINH.THAIVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055890, NULL, NULL, NULL, N'HUNG.NGUYENHUUKHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055891, NULL, NULL, NULL, N'TOAN.TRANTHIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055892, NULL, NULL, NULL, N'UYEN.TRANTHIPHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055894, NULL, NULL, NULL, N'TUYEN.VOTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055895, NULL, NULL, NULL, N'CUONG.NGUYENTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055898, NULL, NULL, NULL, N'THIEN.DUONGLEVU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055899, NULL, NULL, NULL, N'LOC.NGUYENTAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055900, NULL, NULL, NULL, N'LAM.TRUONGHOANGDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055901, NULL, NULL, NULL, N'LAN.VUTHIHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055902, NULL, NULL, NULL, N'DUYEN.HOHOANGTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055903, NULL, NULL, NULL, N'HUY.NGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055905, NULL, NULL, NULL, N'TAN.NGUYENDANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055906, NULL, NULL, NULL, N'BINH.DOQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055907, NULL, NULL, NULL, N'CUONG.NGUYENPHU2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055908, NULL, NULL, NULL, N'TAM.TRANMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055910, NULL, NULL, NULL, N'PHUC.DAUTRANHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055911, NULL, NULL, NULL, N'CHUC.DINHQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11055912, NULL, NULL, NULL, N'SON.VUCHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11063677, NULL, NULL, NULL, N'MAI.LETHINGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11124829, NULL, NULL, NULL, N'TRI.DANGQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11130799, NULL, NULL, NULL, N'THACH.KIEUBUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11130802, NULL, NULL, NULL, N'HANH.TRUONGQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11130805, NULL, NULL, NULL, N'NHA.NGUYENTHIVUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11130808, NULL, NULL, NULL, N'DAT.LETIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11130809, NULL, NULL, NULL, N'NGOC.TRUONGBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11130810, NULL, NULL, NULL, N'DUY.VONHAT2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11130811, NULL, NULL, NULL, N'MY.QUACHTUYET@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11130814, NULL, NULL, NULL, N'DANG.NGOTRANKHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11137191, NULL, NULL, NULL, N'RECEPTION.RBVH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138663, NULL, NULL, NULL, N'NGUYEN.NGUYENTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138669, NULL, NULL, NULL, N'OAI.DOANTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138672, NULL, NULL, NULL, N'HA.NGUYENVUHAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138703, NULL, NULL, NULL, N'HUNG.NGUYENVIET@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138705, NULL, NULL, NULL, N'BINH.PHAMBAHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138707, NULL, NULL, NULL, N'KIET.LETUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138711, NULL, NULL, NULL, N'BINH.NGUYENVUTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138712, NULL, NULL, NULL, N'QUYNH.LUONGTHAITHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138714, NULL, NULL, NULL, N'NHUNG.TRANTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138715, NULL, NULL, NULL, N'NHUT.VOVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138716, NULL, NULL, NULL, N'THAO.TRANTHIXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138721, NULL, NULL, NULL, N'TIN.NGUYENHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138722, NULL, NULL, NULL, N'NGUYEN.PHAMKHOI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11138724, NULL, NULL, NULL, N'THUAN.LEMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
GO
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11140017, NULL, NULL, NULL, N'HUYNH.DOGIA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11140018, NULL, NULL, NULL, N'TUAN.PHAMMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11141007, NULL, NULL, NULL, N'XUYEN.LENGUYENKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11141015, NULL, NULL, NULL, N'DAI.PHAMHOQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11141019, NULL, NULL, NULL, N'NGHIA.DOTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11141024, NULL, NULL, NULL, N'TINH.PHANVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11141026, NULL, NULL, NULL, N'DONG.NGUYENHOANGPHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11141028, NULL, NULL, NULL, N'HUNG.NGUYENLEXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11141032, NULL, NULL, NULL, N'AN.NGUYENTHITHIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11141036, NULL, NULL, NULL, N'VI.TRANDANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11141040, NULL, NULL, NULL, N'CUONG.NGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11141042, NULL, NULL, NULL, N'HA.NGUYENTHINGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11141048, NULL, NULL, NULL, N'MINH.NGUYENDANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11142457, NULL, NULL, NULL, N'CONG.NGUYENTHANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11142916, NULL, NULL, NULL, N'DUNG.KHUONGANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143484, NULL, NULL, NULL, N'THAM.NGUYENTHI2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143485, NULL, NULL, NULL, N'HUONG.PHAMTHITHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143486, NULL, NULL, NULL, N'TRANG.LETHITHUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143488, NULL, NULL, NULL, N'TAI.LETIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143489, NULL, NULL, NULL, N'DUY.TRUONGDUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143493, NULL, NULL, NULL, N'NHAN.BUIHUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143494, NULL, NULL, NULL, N'HANG.LETHUYTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143495, NULL, NULL, NULL, N'THANG.MAIANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143496, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143499, NULL, NULL, NULL, N'LAN.LENGOCHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143503, NULL, NULL, NULL, N'HOAN.NGUYENVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143504, NULL, NULL, NULL, N'VAN.TRIEUTHE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143505, NULL, NULL, NULL, N'THIEN.NGUYENDANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143506, NULL, NULL, NULL, N'TUAN.NGUYENOANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143507, NULL, NULL, NULL, N'KHOA.TRANANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143508, NULL, NULL, NULL, N'CUONG.BUIDUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143509, NULL, NULL, NULL, N'TRUNG.TRANBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143510, NULL, NULL, NULL, N'DUC.NGUYENANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143511, NULL, NULL, NULL, N'DUY.BAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143512, NULL, NULL, NULL, N'HOI.TRANNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143513, NULL, NULL, NULL, N'HUONG.TRINHTHIXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143514, NULL, NULL, NULL, N'THANH.CHECONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143515, NULL, NULL, NULL, N'HOA.PHAMNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143516, NULL, NULL, NULL, N'THAO.TRANVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143517, NULL, NULL, NULL, N'HUY.MAIDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143519, NULL, NULL, NULL, N'HIEU.NGUYENTRUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143520, NULL, NULL, NULL, N'DUY.TRUONGANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143521, NULL, NULL, NULL, N'NHAN.NGUYENVUTRONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143522, NULL, NULL, NULL, N'CUONG.HAQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143523, NULL, NULL, NULL, N'DOANTHANH.THIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143546, NULL, NULL, NULL, N'QUANG.NGUYENNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143551, NULL, NULL, NULL, N'TUNG.DAONHU2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143554, NULL, NULL, NULL, N'DUC.BUIMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143556, NULL, NULL, NULL, N'NGOC.NGUYENTHIBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143557, NULL, NULL, NULL, N'TRUNG.HUYNHCHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143558, NULL, NULL, NULL, N'HIEU.NGUYEN2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143561, NULL, NULL, NULL, N'TOAN.NGUYENBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143564, NULL, NULL, NULL, N'MAN.HUYNHMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143566, NULL, NULL, NULL, N'CHIEU.BUIQUANGNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143567, NULL, NULL, NULL, N'NAM.HONGUYENQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143581, NULL, NULL, NULL, N'THANG.TRANVIET@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143584, NULL, NULL, NULL, N'PHUONG.TRINHTHIXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143585, NULL, NULL, NULL, N'HANH.TRANTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143596, NULL, NULL, NULL, N'DUC.BUIQUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143631, NULL, NULL, NULL, N'HUONG.LENGOCTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143633, NULL, NULL, NULL, N'NGAN.VOTHIBICH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143637, NULL, NULL, NULL, N'PHUC.BUINGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143639, NULL, NULL, NULL, N'TRUNG.NGUYENDUC3@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143641, NULL, NULL, NULL, N'VU.LETAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143644, NULL, NULL, NULL, N'BAO.TRANHOAI2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143645, NULL, NULL, NULL, N'VIET.HOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143649, NULL, NULL, NULL, N'TRAN.LANGTHIXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143651, NULL, NULL, NULL, N'HAN.HUYNHTRUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143652, NULL, NULL, NULL, N'NHAN.DUONGTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143654, NULL, NULL, NULL, N'VUONG.HOQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143657, NULL, NULL, NULL, N'SANG.TRANHO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143658, NULL, NULL, NULL, N'DINH.THIEUTHIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143660, NULL, NULL, NULL, N'HIEN.KIEUCONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143661, NULL, NULL, NULL, N'HUNG.TRANQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143662, NULL, NULL, NULL, N'THO.NGUYENLOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143668, NULL, NULL, NULL, N'DAT.TRANQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143670, NULL, NULL, NULL, N'KHOA.HUYNHCHAUDANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143672, NULL, NULL, NULL, N'PHUONG.LENGOCMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143675, NULL, NULL, NULL, N'VY.VOTHUYTHUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143678, NULL, NULL, NULL, N'PHU.NGUYENPHAMTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143683, NULL, NULL, NULL, N'DIEM.NGODINHLE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143685, NULL, NULL, NULL, N'TAI.TRAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143686, NULL, NULL, NULL, N'HOA.PHANTHIMAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143688, NULL, NULL, NULL, N'TUYEN.NGUYENTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143694, NULL, NULL, NULL, N'TRI.PHAMDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143697, NULL, NULL, NULL, N'TIEN.HUYNHNHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143701, NULL, NULL, NULL, N'TRINH.TRANNGUYENNGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143709, NULL, NULL, NULL, N'LINH.DUONGDOANKIEU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143712, NULL, NULL, NULL, N'VINH.VODANGNHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143715, NULL, NULL, NULL, N'HIEP.NGUYENTIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143720, NULL, NULL, NULL, N'TRIEN.DUONGVI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143722, NULL, NULL, NULL, N'HOAN.NGUYENTHICAM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143724, NULL, NULL, NULL, N'DIEM.NGUYENTHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143732, NULL, NULL, NULL, N'HOP.VOTHI@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143733, NULL, NULL, NULL, N'THU.PHANHOANGANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143734, NULL, NULL, NULL, N'AN.PHAMTRANTHIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143740, NULL, NULL, NULL, N'HA.NGUYENNGAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143742, NULL, NULL, NULL, N'KHOI.NGUYENLEANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143962, NULL, NULL, NULL, N'HA.HUYNHTHIMAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143963, NULL, NULL, NULL, N'CHINH.NGUYENDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
GO
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143964, NULL, NULL, NULL, N'SUOL.TOVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143965, NULL, NULL, NULL, N'HUY.TRANDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143966, NULL, NULL, NULL, N'CHI.NGUYENHUYNHKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143977, NULL, NULL, NULL, N'HIEP.BUIDUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143978, NULL, NULL, NULL, N'THU.DUONGLEMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143980, NULL, NULL, NULL, N'MY.PHANTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143981, NULL, NULL, NULL, N'KHOA.NGUYENVUNHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143982, NULL, NULL, NULL, N'TUAN.DOVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143983, NULL, NULL, NULL, N'HUNG.PHUNGTUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143985, NULL, NULL, NULL, N'LOC.TRANTHITHO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143986, NULL, NULL, NULL, N'HOANG.NGUYENVINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143987, NULL, NULL, NULL, N'KHUYEN.VUTHIVANH@JP.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143988, NULL, NULL, NULL, N'THANH.NGUYENTHITHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11143989, NULL, NULL, NULL, N'HA.TRINHAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144017, NULL, NULL, NULL, N'THAO.DOANDUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144021, NULL, NULL, NULL, N'HAO.PHANTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144022, NULL, NULL, NULL, N'NGUYEN.PHAMCAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144023, NULL, NULL, NULL, N'HIEU.LECHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144025, NULL, NULL, NULL, N'TRI.TRANGKIEU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144026, NULL, NULL, NULL, N'DUONG.NGUYENHAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144027, NULL, NULL, NULL, N'ANH.DOTUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144028, NULL, NULL, NULL, N'THINH.NGUYENXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144030, NULL, NULL, NULL, N'CONG.LECHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144032, NULL, NULL, NULL, N'VU.PHAMNGUYENANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144033, NULL, NULL, NULL, N'TUNG.DAODUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144035, NULL, NULL, NULL, N'TRUONG.DAODOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144036, NULL, NULL, NULL, N'ANH.PHAMVOTUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144038, NULL, NULL, NULL, N'HA.HOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144039, NULL, NULL, NULL, N'KIEU.TRANTHIMONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144041, NULL, NULL, NULL, N'THUAN.NGUYENCONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144043, NULL, NULL, NULL, N'THANG.NGUYENLENHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144045, NULL, NULL, NULL, N'QUY.NGUYENDUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144046, NULL, NULL, NULL, N'TAN.LEVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144047, NULL, NULL, NULL, N'LAM.DOTHE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144050, NULL, NULL, NULL, N'SINH.LETRUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144051, NULL, NULL, NULL, N'TUNG.VUANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144052, NULL, NULL, NULL, N'TUNG.THAIANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144053, NULL, NULL, NULL, N'PHAT.DUONGKHAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144054, NULL, NULL, NULL, N'QUAN.BUILANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144055, NULL, NULL, NULL, N'THIEN.NGUYENCHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144056, NULL, NULL, NULL, N'VINH.NGUYENTUAN2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144057, NULL, NULL, NULL, N'PRAVEEN.B@IN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144062, NULL, NULL, NULL, N'DUONG.DANGNGOCQUYNH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144066, NULL, NULL, NULL, N'HAI.VOQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144067, NULL, NULL, NULL, N'HOA.TRANQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144071, NULL, NULL, NULL, N'PHUONG.PHAMDINHDUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144122, NULL, NULL, NULL, N'NGHIA.LAITRONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144123, NULL, NULL, NULL, N'LE.LEHIEU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144125, NULL, NULL, NULL, N'THANH.TRANCHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144129, NULL, NULL, NULL, N'TOAN.LETHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144131, NULL, NULL, NULL, N'MINH.NGUYENNHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144914, NULL, NULL, NULL, N'GIANG.TRANGHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11144917, NULL, NULL, NULL, N'TUAN.NGUYENDANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11146835, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147056, NULL, NULL, NULL, N'HIEU.BUITRONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147066, NULL, NULL, NULL, N'HUU.HUYNHCHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147067, NULL, NULL, NULL, N'QUYEN.LETHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147069, NULL, NULL, NULL, N'KIEN.BUITRUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147070, NULL, NULL, NULL, N'DUNG.NGUYENTRUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147071, NULL, NULL, NULL, N'HUY.NGUYENQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147073, NULL, NULL, NULL, N'DUONG.NGUYENTHEDAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147103, NULL, NULL, NULL, N'DUY.DANGNGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147104, NULL, NULL, NULL, N'TAI.VOVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147105, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147108, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147109, NULL, NULL, NULL, N'THIEN.TRANNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147505, NULL, NULL, NULL, N'CHUONG.NGUYENTHANHTHIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147506, NULL, NULL, NULL, N'TRINH.NGUYENTHINGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147510, NULL, NULL, NULL, N'THAO.TRANTHANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147515, NULL, NULL, NULL, N'HIEU.LEDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11147576, NULL, NULL, NULL, N'HIEU.NGUYENQUANGTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11148099, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11150620, NULL, NULL, NULL, N'CHAN.PHANVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11150621, NULL, NULL, NULL, N'LOAN.NGOTHIHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11150622, NULL, NULL, NULL, N'BINH.NGUYENCONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11150623, NULL, NULL, NULL, N'DUONG.DUONGTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11150624, NULL, NULL, NULL, N'AN.HOBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11150625, NULL, NULL, NULL, N'CHANH.TRUONGQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11150626, NULL, NULL, NULL, N'HOANG.NGUYENHUAMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11150627, NULL, NULL, NULL, N'VU.NGUYENTRANDUONGHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11150628, NULL, NULL, NULL, N'CHUONG.VOHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11150629, NULL, NULL, NULL, N'DUY.LEHOANGTUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11150630, NULL, NULL, NULL, N'TIEN.NGUYENTHITHUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11150631, NULL, NULL, NULL, N'PHUNG.LAYKHIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11150632, NULL, NULL, NULL, N'LANH.VUTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11151481, NULL, NULL, NULL, N'NHI.NGUYENXUANTHAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11151741, NULL, NULL, NULL, N'LINH.TRANTHIKIEU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11154388, NULL, NULL, NULL, N'TRANG.LETHITHUY2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11154654, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155108, NULL, NULL, NULL, N'KHAI.TRANMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155109, NULL, NULL, NULL, N'THANH.LEDAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155112, NULL, NULL, NULL, N'HUNG.NGUYENMINH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155113, NULL, NULL, NULL, N'DUNG.DOANTRI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155142, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155151, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155242, NULL, NULL, NULL, N'MINH.NGUYENVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155247, NULL, NULL, NULL, N'GIANG.NGUYENTRUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155255, NULL, NULL, NULL, N'AN.TRANNHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155257, NULL, NULL, NULL, N'SANG.HOMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155282, NULL, NULL, NULL, N'CHIEN.TRANTHIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
GO
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155285, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155866, NULL, NULL, NULL, N'PHUONG.PHAMXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155867, NULL, NULL, NULL, N'NHI.BANHMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11155868, NULL, NULL, NULL, N'NAM.VOMAIQUANG2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11156354, NULL, NULL, NULL, N'TRI.NGUYENMINH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11158932, NULL, NULL, NULL, N'LU.NGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11158948, NULL, NULL, NULL, N'NGOC.TONGLETHAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159002, NULL, NULL, NULL, N'TUNG.NGUYENNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159006, NULL, NULL, NULL, N'TUAN.TRANVIET@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159010, NULL, NULL, NULL, N'HAI.NGUYENCONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159012, NULL, NULL, NULL, N'NAM.CHAUHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159014, NULL, NULL, NULL, N'THAI.NGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159017, NULL, NULL, NULL, N'TAN.LYHUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159021, NULL, NULL, NULL, N'TRUONG.TRANVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159023, NULL, NULL, NULL, N'DUY.NGUYENLE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159025, NULL, NULL, NULL, N'TAI.NGUYENTHANH3@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159032, NULL, NULL, NULL, N'THANH.DUONGHIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159034, NULL, NULL, NULL, N'LONG.NGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159036, NULL, NULL, NULL, N'KHOA.NGUYENANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159131, NULL, NULL, NULL, N'LOAN.NGUYENTHIKIM2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159132, NULL, NULL, NULL, N'TRI.VOCAOTHIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159144, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159162, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159166, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11159168, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11160395, NULL, NULL, NULL, N'NHAN.NGUYENTHITHANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11160400, NULL, NULL, NULL, N'KIRAN.SURYAWANSHI@IN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11160996, NULL, NULL, NULL, N'SANG.VOVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162933, NULL, NULL, NULL, N'TAN.LEMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162934, NULL, NULL, NULL, N'PHUONG.TRUONGTOAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162936, NULL, NULL, NULL, N'HAO.HAHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162938, NULL, NULL, NULL, N'NGUYEN.TRANTRINHKHOI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162942, NULL, NULL, NULL, N'DONG.LEQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162944, NULL, NULL, NULL, N'DI.DIEPMY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162946, NULL, NULL, NULL, N'LUAN.PHAMNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162948, NULL, NULL, NULL, N'HAI.TRANVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162953, NULL, NULL, NULL, N'QUAN.PHAMMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162957, NULL, NULL, NULL, N'CANH.NGUYENNHO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162958, NULL, NULL, NULL, N'QUANG.TRANDUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162959, NULL, NULL, NULL, N'HUNG.NGUYENPHUCBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162961, NULL, NULL, NULL, N'TRUNG.HODUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11162966, NULL, NULL, NULL, N'NHAN.VONGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11163000, NULL, NULL, NULL, N'THIEN.NGUYENVIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11163002, NULL, NULL, NULL, N'THUY.TRANQUANGDAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11163004, NULL, NULL, NULL, N'HAI.BUITHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11163016, NULL, NULL, NULL, N'LOC.NGUYENXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11163019, NULL, NULL, NULL, N'TRIET.NGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11163021, NULL, NULL, NULL, N'PHUC.VOTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11164690, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11165385, NULL, NULL, NULL, N'KIM.NGUYENDOTHIEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11165734, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11165741, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166794, NULL, NULL, NULL, N'PHONG.NGUYENHOAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166797, NULL, NULL, NULL, N'THIEN.THAIXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166798, NULL, NULL, NULL, N'LIEM.PHAMTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166800, NULL, NULL, NULL, N'HOANG.PHANXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166801, NULL, NULL, NULL, N'VIET.NGUYENQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166821, NULL, NULL, NULL, N'LUAN.NGUYENCAOTRONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166822, NULL, NULL, NULL, N'DONG.PHAMVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166826, NULL, NULL, NULL, N'PHONG.TRANQUANGNGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166828, NULL, NULL, NULL, N'DINH.NGUYENNGHIA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166846, NULL, NULL, NULL, N'NAM.LEVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166852, NULL, NULL, NULL, N'LAM.HOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166854, NULL, NULL, NULL, N'DAT.LEHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166856, NULL, NULL, NULL, N'TU.BUICAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166875, NULL, NULL, NULL, N'TRUNG.DANGDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166880, NULL, NULL, NULL, N'MINH.TRANHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166897, NULL, NULL, NULL, N'DUYEN.BUITHITUYET@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166902, NULL, NULL, NULL, N'KY.TRUONGCONGZU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166905, NULL, NULL, NULL, N'LONG.NGUYENDANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166906, NULL, NULL, NULL, N'VINH.LUONGNHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11166912, NULL, NULL, NULL, N'TRUNG.NGUYENDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11167119, NULL, NULL, NULL, N'HUY.DUONGQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11167343, NULL, NULL, NULL, N'KHIEM.LEHUYNH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11167516, NULL, NULL, NULL, N'ANH.PHAMNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168568, NULL, NULL, NULL, N'MAI.PHAMXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168621, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168624, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168631, NULL, NULL, NULL, N'DZU.NGUYENHOAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168633, NULL, NULL, NULL, N'DAO.NGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168635, NULL, NULL, NULL, N'NHAN.DOVU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168806, NULL, NULL, NULL, N'SANG.NGUYENDANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168807, NULL, NULL, NULL, N'BINH.DINHHUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168808, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168809, NULL, NULL, NULL, N'LONG.NGUYENBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168819, NULL, NULL, NULL, N'KIET.NGUYENANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168820, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168822, NULL, NULL, NULL, N'HO.LEGIANGLONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168823, NULL, NULL, NULL, N'NGAN.NGUYENKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168825, NULL, NULL, NULL, N'CUONG.DOTHE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168828, NULL, NULL, NULL, N'THANG.VU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11168982, NULL, NULL, NULL, N'QUYNHMAI.HOANG@SG.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11169379, NULL, NULL, NULL, N'HOA.TRANHUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11170141, NULL, NULL, NULL, N'CUONG.PHAMQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11172399, NULL, NULL, NULL, N'THAI.DANGMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11172400, NULL, NULL, NULL, N'VINH.BUIVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11172403, NULL, NULL, NULL, N'CHIEN.PHAMVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11172405, NULL, NULL, NULL, N'NAM.NGUYENTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11172406, NULL, NULL, NULL, N'GIANG.DAOTU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11172407, NULL, NULL, NULL, N'NINH.NGUYENXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
GO
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11172409, NULL, NULL, NULL, N'ANH.NGUYENNHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11172413, NULL, NULL, NULL, N'TAN.NGONHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11172415, NULL, NULL, NULL, N'CHAU.NGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11172416, NULL, NULL, NULL, N'DUY.NGUYENNGOC2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11172736, NULL, NULL, NULL, N'QUYNH.NGUYENQUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11172953, NULL, NULL, NULL, N'FIXED-TERM.TRINH.THIHONGHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11172954, NULL, NULL, NULL, N'TRANG.NINHTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11173276, NULL, NULL, NULL, N'TUAN.NGUYENNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175532, NULL, NULL, NULL, N'SEN.NGUYENTHI2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175593, NULL, NULL, NULL, N'DUNG.NGUYENHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175595, NULL, NULL, NULL, N'LONG.NGUYENVY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175596, NULL, NULL, NULL, N'TAI.TRUONGTAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175603, NULL, NULL, NULL, N'LONG.THAIQUANGBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175605, NULL, NULL, NULL, N'KHAI.VONGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175606, NULL, NULL, NULL, N'KHANH.NGUYENNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175608, NULL, NULL, NULL, N'TUNG.LETHANH4@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175610, NULL, NULL, NULL, N'PHAT.PHAMBA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175611, NULL, NULL, NULL, N'NHAN.PHUNGDANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175612, NULL, NULL, NULL, N'VINH.PHAMHUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175614, NULL, NULL, NULL, N'TRANG.HATHITHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175615, NULL, NULL, NULL, N'HUAN.NGUYENHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11175616, NULL, NULL, NULL, N'CHAU.PHAMLEMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11178254, NULL, NULL, NULL, N'HAI.DUONGCONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11178258, NULL, NULL, NULL, N'TRANG.NGUYENTHIBICH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11178265, NULL, NULL, NULL, N'TU.TRANTHICAM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11178267, NULL, NULL, NULL, N'UYEN.HOANGLEPHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11178268, NULL, NULL, NULL, N'PHONG.PHAMVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11178269, NULL, NULL, NULL, N'TRUC.NGUYENTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11178271, NULL, NULL, NULL, N'LONG.LEQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11178272, NULL, NULL, NULL, N'MINH.VUNHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11178273, NULL, NULL, NULL, N'PHUONG.HUYNHNHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11178274, NULL, NULL, NULL, N'VAN.TRANTHITHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11178275, NULL, NULL, NULL, N'BAC.HUYNHTRUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11180200, NULL, NULL, NULL, N'KHOA.TRIEUDANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11180203, NULL, NULL, NULL, N'THIEN.VOHOANGTAM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11180204, NULL, NULL, NULL, N'HUNG.NGUYENDANG2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11180206, NULL, NULL, NULL, N'CUONG.PHAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11180208, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11180215, NULL, NULL, NULL, N'CONG.VOTHIHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11183064, NULL, NULL, NULL, N'KIEU.TRANTHUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11183807, NULL, NULL, NULL, N'HUY.VANNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11187583, NULL, NULL, NULL, N'TOAN.DAOTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188054, NULL, NULL, NULL, N'LONG.VOMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188056, NULL, NULL, NULL, N'ANH.NGUYENQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188057, NULL, NULL, NULL, N'BAO.LETRANGIA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188059, NULL, NULL, NULL, N'TRUC.VOTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188060, NULL, NULL, NULL, N'HAI.HUYNHTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188061, NULL, NULL, NULL, N'NHO.PHAMTHIHOAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188062, NULL, NULL, NULL, N'BAO.LEGIA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188063, NULL, NULL, NULL, N'BINH.LYDIEU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188064, NULL, NULL, NULL, N'HIEN.TRANTHITHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188068, NULL, NULL, NULL, N'BA.TRANVAN2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188070, NULL, NULL, NULL, N'THAI.LAMTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188071, NULL, NULL, NULL, N'THINH.NGUYENVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188073, NULL, NULL, NULL, N'LINH.DOTHANHTHUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188130, NULL, NULL, NULL, N'THU.LEHANHPHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11188561, NULL, NULL, NULL, N'QUYNH.NGUYENDUCHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11190098, NULL, NULL, NULL, N'YEN.LETHIHAI2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11190535, NULL, NULL, NULL, N'KHANH.HOANGCHAU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11190537, NULL, NULL, NULL, N'HUONG.HUYNHTHITHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11190538, NULL, NULL, NULL, N'NGHIA.TRANHUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11190539, NULL, NULL, NULL, N'VU.BUIDUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11190540, NULL, NULL, NULL, N'QUYET.PHAMNGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11190542, NULL, NULL, NULL, N'KHOI.LEBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11190544, NULL, NULL, NULL, N'ANH.NGUYENNHUT@BCN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11190547, NULL, NULL, NULL, N'DAT.NGUYENVAN2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11190548, NULL, NULL, NULL, N'THE.PHAMHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11190550, NULL, NULL, NULL, N'CUONG.NGUYENVAN2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11190553, NULL, NULL, NULL, N'VU.NGUYENCAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11190811, NULL, NULL, NULL, N'HOAN.TRANVIET@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11191746, NULL, NULL, NULL, N'QUAN.MAIVIET@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11191749, NULL, NULL, NULL, N'HUY.VOANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11191750, NULL, NULL, NULL, N'DUONG.VUDUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11193444, NULL, NULL, NULL, N'NGHIA.LEHUU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11193445, NULL, NULL, NULL, N'TRI.NGOHAVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11193446, NULL, NULL, NULL, N'NAM.NGUYENTHANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11193447, NULL, NULL, NULL, N'NGOC.NGUYENTHE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11193448, NULL, NULL, NULL, N'HAI.TRANQUOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11193449, NULL, NULL, NULL, N'PHUONG.NGUYENLE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11193450, NULL, NULL, NULL, N'LUAN.VOVIET@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11193451, NULL, NULL, NULL, N'TRUC.NGUYENHIEU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11193452, NULL, NULL, NULL, N'HUYEN.NGUYENTRANBICH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11193453, NULL, NULL, NULL, N'NGAN.LYKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11193454, NULL, NULL, NULL, N'KHOA.TRANANH3@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11193477, NULL, NULL, NULL, N'FIXED-TERM.VI.LENGOCCHUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11193482, NULL, NULL, NULL, N'CUONG.NGUYENXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11194047, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11194315, NULL, NULL, NULL, N'TUAN.THAIHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11196025, NULL, NULL, NULL, N'MINH.TRANQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11196268, NULL, NULL, NULL, N'QUY.HUYNHDUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11196273, NULL, NULL, NULL, N'DUNG.TRANTRUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11196284, NULL, NULL, NULL, N'TRUNG.NGUYENTHANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11196287, NULL, NULL, NULL, N'HOANG.NGUYENXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11196290, NULL, NULL, NULL, N'LINH.VANTHUYNGUYET@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11196296, NULL, NULL, NULL, N'TAM.NGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11196996, NULL, NULL, NULL, N'THANG.LENGOC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11199632, NULL, NULL, NULL, N'QUAN.NGUYENTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11199633, NULL, NULL, NULL, N'ANH.NGUYENHOANG2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11199634, NULL, NULL, NULL, N'NHAN.LEMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11199635, NULL, NULL, NULL, N'THE.DOANBUIMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
GO
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11199636, NULL, NULL, NULL, N'HOANG.DINHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11199637, NULL, NULL, NULL, N'HUONG.TRANTHITHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11199638, NULL, NULL, NULL, N'DONG.NGUYENDUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11199639, NULL, NULL, NULL, N'HOANG.CHUVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11199640, NULL, NULL, NULL, N'DUNG.LETHIMY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11199642, NULL, NULL, NULL, N'ANH.BUIMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11200061, NULL, NULL, NULL, N'DIEN.NGUYENDANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11200193, NULL, NULL, NULL, N'DUONG.PHAMTHAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11200210, NULL, NULL, NULL, N'LAM.TRANTHANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11202119, NULL, NULL, NULL, N'DUY.MAIDUC@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11202121, NULL, NULL, NULL, N'THANH.VUVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11202122, NULL, NULL, NULL, N'THUY.PHAMTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11202123, NULL, NULL, NULL, N'NHAN.NGUYENTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11202124, NULL, NULL, NULL, N'OANH.NGUYENHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11202126, NULL, NULL, NULL, N'NGOI.TOKIM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11202128, NULL, NULL, NULL, N'RON.SON@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11202129, NULL, NULL, NULL, N'TUAN.PHAMVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11202131, NULL, NULL, NULL, N'NGOC.NGUYENPHUONGYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11203211, NULL, NULL, NULL, N'DUY.NGUYENTUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11203214, NULL, NULL, NULL, N'KIEN.NGUYENVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11204385, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205458, NULL, NULL, NULL, N'THANH.LAMQUOC2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205459, NULL, NULL, NULL, N'TRUONG.LUUBA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205462, NULL, NULL, NULL, N'TRUONG.TRANNHAT@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205463, NULL, NULL, NULL, N'BINH.TRANTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205464, NULL, NULL, NULL, N'MAN.LETHIDIEM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205465, NULL, NULL, NULL, N'TRINH.NGUYENTHIMY2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205466, NULL, NULL, NULL, N'PHU.DIEPGIA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205468, NULL, NULL, NULL, N'DAO.DOAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205469, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205470, NULL, NULL, NULL, N'TRI.TRIEUNGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205471, NULL, NULL, NULL, N'BUU.LEPHU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205474, NULL, NULL, NULL, N'TUAN.NGUYENXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205475, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205476, NULL, NULL, NULL, N'NIEM.DODOAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205477, NULL, NULL, NULL, N'TINH.NGUYENBA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205479, NULL, NULL, NULL, N'TUONG.LELY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205481, NULL, NULL, NULL, N'DUONG.LUONGVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205687, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205717, NULL, NULL, NULL, N'NGHI.TRANBANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11205719, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211154, NULL, NULL, NULL, N'TRAN.HOANGPHANBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211156, NULL, NULL, NULL, N'DAT.NGUYENCONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211157, NULL, NULL, NULL, N'HA.TRANHOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211161, NULL, NULL, NULL, N'HAI.DINHNGOCNGUYEN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211165, NULL, NULL, NULL, N'TRUNG.VOQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211167, NULL, NULL, NULL, N'LONG.HAVIET@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211168, NULL, NULL, NULL, N'VU.PHAMANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211170, NULL, NULL, NULL, N'TRA.TRIEUQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211172, NULL, NULL, NULL, N'VINH.TRANTHANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211175, NULL, NULL, NULL, N'DUONG.TRUONGHUYNHHUONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211177, NULL, NULL, NULL, N'PHUONG.NGUYENTHIMAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211178, NULL, NULL, NULL, N'THUONG.TRANLESONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211180, NULL, NULL, NULL, N'TRAM.NGUYENHUYNHBICH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11211190, NULL, NULL, NULL, N'NGUYEN.NGUYENLEBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11212470, NULL, NULL, NULL, N'ANH.NGUYENXUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11212471, NULL, NULL, NULL, N'HOAN.PHAMLE@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11212899, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11212905, NULL, NULL, NULL, N'ANH.NGUYENDOANBAO@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11214628, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11214666, NULL, NULL, NULL, N'HANG.TRANTHIBICH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11214667, NULL, NULL, NULL, N'LONG.TRANPHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11214669, NULL, NULL, NULL, N'THUC.NGUYENMINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11214670, NULL, NULL, NULL, N'HUAN.NGUYENVU@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11214673, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11214674, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11214678, NULL, NULL, NULL, N'DUONG.NGUYENTRUNG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11215592, NULL, NULL, NULL, N'QUYEN.NGUYENTRANVAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11215593, NULL, NULL, NULL, N'VU.PHANQUANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11215594, NULL, NULL, NULL, N'DUY.CAOGIA@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11215595, NULL, NULL, NULL, N'ROP.HOANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11215596, NULL, NULL, NULL, N'VU.NGUYENHOANG5@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11215597, NULL, NULL, NULL, N'EM.LETUAN@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11215598, NULL, NULL, NULL, N'HIEP.HOANGANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11216597, NULL, NULL, NULL, N'HANH.DUONGTHIMY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11216599, NULL, NULL, NULL, N'DUONG.LENGUYENTHUY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11218651, NULL, NULL, NULL, N'VIET.NGUYENTHANH2@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11218654, NULL, NULL, NULL, N'LINH.NGUYENTHIMY@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11218657, NULL, NULL, NULL, N'THAO.NGUYENDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11218660, NULL, NULL, NULL, N'PHUONG.PHAMANH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11218663, NULL, NULL, NULL, N'HANH.NGUYENTHIHONG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11218668, NULL, NULL, NULL, N'TIEN.NGUYENDANG@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11218670, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11218671, NULL, NULL, NULL, N'QUY.DUONGDINH@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11218672, NULL, NULL, NULL, N'PHONG.PHAMLEHOAI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11218674, NULL, NULL, NULL, N'BLUECOLLARUSERS.HRGLOBALDUMMYFOR@DE.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11218675, NULL, NULL, NULL, N'PHUONG.LUUTHI@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeGlobal] ([GlobalID], [FirstName], [LastName], [OrganizationID], [EmailAddress], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11218906, NULL, NULL, NULL, N'BINH.NGUYENLETAM@VN.BOSCH.COM', N'VH0000              ', CAST(0x0000A6340104F529 AS DateTime), NULL, NULL)
INSERT [dbo].[Organization] ([OrganizationID], [OrganizationName], [ParentID], [TypeID], [IsActive]) VALUES (1000, N'RBVH/ETI', NULL, 1, 1)
INSERT [dbo].[Organization] ([OrganizationID], [OrganizationName], [ParentID], [TypeID], [IsActive]) VALUES (1001, N'RBVH/ETI1', 1000, 2, 1)
INSERT [dbo].[Organization] ([OrganizationID], [OrganizationName], [ParentID], [TypeID], [IsActive]) VALUES (1002, N'RBVH/ETI2', 1000, 2, 1)
INSERT [dbo].[Organization] ([OrganizationID], [OrganizationName], [ParentID], [TypeID], [IsActive]) VALUES (1003, N'RBVH/ETI3', 1000, 2, 1)
INSERT [dbo].[Organization] ([OrganizationID], [OrganizationName], [ParentID], [TypeID], [IsActive]) VALUES (1004, N'RBVH/ETI4', 1000, 2, 1)
INSERT [dbo].[OrganizationType] ([TypeID], [TypeName], [IsActive]) VALUES (1, N'Department', 1)
INSERT [dbo].[OrganizationType] ([TypeID], [TypeName], [IsActive]) VALUES (2, N'Group', 1)
INSERT [dbo].[OrganizationType] ([TypeID], [TypeName], [IsActive]) VALUES (3, N'Section', 1)
INSERT [dbo].[OrganizationType] ([TypeID], [TypeName], [IsActive]) VALUES (4, N'Team', 1)
INSERT [dbo].[OrganizationType] ([TypeID], [TypeName], [IsActive]) VALUES (5, N'Crew', 1)
INSERT [dbo].[Room] ([RoomID], [Name], [MaxPeople], [Position], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'8164fa59-ea99-47e1-8d15-23744fa5e611', N'Room G.1', 30, N'G Floor', N'VH0000              ', CAST(0x0000A63400E56D2C AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Room] ([RoomID], [Name], [MaxPeople], [Position], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'e90bf80d-067b-4110-b547-46b1f4b6aadd', N'Room G.2', 30, N'G Floor', N'VH0000              ', CAST(0x0000A63400E56D2C AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Room] ([RoomID], [Name], [MaxPeople], [Position], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'a186e380-3da9-4392-94c0-75e70fdcc1ad', N'Room 8.2', 25, N'8th Floor', N'VH0000              ', CAST(0x0000A63400E56D2C AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Room] ([RoomID], [Name], [MaxPeople], [Position], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'c9c06cd3-cedc-4f6a-bf30-9bee4072a881', N'Room 11.2', 25, N'11th Floor', N'VH0000              ', CAST(0x0000A63400E56D2C AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Room] ([RoomID], [Name], [MaxPeople], [Position], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'692342f5-c055-48eb-a8f7-d36fff2237ae', N'Room 11.1', 25, N'11th Floor', N'VH0000              ', CAST(0x0000A63400E56D2C AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Room] ([RoomID], [Name], [MaxPeople], [Position], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'dc5787be-3174-426b-984a-e284f5c16cbd', N'Room 8.1', 25, N'8th Floor', N'VH0000              ', CAST(0x0000A63400E56D2C AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Room_TerminalMapping] ([RoomID], [TerminalID], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'8164fa59-ea99-47e1-8d15-23744fa5e611', N'7b89858f-2de2-42c1-97c2-b228a7b0c138', N'VH0000              ', CAST(0x0000A63400E56D2F AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Room_TerminalMapping] ([RoomID], [TerminalID], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'e90bf80d-067b-4110-b547-46b1f4b6aadd', N'a038850d-9c6e-4b9f-aff0-68ce2f24adb7', N'VH0000              ', CAST(0x0000A63400E56D2F AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Room_TerminalMapping] ([RoomID], [TerminalID], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'a186e380-3da9-4392-94c0-75e70fdcc1ad', N'3a09ffb9-8f76-4aa1-ab65-e89663de2dfc', N'VH0000              ', CAST(0x0000A63400E56D2F AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Room_TerminalMapping] ([RoomID], [TerminalID], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'c9c06cd3-cedc-4f6a-bf30-9bee4072a881', N'5cca8d81-bd80-4fda-be55-1ac8cdfebcbb', N'VH0000              ', CAST(0x0000A63400E56D2F AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Room_TerminalMapping] ([RoomID], [TerminalID], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'692342f5-c055-48eb-a8f7-d36fff2237ae', N'9be14e59-4d3d-465a-8200-df01ee39022c', N'VH0000              ', CAST(0x0000A63400E56D2F AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Room_TerminalMapping] ([RoomID], [TerminalID], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'dc5787be-3174-426b-984a-e284f5c16cbd', N'c9257f3b-ce0b-4a17-9a18-c4342d8e2771', N'VH0000              ', CAST(0x0000A63400E56D2F AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Schedule_Testing] ([ScheduledOfferingID], [StartDate], [EndDate], [Title]) VALUES (81249, CAST(0x0000A5E100DE7920 AS DateTime), CAST(0x0000A5E10107ABFF AS DateTime), N'[RBEI-SWE-ORGWIDE00003] C Programming-B')
INSERT [dbo].[Schedule_Testing] ([ScheduledOfferingID], [StartDate], [EndDate], [Title]) VALUES (81249, CAST(0x0000A5E100DE7920 AS DateTime), CAST(0x0000A5E10107AC00 AS DateTime), N'[RBEI-SWE-ORGWIDE00003] C Programming-B')
INSERT [dbo].[Teacher] ([TeacherID], [Name], [IsExternal], [Email], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [EmlpoyeeID]) VALUES (N'5c2eec54-4834-4dc4-b5f8-2c3421c748ad', N'Waiting For Update', 0, N'test@test.com', N'vh000               ', CAST(0x0000A63401113AB1 AS DateTime), NULL, NULL, N'vh001               ')
INSERT [dbo].[TerminalMaster] ([TerminalID], [Name], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'5cca8d81-bd80-4fda-be55-1ac8cdfebcbb', N'Door 11.2', N'VH0000              ', CAST(0x0000A63400E56D2C AS DateTime), NULL, NULL, 1)
INSERT [dbo].[TerminalMaster] ([TerminalID], [Name], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'a038850d-9c6e-4b9f-aff0-68ce2f24adb7', N'Door G.2', N'VH0000              ', CAST(0x0000A63400E56D2C AS DateTime), NULL, NULL, 1)
INSERT [dbo].[TerminalMaster] ([TerminalID], [Name], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'7b89858f-2de2-42c1-97c2-b228a7b0c138', N'Door G.1', N'VH0000              ', CAST(0x0000A63400E56D2C AS DateTime), NULL, NULL, 1)
INSERT [dbo].[TerminalMaster] ([TerminalID], [Name], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'c9257f3b-ce0b-4a17-9a18-c4342d8e2771', N'Door 8.1', N'VH0000              ', CAST(0x0000A63400E56D2C AS DateTime), NULL, NULL, 1)
INSERT [dbo].[TerminalMaster] ([TerminalID], [Name], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'9be14e59-4d3d-465a-8200-df01ee39022c', N'Door 11.1', N'VH0000              ', CAST(0x0000A63400E56D2C AS DateTime), NULL, NULL, 1)
INSERT [dbo].[TerminalMaster] ([TerminalID], [Name], [Initiator], [CreatedDate], [ModifiedBy], [ModifiedDate], [IsActive]) VALUES (N'3a09ffb9-8f76-4aa1-ab65-e89663de2dfc', N'Door 8.2', N'VH0000              ', CAST(0x0000A63400E56D2C AS DateTime), NULL, NULL, 1)
ALTER TABLE [dbo].[ApplicationMenu] ADD  CONSTRAINT [DF_ApplicationMenu_ID]  DEFAULT (newid()) FOR [ApplicationMenuID]
GO
ALTER TABLE [dbo].[ApplicationMenu] ADD  CONSTRAINT [DF_ApplicationMenu_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ApplicationMenu] ADD  CONSTRAINT [DF_ApplicationMenu_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Attendance] ADD  CONSTRAINT [DF_Attendance_ID]  DEFAULT (newid()) FOR [AttendantID]
GO
ALTER TABLE [dbo].[Course] ADD  CONSTRAINT [DF_Course_ID]  DEFAULT (newid()) FOR [CourseID]
GO
ALTER TABLE [dbo].[Course] ADD  CONSTRAINT [DF_Course_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[EmployeeGlobal] ADD  CONSTRAINT [DF_EmployeeGlobal_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Leave] ADD  CONSTRAINT [DF_Leave_ID]  DEFAULT (newid()) FOR [LeaveID]
GO
ALTER TABLE [dbo].[Leave] ADD  CONSTRAINT [DF_Leave_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Reason] ADD  CONSTRAINT [DF_Reason_ID]  DEFAULT (newid()) FOR [ReasonID]
GO
ALTER TABLE [dbo].[Reason] ADD  CONSTRAINT [DF_Reason_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [DF_Role_ID]  DEFAULT (newid()) FOR [RoleID]
GO
ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [DF_Role_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[RoleMapping] ADD  CONSTRAINT [DF_RoleMapping_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Room] ADD  CONSTRAINT [DF_Room_ID]  DEFAULT (newid()) FOR [RoomID]
GO
ALTER TABLE [dbo].[Room] ADD  CONSTRAINT [DF_Room_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Schedule] ADD  CONSTRAINT [DF_Schedule_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Schedule] ADD  CONSTRAINT [DF_Schedule_ModifiedDate]  DEFAULT ((1)) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[Schedule] ADD  CONSTRAINT [DF_Schedule_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Segment] ADD  CONSTRAINT [DF_Segment_SegmentID]  DEFAULT (newid()) FOR [SegmentID]
GO
ALTER TABLE [dbo].[Teacher] ADD  CONSTRAINT [DF_Teacher_ID]  DEFAULT (newid()) FOR [TeacherID]
GO
ALTER TABLE [dbo].[Teacher] ADD  CONSTRAINT [DF_Teacher_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[TerminalMaster] ADD  CONSTRAINT [DF_TerminalMaster_TerminalID]  DEFAULT (newid()) FOR [TerminalID]
GO
ALTER TABLE [dbo].[TerminalMaster] ADD  CONSTRAINT [DF_TerminalMaster_CreatedDate_1]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[TrainingEmployee] ADD  CONSTRAINT [DF_TrainingEmployee_ID]  DEFAULT (newid()) FOR [TrainingEmployeeID]
GO
ALTER TABLE [dbo].[TrainingEmployee] ADD  CONSTRAINT [DF_TrainingEmployee_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [DF_Transaction_ID]  DEFAULT (newid()) FOR [TransactionID]
GO
ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [DF_Transaction_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[UserRole] ADD  CONSTRAINT [DF_UserRole_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_EmployeeCard] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendance_EmployeeCard]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendence_Room] FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([RoomID])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendence_Room]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendence_SegmentDetail] FOREIGN KEY([SegmentID])
REFERENCES [dbo].[Segment] ([SegmentID])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendence_SegmentDetail]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_CardEmployeeMaster_EmployeeGlobalMaster] FOREIGN KEY([GlobalID])
REFERENCES [dbo].[EmployeeGlobal] ([GlobalID])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_CardEmployeeMaster_EmployeeGlobalMaster]
GO
ALTER TABLE [dbo].[EmployeeGlobal]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeGlobal_Organization] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
GO
ALTER TABLE [dbo].[EmployeeGlobal] CHECK CONSTRAINT [FK_EmployeeGlobal_Organization]
GO
ALTER TABLE [dbo].[Leave]  WITH CHECK ADD  CONSTRAINT [FK_Leave_EmployeeCard] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Leave] CHECK CONSTRAINT [FK_Leave_EmployeeCard]
GO
ALTER TABLE [dbo].[Leave]  WITH CHECK ADD  CONSTRAINT [FK_Leave_Segment] FOREIGN KEY([SegmentID])
REFERENCES [dbo].[Segment] ([SegmentID])
GO
ALTER TABLE [dbo].[Leave] CHECK CONSTRAINT [FK_Leave_Segment]
GO
ALTER TABLE [dbo].[Leave]  WITH CHECK ADD  CONSTRAINT [FK_LeaveMaster_ReasonMaster] FOREIGN KEY([ReasonID])
REFERENCES [dbo].[Reason] ([ReasonID])
GO
ALTER TABLE [dbo].[Leave] CHECK CONSTRAINT [FK_LeaveMaster_ReasonMaster]
GO
ALTER TABLE [dbo].[Organization]  WITH CHECK ADD  CONSTRAINT [FK_Organization_TypeID] FOREIGN KEY([TypeID])
REFERENCES [dbo].[OrganizationType] ([TypeID])
GO
ALTER TABLE [dbo].[Organization] CHECK CONSTRAINT [FK_Organization_TypeID]
GO
ALTER TABLE [dbo].[RoleMapping]  WITH CHECK ADD  CONSTRAINT [FK_RoleMapping_ApplicationMenu] FOREIGN KEY([MenuID])
REFERENCES [dbo].[ApplicationMenu] ([ApplicationMenuID])
GO
ALTER TABLE [dbo].[RoleMapping] CHECK CONSTRAINT [FK_RoleMapping_ApplicationMenu]
GO
ALTER TABLE [dbo].[RoleMapping]  WITH CHECK ADD  CONSTRAINT [FK_RoleMapping_RoleMaster] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[RoleMapping] CHECK CONSTRAINT [FK_RoleMapping_RoleMaster]
GO
ALTER TABLE [dbo].[Room_TerminalMapping]  WITH CHECK ADD  CONSTRAINT [FK_Room_TerminalMapping_RoomID] FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([RoomID])
GO
ALTER TABLE [dbo].[Room_TerminalMapping] CHECK CONSTRAINT [FK_Room_TerminalMapping_RoomID]
GO
ALTER TABLE [dbo].[Room_TerminalMapping]  WITH CHECK ADD  CONSTRAINT [FK_Room_TerminalMapping_TerminalID] FOREIGN KEY([TerminalID])
REFERENCES [dbo].[TerminalMaster] ([TerminalID])
GO
ALTER TABLE [dbo].[Room_TerminalMapping] CHECK CONSTRAINT [FK_Room_TerminalMapping_TerminalID]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Scheduled_CourseMaster] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Scheduled_CourseMaster]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Scheduled_TeacherMaster] FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Teacher] ([TeacherID])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Scheduled_TeacherMaster]
GO
ALTER TABLE [dbo].[Segment]  WITH CHECK ADD  CONSTRAINT [FK_SegmentDetail_RoomMaster] FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([RoomID])
GO
ALTER TABLE [dbo].[Segment] CHECK CONSTRAINT [FK_SegmentDetail_RoomMaster]
GO
ALTER TABLE [dbo].[Segment]  WITH CHECK ADD  CONSTRAINT [FK_SegmentDetail_Scheduled1] FOREIGN KEY([ScheduleID])
REFERENCES [dbo].[Schedule] ([ScheduleID])
GO
ALTER TABLE [dbo].[Segment] CHECK CONSTRAINT [FK_SegmentDetail_Scheduled1]
GO
ALTER TABLE [dbo].[TrainingEmployee]  WITH CHECK ADD  CONSTRAINT [FK_TrainingEmployee_EmployeeCard] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[TrainingEmployee] CHECK CONSTRAINT [FK_TrainingEmployee_EmployeeCard]
GO
ALTER TABLE [dbo].[TrainingEmployee]  WITH CHECK ADD  CONSTRAINT [FK_TrainingEmployee_Scheduled] FOREIGN KEY([ScheduleID])
REFERENCES [dbo].[Schedule] ([ScheduleID])
GO
ALTER TABLE [dbo].[TrainingEmployee] CHECK CONSTRAINT [FK_TrainingEmployee_Scheduled]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Employee]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Role]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ex: [RBEI-SWE-ORGWIDE00003] C Programming-B' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Course'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of lesson' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Segment', @level2type=N'COLUMN',@level2name=N'Item'
GO
USE [master]
GO
ALTER DATABASE [TranningManager] SET  READ_WRITE 
GO
