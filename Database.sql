USE [eTaleemDB]
GO
/****** Object:  Table [dbo].[tblAssignment]    Script Date: 1/13/2019 6:29:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAssignment](
	[assignmentID] [int] IDENTITY(1,1) NOT NULL,
	[assignmentTitle] [nvarchar](50) NOT NULL,
	[assignmentQuestionStatement] [nvarchar](max) NOT NULL,
	[assignmentStartDate] [date] NOT NULL,
	[assignmentEndDate] [date] NOT NULL,
	[teacherID] [int] NOT NULL,
	[assignmentMaximumMarks] [int] NOT NULL,
	[isGraded] [bit] NOT NULL,
	[fileName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblAssignment] PRIMARY KEY CLUSTERED 
(
	[assignmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblNotification]    Script Date: 1/13/2019 6:29:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNotification](
	[notificationID] [int] IDENTITY(1,1) NOT NULL,
	[notificationMessage] [nvarchar](50) NOT NULL,
	[userID] [int] NOT NULL,
	[notificationDateTime] [datetime] NOT NULL,
	[notificationType] [nchar](10) NOT NULL,
	[isSeen] [bit] NULL,
 CONSTRAINT [PK_tblNotification] PRIMARY KEY CLUSTERED 
(
	[notificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblStudent]    Script Date: 1/13/2019 6:29:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStudent](
	[studentID] [int] IDENTITY(1,1) NOT NULL,
	[studentFullName] [nvarchar](50) NOT NULL,
	[userID] [int] NOT NULL,
 CONSTRAINT [PK_tblStudent] PRIMARY KEY CLUSTERED 
(
	[studentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblStudentAssignment]    Script Date: 1/13/2019 6:29:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStudentAssignment](
	[studentAssignmentID] [int] IDENTITY(1,1) NOT NULL,
	[studentSubjectID] [int] NOT NULL,
	[assignmentID] [int] NOT NULL,
	[studentAssignmentStatus] [bit] NOT NULL,
	[studentAssignmentMarks] [int] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[studentAssignmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblStudentSubject]    Script Date: 1/13/2019 6:29:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStudentSubject](
	[studentSubjectID] [int] IDENTITY(1,1) NOT NULL,
	[studentID] [int] NOT NULL,
	[subjectCode] [int] NOT NULL,
	[teacherID] [int] NULL,
	[isVisible] [bit] NOT NULL,
	[joiningDate] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblStudentSubject] PRIMARY KEY CLUSTERED 
(
	[studentSubjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSubject]    Script Date: 1/13/2019 6:29:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSubject](
	[subjectCode] [int] NOT NULL,
	[subjectTitle] [nvarchar](50) NOT NULL,
	[subjectGroup] [nvarchar](50) NOT NULL,
	[subjectDescription] [nvarchar](500) NOT NULL,
	[isVisible] [bit] NOT NULL,
 CONSTRAINT [PK_tblSubject] PRIMARY KEY CLUSTERED 
(
	[subjectCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTeacher]    Script Date: 1/13/2019 6:29:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTeacher](
	[teacherID] [int] IDENTITY(1,1) NOT NULL,
	[teacherFullName] [nvarchar](50) NOT NULL,
	[subjectCode] [int] NOT NULL,
	[userID] [int] NOT NULL,
 CONSTRAINT [PK_tblTeacher] PRIMARY KEY CLUSTERED 
(
	[teacherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 1/13/2019 6:29:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[userEmail] [nvarchar](50) NOT NULL,
	[userPassword] [nvarchar](50) NOT NULL,
	[userType] [char](1) NOT NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblAssignment]  WITH CHECK ADD  CONSTRAINT [FK_tblAssignment_tblTeacher1] FOREIGN KEY([teacherID])
REFERENCES [dbo].[tblTeacher] ([teacherID])
GO
ALTER TABLE [dbo].[tblAssignment] CHECK CONSTRAINT [FK_tblAssignment_tblTeacher1]
GO
ALTER TABLE [dbo].[tblNotification]  WITH CHECK ADD  CONSTRAINT [FK_tblNotification_tblUser] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
GO
ALTER TABLE [dbo].[tblNotification] CHECK CONSTRAINT [FK_tblNotification_tblUser]
GO
ALTER TABLE [dbo].[tblStudent]  WITH CHECK ADD  CONSTRAINT [FK_tblStudent_tblUser] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
GO
ALTER TABLE [dbo].[tblStudent] CHECK CONSTRAINT [FK_tblStudent_tblUser]
GO
ALTER TABLE [dbo].[tblStudentAssignment]  WITH CHECK ADD  CONSTRAINT [FK_tblStudentAssignment_tblAssignment] FOREIGN KEY([assignmentID])
REFERENCES [dbo].[tblAssignment] ([assignmentID])
GO
ALTER TABLE [dbo].[tblStudentAssignment] CHECK CONSTRAINT [FK_tblStudentAssignment_tblAssignment]
GO
ALTER TABLE [dbo].[tblStudentAssignment]  WITH CHECK ADD  CONSTRAINT [FK_tblStudentAssignment_tblStudentSubject] FOREIGN KEY([studentSubjectID])
REFERENCES [dbo].[tblStudentSubject] ([studentSubjectID])
GO
ALTER TABLE [dbo].[tblStudentAssignment] CHECK CONSTRAINT [FK_tblStudentAssignment_tblStudentSubject]
GO
ALTER TABLE [dbo].[tblStudentSubject]  WITH CHECK ADD  CONSTRAINT [FK_tblStudentSubject_tblStudent1] FOREIGN KEY([studentID])
REFERENCES [dbo].[tblStudent] ([studentID])
GO
ALTER TABLE [dbo].[tblStudentSubject] CHECK CONSTRAINT [FK_tblStudentSubject_tblStudent1]
GO
ALTER TABLE [dbo].[tblStudentSubject]  WITH CHECK ADD  CONSTRAINT [FK_tblStudentSubject_tblSubject1] FOREIGN KEY([subjectCode])
REFERENCES [dbo].[tblSubject] ([subjectCode])
GO
ALTER TABLE [dbo].[tblStudentSubject] CHECK CONSTRAINT [FK_tblStudentSubject_tblSubject1]
GO
ALTER TABLE [dbo].[tblStudentSubject]  WITH CHECK ADD  CONSTRAINT [FK_tblStudentSubject_tblTeacher] FOREIGN KEY([teacherID])
REFERENCES [dbo].[tblTeacher] ([teacherID])
GO
ALTER TABLE [dbo].[tblStudentSubject] CHECK CONSTRAINT [FK_tblStudentSubject_tblTeacher]
GO
ALTER TABLE [dbo].[tblTeacher]  WITH CHECK ADD  CONSTRAINT [FK_tblTeacher_tblSubject] FOREIGN KEY([subjectCode])
REFERENCES [dbo].[tblSubject] ([subjectCode])
GO
ALTER TABLE [dbo].[tblTeacher] CHECK CONSTRAINT [FK_tblTeacher_tblSubject]
GO
ALTER TABLE [dbo].[tblTeacher]  WITH CHECK ADD  CONSTRAINT [FK_tblTeacher_tblUser] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
GO
ALTER TABLE [dbo].[tblTeacher] CHECK CONSTRAINT [FK_tblTeacher_tblUser]
GO
