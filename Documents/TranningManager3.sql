USE [master]
GO
/****** Object:  Database [TranningManager]    Script Date: 5/17/2016 5:00:15 PM ******/
CREATE DATABASE [TranningManager]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TranningManager', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TranningManager.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TranningManager_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TranningManager_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [dbo].[ApplicationMenu]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationMenu](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[ParentCode] [nvarchar](500) NULL,
	[Controller] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL,
	[Initiator] [nchar](20) NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ApplicationMenu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[ID] [uniqueidentifier] NOT NULL,
	[SegmentID] [int] NOT NULL,
	[RoomID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [nchar](20) NOT NULL,
	[TimeIn] [datetime] NULL,
	[TimeOut] [datetime] NULL,
	[FullName] [nvarchar](2000) NOT NULL,
	[ScheduleID] [int] NULL,
	[OrganizationName] [nvarchar](500) NULL,
	[Supervisor] [nvarchar](2000) NULL,
	[Date] [date] NOT NULL,
	[IsManual] [bit] NOT NULL,
	[CourseName] [nvarchar](2000) NOT NULL,
	[RoomName] [nvarchar](2000) NULL,
 CONSTRAINT [PK_Attendence] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[SegmentID] ASC,
	[RoomID] ASC,
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CardReaderMaster]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CardReaderMaster](
	[Id] [nvarchar](100) NOT NULL,
	[RoomId] [uniqueidentifier] NULL,
	[CreateDate] [datetime] NULL,
	[Initiator] [nchar](20) NULL,
 CONSTRAINT [PK_CarReaderMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Course]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](2000) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Note] [nvarchar](2000) NULL,
	[Title] [nvarchar](2000) NULL,
 CONSTRAINT [PK_CourseMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employee]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[GlobalID] [int] NOT NULL,
	[CardID] [nchar](20) NOT NULL,
	[ID] [nchar](20) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Initiator] [nchar](20) NULL,
	[EmailAddress] [nvarchar](2000) NOT NULL,
	[NTID] [nchar](10) NOT NULL,
	[FirstName] [nvarchar](500) NULL,
	[LastName] [nvarchar](500) NULL,
	[ModifiedBy] [int] NULL,
	[OrganizationName] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Supervisor] [nvarchar](2000) NULL,
	[status] [nvarchar](2000) NULL,
 CONSTRAINT [PK_CardEmployeeMaster_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmployeeGlobal]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeGlobal](
	[GlobalID] [int] NOT NULL,
	[LastName] [nvarchar](500) NULL,
	[FirstName] [nvarchar](500) NULL,
	[OrganizationID] [int] NULL,
	[LegalEntity] [nvarchar](50) NULL,
	[EmpStatus] [nchar](50) NULL,
	[EmpType] [nchar](50) NULL,
	[Initiator] [nchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[Supervisor] [int] NOT NULL,
	[EmailAddress] [nvarchar](2000) NOT NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_EmployeeGlobalMaster] PRIMARY KEY CLUSTERED 
(
	[GlobalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Leave]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Leave](
	[ID] [uniqueidentifier] NOT NULL,
	[SegmentID] [int] NOT NULL,
	[EmployeeID] [nchar](20) NOT NULL,
	[ReasonID] [uniqueidentifier] NOT NULL,
	[Remark] [nvarchar](2000) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Initiator] [nchar](20) NOT NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_LeaveMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Organization]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organization](
	[ID] [int] NOT NULL,
	[OrganizationName] [nvarchar](2000) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reason]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reason](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](2000) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Initiator] [nchar](20) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ReasonMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](2000) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Initiator] [nchar](20) NULL,
 CONSTRAINT [PK_RoleMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoleMapping]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMapping](
	[RoleID] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Initiator] [nchar](20) NULL,
	[ModifiedBy] [nchar](20) NULL,
	[ModifiedDate] [datetime] NULL,
	[ID] [uniqueidentifier] NOT NULL,
	[MenuID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_RoleMapping_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Room]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](2000) NOT NULL,
	[MaxPeople] [int] NULL,
	[Position] [nvarchar](2000) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Initiator] [nchar](20) NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_RoomMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[ID] [int] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[TeacherID] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Initiator] [nchar](20) NULL,
	[MinPeople] [int] NULL,
	[MaxPeople] [int] NULL,
	[CourseID] [uniqueidentifier] NOT NULL,
	[ModifiedBy] [int] NULL,
	[Note] [nvarchar](2000) NULL,
	[CourseName] [nvarchar](2000) NOT NULL,
 CONSTRAINT [PK_Scheduled] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Segment]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Segment](
	[ID] [int] NOT NULL,
	[ScheduleID] [int] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[Description] [nvarchar](2000) NULL,
	[RoomID] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Date] [date] NOT NULL,
	[Note] [nchar](10) NULL,
	[CourseName] [nvarchar](2000) NOT NULL,
	[Item] [nvarchar](2000) NOT NULL,
 CONSTRAINT [PK_SegmentDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Teacher](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[IsExternal] [bit] NOT NULL,
	[Email] [varchar](200) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Initiator] [nchar](20) NULL,
	[ModifiedBy] [int] NULL,
	[EmlpoyeeID] [nchar](20) NULL,
 CONSTRAINT [PK_TeacherMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TrainingEmployee]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrainingEmployee](
	[ID] [uniqueidentifier] NOT NULL,
	[ScheduleID] [int] NOT NULL,
	[EmployeeID] [nchar](20) NOT NULL,
	[StopFrom] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TrainingEmployee] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Transaction](
	[ID] [uniqueidentifier] NOT NULL,
	[CardID] [nchar](20) NOT NULL,
	[Time] [datetime] NOT NULL,
	[RoomID] [nchar](20) NOT NULL,
	[InOut] [bit] NOT NULL,
	[EmployeeID] [char](20) NULL,
 CONSTRAINT [PK_TransactionMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 5/17/2016 5:00:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[ID] [uniqueidentifier] NOT NULL,
	[RoleID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [nchar](20) NOT NULL,
	[IsAcive] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_EmployeeCard] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendance_EmployeeCard]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendence_RoomMaster] FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([ID])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendence_RoomMaster]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendence_SegmentDetail] FOREIGN KEY([SegmentID])
REFERENCES [dbo].[Segment] ([ID])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendence_SegmentDetail]
GO
ALTER TABLE [dbo].[CardReaderMaster]  WITH CHECK ADD  CONSTRAINT [FK_CarReaderMaster_RoomMaster] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([ID])
GO
ALTER TABLE [dbo].[CardReaderMaster] CHECK CONSTRAINT [FK_CarReaderMaster_RoomMaster]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_CardEmployeeMaster_EmployeeGlobalMaster] FOREIGN KEY([GlobalID])
REFERENCES [dbo].[EmployeeGlobal] ([GlobalID])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_CardEmployeeMaster_EmployeeGlobalMaster]
GO
ALTER TABLE [dbo].[EmployeeGlobal]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeGlobal_Organization] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([ID])
GO
ALTER TABLE [dbo].[EmployeeGlobal] CHECK CONSTRAINT [FK_EmployeeGlobal_Organization]
GO
ALTER TABLE [dbo].[Leave]  WITH CHECK ADD  CONSTRAINT [FK_Leave_EmployeeCard] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[Leave] CHECK CONSTRAINT [FK_Leave_EmployeeCard]
GO
ALTER TABLE [dbo].[Leave]  WITH CHECK ADD  CONSTRAINT [FK_Leave_Segment] FOREIGN KEY([SegmentID])
REFERENCES [dbo].[Segment] ([ID])
GO
ALTER TABLE [dbo].[Leave] CHECK CONSTRAINT [FK_Leave_Segment]
GO
ALTER TABLE [dbo].[Leave]  WITH CHECK ADD  CONSTRAINT [FK_LeaveMaster_ReasonMaster] FOREIGN KEY([ReasonID])
REFERENCES [dbo].[Reason] ([ID])
GO
ALTER TABLE [dbo].[Leave] CHECK CONSTRAINT [FK_LeaveMaster_ReasonMaster]
GO
ALTER TABLE [dbo].[RoleMapping]  WITH CHECK ADD  CONSTRAINT [FK_RoleMapping_ApplicationMenu] FOREIGN KEY([MenuID])
REFERENCES [dbo].[ApplicationMenu] ([ID])
GO
ALTER TABLE [dbo].[RoleMapping] CHECK CONSTRAINT [FK_RoleMapping_ApplicationMenu]
GO
ALTER TABLE [dbo].[RoleMapping]  WITH CHECK ADD  CONSTRAINT [FK_RoleMapping_RoleMaster] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([ID])
GO
ALTER TABLE [dbo].[RoleMapping] CHECK CONSTRAINT [FK_RoleMapping_RoleMaster]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Scheduled_CourseMaster] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Scheduled_CourseMaster]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Scheduled_TeacherMaster] FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Teacher] ([ID])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Scheduled_TeacherMaster]
GO
ALTER TABLE [dbo].[Segment]  WITH CHECK ADD  CONSTRAINT [FK_SegmentDetail_RoomMaster] FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([ID])
GO
ALTER TABLE [dbo].[Segment] CHECK CONSTRAINT [FK_SegmentDetail_RoomMaster]
GO
ALTER TABLE [dbo].[Segment]  WITH CHECK ADD  CONSTRAINT [FK_SegmentDetail_Scheduled1] FOREIGN KEY([ScheduleID])
REFERENCES [dbo].[Schedule] ([ID])
GO
ALTER TABLE [dbo].[Segment] CHECK CONSTRAINT [FK_SegmentDetail_Scheduled1]
GO
ALTER TABLE [dbo].[TrainingEmployee]  WITH CHECK ADD  CONSTRAINT [FK_TrainingEmployee_EmployeeCard] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[TrainingEmployee] CHECK CONSTRAINT [FK_TrainingEmployee_EmployeeCard]
GO
ALTER TABLE [dbo].[TrainingEmployee]  WITH CHECK ADD  CONSTRAINT [FK_TrainingEmployee_Scheduled] FOREIGN KEY([ScheduleID])
REFERENCES [dbo].[Schedule] ([ID])
GO
ALTER TABLE [dbo].[TrainingEmployee] CHECK CONSTRAINT [FK_TrainingEmployee_Scheduled]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Employee]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([ID])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Role]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ex: [RBEI-SWE-ORGWIDE00003] C Programming-B' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Course', @level2type=N'COLUMN',@level2name=N'Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of lesson' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Segment', @level2type=N'COLUMN',@level2name=N'Item'
GO
USE [master]
GO
ALTER DATABASE [TranningManager] SET  READ_WRITE 
GO
