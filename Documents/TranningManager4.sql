USE [master]
GO
/****** Object:  Database [TranningManager]    Script Date: 6/28/2016 6:13:44 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[GlobalEmployee]    Script Date: 6/28/2016 6:13:44 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[LocalEmployee]    Script Date: 6/28/2016 6:13:44 PM ******/
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
/****** Object:  UserDefinedTableType [dbo].[TrainingBasicData]    Script Date: 6/28/2016 6:13:44 PM ******/
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
	[InstructorFirstname] [nvarchar](50) NULL,
	[InstructorLastname] [nvarchar](50) NULL,
	[InstructorMiddlename] [nvarchar](50) NULL,
	[Location] [varchar](20) NULL,
	[GlobalID] [int] NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[Organization] [varchar](50) NULL,
	[LegalEntity] [varchar](50) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[USP_IMPORT_GLOBALEMPLOYEE]    Script Date: 6/28/2016 6:13:45 PM ******/
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

	insert into EmployeeGlobal(GlobalID,OrganizationID,EmailAddress, [Initiator], CreateDate)
	SELECT E.UserID, E.OrganizationID,Email, 'VH0000',GETDATE()
	FROM #EmployeeGlobal E
	LEFT JOIN EmployeeGlobal E1 ON E.UserID = E1.GlobalID
	WHERE E1.GlobalID IS NULL

	UPDATE E
	SET GlobalID = EG.GlobalID
	FROM [dbo].[Employee] E
	JOIN [dbo].[EmployeeGlobal] EG ON E.EmailAddress = EG.EmailAddress
END


GO
/****** Object:  StoredProcedure [dbo].[USP_IMPORT_LOCALEMPLOYEE]    Script Date: 6/28/2016 6:13:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[USP_IMPORT_TRAININGBASICDATA]    Script Date: 6/28/2016 6:13:45 PM ******/
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

	select DISTINCT [StartDate],[EndDate],Title
	INTO #Schedule
	FROM @DataTable

	insert into Schedule(StartTime,EndTime,TeacherID,CreatedDate,CourseID, CourseName,[Initiator],[CreatedDate] )
	SELECT S.[StartDate],S.[EndDate],1,GETDATE(),C.CourseID,S.Title, 'VH0000', GETDATE()
	FROM #Schedule S
	JOIN Course C ON C.Name = S.Title
	LEFT JOIN Schedule S1 ON S1.[StartTime] = S.[StartDate] AND S1.[EndTime] = S.[EndDate] AND S.Title = S1.[CourseName]
	WHERE S1.ScheduleID IS NULL

	select DISTINCT ScheduledOfferingID, GlobalID
	INTO #TrainingEmployee
	FROM @DataTable

	insert into TrainingEmployee([ScheduleID],[EmployeeID],[IsActive])
	SELECT T.ScheduledOfferingID,T.GlobalID,1
	FROM #TrainingEmployee T
	JOIN Schedule C ON C.[ScheduleID] = T.ScheduledOfferingID
	JOIN [dbo].[Employee] E ON E.GlobalID = T.GlobalID 
	LEFT JOIN TrainingEmployee T1 ON T1.EmployeeID = T.GloBalID AND T1.ScheduleID = T.ScheduledOfferingID
	WHERE T1.ScheduleID IS NULL
END

GO
/****** Object:  Table [dbo].[ApplicationMenu]    Script Date: 6/28/2016 6:13:45 PM ******/
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
/****** Object:  Table [dbo].[Attendance]    Script Date: 6/28/2016 6:13:45 PM ******/
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
/****** Object:  Table [dbo].[Course]    Script Date: 6/28/2016 6:13:45 PM ******/
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
/****** Object:  Table [dbo].[Employee]    Script Date: 6/28/2016 6:13:45 PM ******/
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
/****** Object:  Table [dbo].[EmployeeGlobal]    Script Date: 6/28/2016 6:13:45 PM ******/
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
	[CreateDate] [datetime] NULL,
	[ModifiedBy] [nchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_EmployeeGlobal] PRIMARY KEY CLUSTERED 
(
	[GlobalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Leave]    Script Date: 6/28/2016 6:13:45 PM ******/
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
/****** Object:  Table [dbo].[Organization]    Script Date: 6/28/2016 6:13:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organization](
	[OrganizationID] [int] NOT NULL,
	[OrganizationName] [nvarchar](2000) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED 
(
	[OrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reason]    Script Date: 6/28/2016 6:13:45 PM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 6/28/2016 6:13:45 PM ******/
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
/****** Object:  Table [dbo].[RoleMapping]    Script Date: 6/28/2016 6:13:45 PM ******/
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
/****** Object:  Table [dbo].[Room]    Script Date: 6/28/2016 6:13:45 PM ******/
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
	[ModifiedBy] [nchar](20) NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 6/28/2016 6:13:45 PM ******/
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
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Segment]    Script Date: 6/28/2016 6:13:45 PM ******/
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
/****** Object:  Table [dbo].[Teacher]    Script Date: 6/28/2016 6:13:45 PM ******/
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
/****** Object:  Table [dbo].[TerminalMapping]    Script Date: 6/28/2016 6:13:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TerminalMapping](
	[TerminalID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[RoomId] [uniqueidentifier] NOT NULL,
	[Initiator] [nchar](20) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifiedBy] [nchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TerminalMapping] PRIMARY KEY CLUSTERED 
(
	[TerminalID] ASC,
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TerminalMaster]    Script Date: 6/28/2016 6:13:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TerminalMaster](
	[TerminalID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Initiator] [nchar](20) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifiedBy] [nchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TerminalMaster_1] PRIMARY KEY CLUSTERED 
(
	[TerminalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrainingEmployee]    Script Date: 6/28/2016 6:13:45 PM ******/
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
/****** Object:  Table [dbo].[Transaction]    Script Date: 6/28/2016 6:13:45 PM ******/
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
/****** Object:  Table [dbo].[UserRole]    Script Date: 6/28/2016 6:13:45 PM ******/
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
	[IsAcive] [bit] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC,
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[ApplicationMenu] ADD  CONSTRAINT [DF_ApplicationMenu_ID]  DEFAULT (newid()) FOR [ApplicationMenuID]
GO
ALTER TABLE [dbo].[ApplicationMenu] ADD  CONSTRAINT [DF_ApplicationMenu_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Attendance] ADD  CONSTRAINT [DF_Attendance_ID]  DEFAULT (newid()) FOR [AttendantID]
GO
ALTER TABLE [dbo].[Course] ADD  CONSTRAINT [DF_Course_ID]  DEFAULT (newid()) FOR [CourseID]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[EmployeeGlobal] ADD  CONSTRAINT [DF_EmployeeGlobal_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
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
ALTER TABLE [dbo].[Segment] ADD  CONSTRAINT [DF_Segment_SegmentID]  DEFAULT (newid()) FOR [SegmentID]
GO
ALTER TABLE [dbo].[Teacher] ADD  CONSTRAINT [DF_Teacher_ID]  DEFAULT (newid()) FOR [TeacherID]
GO
ALTER TABLE [dbo].[Teacher] ADD  CONSTRAINT [DF_Teacher_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[TerminalMapping] ADD  CONSTRAINT [DF_TerminalMaster_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[TerminalMaster] ADD  CONSTRAINT [DF_TerminalMaster_TerminalID]  DEFAULT (newid()) FOR [TerminalID]
GO
ALTER TABLE [dbo].[TerminalMaster] ADD  CONSTRAINT [DF_TerminalMaster_CreateDate_1]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[TrainingEmployee] ADD  CONSTRAINT [DF_TrainingEmployee_ID]  DEFAULT (newid()) FOR [TrainingEmployeeID]
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
ALTER TABLE [dbo].[TerminalMapping]  WITH CHECK ADD  CONSTRAINT [FK_TerminalMapping_TerminalMaster] FOREIGN KEY([TerminalID])
REFERENCES [dbo].[TerminalMaster] ([TerminalID])
GO
ALTER TABLE [dbo].[TerminalMapping] CHECK CONSTRAINT [FK_TerminalMapping_TerminalMaster]
GO
ALTER TABLE [dbo].[TerminalMapping]  WITH CHECK ADD  CONSTRAINT [FK_TerminalMaster_RoomMaster] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomID])
GO
ALTER TABLE [dbo].[TerminalMapping] CHECK CONSTRAINT [FK_TerminalMaster_RoomMaster]
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
