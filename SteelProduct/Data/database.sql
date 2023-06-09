USE [master]
GO
/****** Object:  Database [SWP391]    Script Date: 2023-03-11 1:07:40 AM ******/

ALTER DATABASE [SWP391] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SWP391].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SWP391] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SWP391] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SWP391] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SWP391] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SWP391] SET ARITHABORT OFF 
GO
ALTER DATABASE [SWP391] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SWP391] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SWP391] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SWP391] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SWP391] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SWP391] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SWP391] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SWP391] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SWP391] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SWP391] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SWP391] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SWP391] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SWP391] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SWP391] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SWP391] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SWP391] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SWP391] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SWP391] SET RECOVERY FULL 
GO
ALTER DATABASE [SWP391] SET  MULTI_USER 
GO
ALTER DATABASE [SWP391] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SWP391] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SWP391] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SWP391] SET TARGET_RECOVERY_TIME = 60 SECONDS 


GO
EXEC sys.sp_db_vardecimal_storage_format N'SWP391', N'ON'

GO
USE [SWP391]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 2023-03-11 1:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[Description] [ntext] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 2023-03-11 1:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](50) NULL,
	[ContactName] [varchar](50) NOT NULL,
	[ContactTitle] [varchar](50) NULL,
	[Address] [nvarchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[Email] [varchar](50) NULL,
	[Password] [nchar](20) NULL,
	[Captcha] [nchar](10) NULL,
	[Phone] [text] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 2023-03-11 1:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](50) NULL,
	[Title] [nvarchar](50) NULL,
	[TitleOfCourtesy] [nvarchar](50) NULL,
	[Phone] [text] NULL,
	[BirthDate] [datetime] NULL,
	[Address] [nvarchar](50) NULL,
	[Gender] [bit] NULL,
	[Email] [varchar](50) NULL,
	[Password] [nchar](20) NULL,
	[Role] [int] NULL,
	[Captcha] [nchar](10) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 2023-03-11 1:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[NewsID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[Title] [nvarchar](100) NULL,
	[SubContent] [ntext] NULL,
	[Image] [nvarchar](500) NULL,
	[Content] [ntext] NULL,
	[CreatedAt] [datetime] NULL,
	[ModifyAt] [datetime] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[NewsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 2023-03-11 1:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [decimal](18, 0) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Discount] [float] NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2023-03-11 1:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[Freight] [float] NULL,
	[ShipAddress] [nvarchar](50) NULL,
	[PaymentStatus] [bit] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2023-03-11 1:07:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[QuantityPerUnit] [nvarchar](50) NULL,
	[UnitPrice] [decimal](18, 0) NULL,
	[UnitsInStock] [int] NULL,
	[UnitsOnOrder] [int] NULL,
	[ReorderLevel] [int] NULL,
	[Discontinued] [bit] NULL,
	[Description] [ntext] NULL,
	[Image] [nchar](100) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (1, N'Thép Gân Xây Dựng', N'Thép thanh vằn hay còn gọi là thép gân cây là nguyên vật liệu không thể thiếu trong ngành xây dựng nhà ở, các công trình kiến trúc, trường học, bệnh viện,…. Với đặc tính chắc chắn, chống oxy hóa tốt, chịu lực và chịu nhiệt tốt, thép gân luôn được các nhà thầu chọn là khung sườn cho các công trình xây dựng của mình.', NULL)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (2, N'Thép Cuộn Xây Dựng', N'Thép cuộn nói chung là một trong những loại thép chủ yếu được sử dụng trong các công trình xây dựng, cơ khí chế tạo máy,… dạng cuộn, bề mặt trơn đều.

Nó được sử dụng rộng rãi và có thể nói là không thể thiếu trong lĩnh vực xây dựng: nhà ở, các tòa nhà cao ốc, bệnh viện, trường học, hệ thống cầu đường,…

Đường kính thép thông dụng sử dụng phổ biến là: Ø6, Ø8,… hoặc có thể theo yêu cầu khách hàng', NULL)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (3, N'Thép Hình', N'Thép hình là loại thép có hình dạng các chữ cái khác nhau, dựa vào mục đích sử dụng riêng biệt mà người ta có thể chọn loại thép có hình dáng sao cho phù hợp.

Với thiết kế các hình khác nhau thì mỗi loại thép sẽ có những ứng dụng riêng biệt khác nhau. Các loại sản phẩm thép hình phổ biến hiện này là: thép chữ U, chữ I, chữ V, chữ T, chữ C, chữ L,..', NULL)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (4, N'Thép Hộp', N'Thép hộp là một loại thép có kết cấu rỗng bên trong, mặt cắt có hình vuông và hình chữ nhật hoặc tròn, được hình thành nhờ công nghệ uốn và hàn. Tùy vào mục đích sử dụng ta chia là 2 loại là thép hộp đen và thép hộp mạ kẽm. 

Thép hộp đen: mặt bên ngoài và mặt bên trong đen bóng. Lớp màu đen có độ bóng cao và ít bị bong tróc để lộ lớp thép bên trong. Nó có độ bền, độ cứng cao, có khả năng chống ăn mòn, chống rỉ sét.

Thép hộp mạ kẽm: được xử lý công nghệ để phủ lên bề mặt một lớp kẽm, độ dày lớp phủ vừa phải, giúp thép bên trong không tiếp xúc với không khí bên ngoài, chống rỉ sét, chống oxy hóa trước các tác động của khí hậu và môi trường, kéo dài tuổi thọ của thép.', NULL)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (2, N'FPT', N'Nguyen Tung', N'Mrs', N'286 Nguyen Xien', NULL, N'nguyentung1@gmail.com', N'f+4j0xmtydw=        ', NULL, N'0969616268', NULL)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (3, N'VCC', N'Hoang', N'Mrs', N'Kirchgasse 8', CAST(N'2023-02-07T02:02:58.017' AS DateTime), N'cust1@gmail.com', N'f+4j0xmtydw=        ', NULL, N'0969616268', NULL)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (4, N'VCC', N'Thanh', N'Mrs', N'Kirchgasse 9', CAST(N'2023-02-07T22:05:26.467' AS DateTime), N'cust2@gmail.com', N'f+4j0xmtydw=        ', NULL, N'0969616268', NULL)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (5, N'FPT University', N'Thanh Tung', N'Mr', N'Kirchgasse 7', CAST(N'2023-02-07T22:33:01.913' AS DateTime), N'nguyentung9196@gmail.com', N'f+4j0xmtydw=        ', N'VxTXCFfhL6', N'0969616268', NULL)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (6, N'FPT University', N'Tho', N'Mr', N'Nguyen Xien', CAST(N'2023-02-08T22:50:53.127' AS DateTime), N'cust3@gmail.com', N'ZWtxFvJkSII=        ', NULL, N'0969616268', NULL)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (13, N'VCC', N'Hoang', N'Mr', N'Kirchgasse 7', CAST(N'2023-02-16T23:25:59.283' AS DateTime), N'cust5@gmail.com', N'f+4j0xmtydw=        ', NULL, N'0969616268', NULL)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (14, N'VCC', N'Thanh Tung', N'Mr', N'Smart City', CAST(N'2023-02-16T23:37:16.970' AS DateTime), N'cust6@gmail.com', N'f+4j0xmtydw=        ', NULL, N'0969616268', NULL)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (15, N'VCC', N'Hoang', N'Mr', N'1112afsaf', CAST(N'2023-02-17T01:18:51.140' AS DateTime), N'tungnthe150190@fpt.edu.vn', N'f+4j0xmtydw=        ', NULL, N'0969616268', NULL)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (16, N'VCC', N'Hoang', N'Mr', N'Nguyen Xien', CAST(N'2023-02-17T22:02:47.877' AS DateTime), N'slenderman9196@gmail.com', N'f+4j0xmtydw=        ', NULL, N'0969616268', 1)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (17, N'FPT University', N'Tho', N'Mr', N'Smart City', CAST(N'2023-02-21T00:48:37.463' AS DateTime), N'cust7@gmail.com', N'esOQyalIMcg=        ', NULL, N'0969616268', 1)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (18, N'ECO', N'Hoang', N'Mr', N'Kirchgasse 8', CAST(N'2023-02-22T00:24:33.193' AS DateTime), N'cust8@gmail.com', N'f+4j0xmtydw=        ', NULL, N'888888', 1)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (19, N'VCC', N'Hoang', N'Mr', N'Kirchgasse 8', CAST(N'2023-02-23T00:33:04.960' AS DateTime), N'nguyentung23423@gmail.com', N'f+4j0xmtydw=        ', NULL, N'8888882', 1)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (20, N'FPT University', N'Thanh Tung', N'Giám d?c', N'Nguyen Xien', CAST(N'2023-02-23T02:02:44.620' AS DateTime), N'cust9@gmail.com', N'f+4j0xmtydw=        ', NULL, N'0969616268', 1)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (21, N'Eco', N'Hoang 12', N'Mr', N'Nguyen Xien', CAST(N'2023-02-23T02:04:10.120' AS DateTime), N'cust7@gmail', N'f+4j0xmtydw=        ', NULL, N'0969616268', 1)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (22, N'VCC', N'Hoang', N'Mr', N'Smart City', CAST(N'2023-02-23T02:07:27.450' AS DateTime), N'nguyentung121@gmail.com', N'esOQyalIMcg=        ', NULL, N'0969616268', 1)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (23, N'VCC', N'Hoang', N'Mr', N'1112afsaf', CAST(N'2023-02-23T02:08:43.440' AS DateTime), N'11', N'f+4j0xmtydw=        ', NULL, N'0969616268', 1)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (24, N'FPT University', N'Tho', N'mr', N'Kirchgasse 124222', CAST(N'2023-03-06T16:04:30.403' AS DateTime), N'cust111@gmail.com', N'.                   ', NULL, N'0969616268', 0)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (25, N'FPT', N'TUNG', N'dddd', N'Kirchgasse 124222', CAST(N'2023-03-06T16:11:21.587' AS DateTime), N'cust1213@gmail.com', N'.                   ', NULL, N'0969616268', 0)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (26, N'FPT University', N'Thanh', N'Mrs', N'Kirchgasse 124222', CAST(N'2023-03-06T16:15:01.213' AS DateTime), N'cust342@gmail.com', N'.                   ', NULL, N'09696162682', 0)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (27, N'FPT University', N'TUng', N'dddd', N'286 Nguyen Xien', CAST(N'2023-03-06T16:22:13.530' AS DateTime), N'cust3222@gmail.com', N'f+4j0xmtydw=        ', NULL, N'0969616268', 1)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (28, N'FPT', N'TUNG', N'mr', N'Kirchgasse 124222', CAST(N'2023-03-06T16:22:53.620' AS DateTime), N'cust2223@gmail.com', N'.                   ', NULL, N'0969616268', 0)
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [CreateDate], [Email], [Password], [Captcha], [Phone], [Status]) VALUES (29, N'FPT', N'TUNG', N'Mrs', N'Kirchgasse 124222', CAST(N'2023-03-06T16:33:59.723' AS DateTime), N'cust3213@gmail.com', N'.                   ', NULL, N'0969616268', 0)
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Title], [TitleOfCourtesy], [Phone], [BirthDate], [Address], [Gender], [Email], [Password], [Role], [Captcha], [Status]) VALUES (1, N'Nguyen Thanh Tung', N'Admin', N'Mr', NULL, CAST(N'1996-08-20T00:00:00.000' AS DateTime), N'286 Nguyen Xien', 1, N'nguyentung9196@gmail.com', N'1234                ', 1, NULL, NULL)
INSERT [dbo].[Employees] ([EmployeeID], [FullName], [Title], [TitleOfCourtesy], [Phone], [BirthDate], [Address], [Gender], [Email], [Password], [Role], [Captcha], [Status]) VALUES (2, N'Dang Manh Cuong', N'Seller', N'Mrs', NULL, CAST(N'2001-05-31T00:00:00.000' AS DateTime), N'Nhon', 0, N'emp1@gmail.com', N'1234                ', 2, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([NewsID], [EmployeeID], [Title], [SubContent], [Image], [Content], [CreatedAt], [ModifyAt], [Status]) VALUES (1014, 1, N'Giá thép xây dựng tiếp tục tăng hơn 1 triệu đồng/tấn', N'(NLĐO) - Thép Pomina mới đây điều chỉnh giá bán tăng hơn 1 triệu đồng/tấn, đưa giá thép xây dựng của thương hiệu này lên gần 17,5 triệu đồng/tấn.', N'gia-thep-xay-dung-tiep-tuc-tang-hon-1-trieu-dongtan.jfif', N'<p>Theo đ&oacute;, mức gi&aacute; mới của th&eacute;p cuộn Pomina tại khu vực miền Trung loại phi 10 l&ecirc;n 17,6-17,8 triệu đồng/tấn, t&ugrave;y ti&ecirc;u chuẩn; phi 12 từ 17,29-17,49 triệu đồng/tấn. C&ograve;n tại khu vực miền Nam cũng tăng 810.000 đồng/tấn, l&ecirc;n 17,08-17,49 triệu đồng/tấn, t&ugrave;y loại.</p>

<p>C&aacute;c c&ocirc;ng ty th&eacute;p kh&aacute;c như Vina Kyoei, Th&eacute;p Miền Nam đều vượt 16 triệu đồng/tấn. Theo đ&oacute; th&eacute;p Vina Kyoei, Th&eacute;p Miền Nam loại phi 10 c&oacute; c&ugrave;ng gi&aacute; b&aacute;n từ 16,24-16,44 triệu đồng/tấn. C&aacute;c h&atilde;ng th&eacute;p kh&aacute;c như H&ograve;a Ph&aacute;t, Việt - &Yacute;, Th&aacute;i Nguy&ecirc;n&hellip; cũng c&oacute; gi&aacute; b&aacute;n ra gần 16 triệu đồng/tấn.</p>

<p><img alt="Giá thép xây dựng tiếp tục tăng hơn 1 triệu đồng/tấn - Ảnh 1." id="img_554188537548787712" src="https://nld.mediacdn.vn/thumb_w/684/291774122806476800/2023/2/26/thep-1-16773928428991602457094.jpg" title="Giá thép xây dựng tiếp tục tăng hơn 1 triệu đồng/tấn - Ảnh 1." />Th&eacute;p&nbsp;đua nhau tăng gi&aacute;</p>

<p>Với mức gi&aacute; tr&ecirc;n được xuất b&aacute;n tại c&aacute;c nh&agrave; m&aacute;y, c&ograve;n gi&aacute; b&aacute;n lẻ tại cửa h&agrave;ng sẽ đội th&ecirc;m v&agrave;i triệu đồng/tấn, chủ yếu l&agrave; ph&iacute; vận chuyển từ nh&agrave; m&aacute;y đến nơi ti&ecirc;u thụ. Theo đ&oacute;, gi&aacute; th&eacute;p b&aacute;n lẻ của Vina Kyoei, Th&eacute;p Miền Nam hiện tại đ&atilde; vượt hơn 18,2 triệu đồng/tấn; gi&aacute; th&eacute;p của c&aacute;c h&atilde;ng kh&aacute;c từ 17-17,5 triệu đồng/tấn. Ri&ecirc;ng gi&aacute; th&eacute;p của Pomina l&ecirc;n tới gần 19 triệu đồng/tấn.</p>

<p><iframe height="0" id="ads-place-2011300" scrolling="no" src="javascript:if(typeof(admSspPageRg)!=''undefined''){admSspPageRg.draw(2011300);}else{parent.admSspPageRg.draw(2011300);}" width="0"></iframe></p>

<p><iframe frameborder="0" height="0" name="dableframe-0.5392256051851589" scrolling="no" src="https://api.dable.io/widgets/id/6XggQDXN/users/34507504.1650956517227?from=https%3A%2F%2Fnld.com.vn%2Fkinh-te%2Fgia-thep-xay-dung-tiep-tuc-tang-hon-1-trieu-dong-tan-20230226134049688.htm&amp;url=https%3A%2F%2Fnld.com.vn%2Fkinh-te%2Fgia-thep-xay-dung-tiep-tuc-tang-hon-1-trieu-dong-tan-20230226134049688.htm&amp;ref=https%3A%2F%2Fnld.com.vn%2Fsan-xuat-thep.html&amp;cid=34507504.1650956517227&amp;uid=34507504.1650956517227&amp;site=nld.com.vn&amp;gdpr=0&amp;service_id=7627&amp;service_type=news&amp;country=VN&amp;client_id=3888&amp;randomStr=e1558f31-90ac-4f31-ac0d-e4661ac01f65&amp;id=dablewidget_6XggQDXN&amp;category1=Kinh%20t%E1%BA%BF&amp;author=Tin-%E1%BA%A3nh%3A%20Ng.H%E1%BA%A3i&amp;ad_params=%7B%7D&amp;item_id=20230226134049688&amp;item_pub_date=2023-02-26T13%3A50%3A50%2B07%3A00&amp;pixel_ratio=1.25&amp;ua=Mozilla%2F5.0%20(Windows%20NT%2010.0%3B%20Win64%3B%20x64)%20AppleWebKit%2F537.36%20(KHTML%2C%20like%20Gecko)%20Chrome%2F110.0.5481.178%20Safari%2F537.36&amp;client_width=520&amp;network=non-wifi&amp;lang=vi&amp;pre_expose=1&amp;is_top_win=1&amp;top_win_accessible=1&amp;is_lazyload=0" title="추천 아이템" width="100%"></iframe></p>

<p>Th&ocirc;ng tin c&aacute;c c&ocirc;ng ty th&eacute;p, sở dĩ gi&aacute; th&eacute;p x&acirc;y dựng li&ecirc;n tục tăng từ đầu năm đến nay l&agrave; do nguồn dự trữ nguy&ecirc;n liệu đ&atilde; nhập khẩu từ năm ngo&aacute;i với mức gi&aacute; thấp hiện kh&ocirc;ng c&ograve;n nhiều. Do đ&oacute; c&aacute;c nh&agrave; m&aacute;y sản xuất th&eacute;p cần phải tăng cường nhập khẩu nguy&ecirc;n liệu với gi&aacute; mới tăng đ&aacute;ng kể.</p>
', NULL, CAST(N'2023-03-07T22:15:16.960' AS DateTime), 1)
INSERT [dbo].[News] ([NewsID], [EmployeeID], [Title], [SubContent], [Image], [Content], [CreatedAt], [ModifyAt], [Status]) VALUES (1015, 1, N'Cơn sốt "thép xanh" ở châu Âu', N'Thị trường "thép xanh" đang ngày càng phát triển ở châu Âu khi các hãng xe dần chuyển sự chú ý sang sản phẩm thân thiện với môi trường này.', N'con-sot-thep-xanh-o-chau-au.jfif', N'<p>HYBRIT - viết tắt của &quot;c&ocirc;ng nghệ sản xuất sắt đột ph&aacute; bằng hydrogen&quot; - l&agrave; một li&ecirc;n doanh th&agrave;nh lập v&agrave;o năm 2016 giữa 3 c&ocirc;ng ty Thụy Điển: C&ocirc;ng ty Th&eacute;p SSAB, C&ocirc;ng ty Khai th&aacute;c kho&aacute;ng sản LKAB v&agrave; C&ocirc;ng ty Điện lực quốc doanh Thụy Điển Vattenfall.</p>

<p>Cuối năm 2021, li&ecirc;n doanh n&agrave;y cho ra mắt loại &quot;th&eacute;p xanh&quot; g&acirc;y nhiều ch&uacute; &yacute; v&agrave; h&atilde;ng xe Volvo (Thụy Điển) đ&atilde; trở th&agrave;nh nh&agrave; sản xuất &ocirc;t&ocirc; đầu ti&ecirc;n hợp t&aacute;c với HYBRIT. H&atilde;ng Volkswagen (Đức) cũng ph&aacute;t đi t&iacute;n hiệu muốn sử dụng &quot;th&eacute;p xanh&quot;.</p>

<p><img alt="Cơn sốt thép xanh ở châu Âu - Ảnh 1." id="img_437604058582224896" src="https://nld.mediacdn.vn/291774122806476800/2022/4/10/16-thep-1649596934808723335014.jpg" title="Cơn sốt thép xanh ở châu Âu - Ảnh 1." /></p>

<p>Một nh&agrave; m&aacute;y sản xuất &ldquo;th&eacute;p xanh&rdquo; của HYBRIT tại TP Lulea - Thụy Điển Ảnh: SSAB</p>

<p>Với c&aacute;c h&atilde;ng xe ch&acirc;u &Acirc;u đ&atilde; cam kết giảm đ&aacute;ng kể kh&iacute; thải, &quot;th&eacute;p xanh&quot; l&agrave; thứ họ cần đến l&uacute;c n&agrave;y. Hiệp hội Th&eacute;p thế giới ước t&iacute;nh việc sản xuất th&eacute;p đ&atilde; thải ra khoảng 2,6 tỉ tấn kh&iacute; v&agrave;o năm 2020, chiếm khoảng 7% lượng kh&iacute; thải CO<sub>2</sub>&nbsp;tr&ecirc;n to&agrave;n cầu.</p>

<p><iframe height="0" id="ads-place-2013480" scrolling="no" src="javascript:if(typeof(admSspPageRg)!=''undefined''){admSspPageRg.draw(2013480);}else{parent.admSspPageRg.draw(2013480);}" width="0"></iframe></p>

<p><iframe frameborder="0" height="0" name="dableframe-0.8057654934705953" scrolling="no" src="https://api.dable.io/widgets/id/6XggQDXN/users/34507504.1650956517227?from=https%3A%2F%2Fnld.com.vn%2Fthoi-su-quoc-te%2Fcon-sot-thep-xanh-o-chau-au-20220410202914937.htm&amp;url=https%3A%2F%2Fnld.com.vn%2Fthoi-su-quoc-te%2Fcon-sot-thep-xanh-o-chau-au-20220410202914937.htm&amp;ref=https%3A%2F%2Fnld.com.vn%2Fsan-xuat-thep.html&amp;cid=34507504.1650956517227&amp;uid=34507504.1650956517227&amp;site=nld.com.vn&amp;gdpr=0&amp;service_id=7627&amp;service_type=news&amp;country=VN&amp;client_id=3888&amp;randomStr=294a9557-8b94-4471-8604-21cdf6df1e2d&amp;id=dablewidget_6XggQDXN&amp;category1=Th%E1%BB%9Di%20s%E1%BB%B1%20qu%E1%BB%91c%20t%E1%BA%BF&amp;author=Thanh%20Th%E1%BB%A7y&amp;ad_params=%7B%7D&amp;item_id=20220410202914937&amp;item_pub_date=2022-04-11T10%3A30%3A00%2B07%3A00&amp;pixel_ratio=1.25&amp;ua=Mozilla%2F5.0%20(Windows%20NT%2010.0%3B%20Win64%3B%20x64)%20AppleWebKit%2F537.36%20(KHTML%2C%20like%20Gecko)%20Chrome%2F110.0.5481.178%20Safari%2F537.36&amp;client_width=520&amp;network=non-wifi&amp;lang=vi&amp;pre_expose=1&amp;is_top_win=1&amp;top_win_accessible=1&amp;is_lazyload=0" title="추천 아이템" width="100%"></iframe></p>

<p>&nbsp;HYBRIT đang đặt mục ti&ecirc;u giảm con số n&agrave;y bằng c&aacute;ch thay thế than cốc (thường được sử dụng trong việc sản xuất th&eacute;p từ quặng sắt) bằng điện t&aacute;i tạo v&agrave; hydrogen. Khi đ&oacute;, chất thải ra sẽ l&agrave; hơi nước, thay v&igrave; kh&iacute; CO2 c&oacute; hại cho m&ocirc;i trường.</p>

<p>Trước nhu cầu ng&agrave;y một tăng, c&aacute;c nh&agrave; sản xuất th&eacute;p ở ch&acirc;u &Acirc;u đ&atilde; c&ocirc;ng bố kế hoạch mở rộng quy m&ocirc; sản xuất loại th&eacute;p kh&ocirc;ng cần sử dụng đến than. Ri&ecirc;ng ng&agrave;nh c&ocirc;ng nghiệp th&eacute;p Thụy Điển đ&atilde; l&ecirc;n kế hoạch kh&ocirc;ng sử dụng năng lượng h&oacute;a thạch trong tiến tr&igrave;nh sản xuất th&eacute;p v&agrave;o năm 2045.&nbsp;</p>
', NULL, CAST(N'2023-03-07T22:15:23.540' AS DateTime), 1)
INSERT [dbo].[News] ([NewsID], [EmployeeID], [Title], [SubContent], [Image], [Content], [CreatedAt], [ModifyAt], [Status]) VALUES (1016, NULL, N'Giá sắt thép xây dựng hôm nay 7/3: Quay đầu tăng chỉ sau một ngày giảm', N'Giá thép hôm nay tăng lên mức 4.241 nhân dân tệ/tấn trên Sàn giao dịch Thượng Hải. Trung Quốc đã tìm kiếm lời khuyên của chuyên gia về các biện pháp chính sách để đối phó với sự gia tăng nhanh chóng gần đây của giá nguyên liệu thô.', N'gia-sat-thep-xay-dung-hom-nay-73-quay-dau-tang-chi-sau-mot-ngay-giam.jfif', N'<p><a href="https://vietnambiz.vn/gia-thep-hom-nay.html" title="Giá thép hôm nay">Gi&aacute; th&eacute;p h&ocirc;m nay&nbsp;</a>tăng l&ecirc;n mức 4.241 nh&acirc;n d&acirc;n tệ/tấn tr&ecirc;n Sàn giao dịch Thượng Hải. Trung Quốc đ&atilde; t&igrave;m kiếm lời khuy&ecirc;n của chuy&ecirc;n gia về c&aacute;c biện ph&aacute;p ch&iacute;nh s&aacute;ch để đối ph&oacute; với sự gia tăng nhanh ch&oacute;ng gần đ&acirc;y của gi&aacute; nguy&ecirc;n liệu th&ocirc;.</p>

<p>07-03-2023<a href="https://vietnambiz.vn/gia-xang-dau-hom-nay-73-duy-tri-xu-huong-tich-cuc-nho-nguon-cung-that-chat-20233781058631.htm" title="Gi&amp;#225; xăng dầu h&amp;#244;m nay 7/3: Duy tr&amp;#236; xu hướng t&amp;#237;ch cực nhờ nguồn cung thắt chặt">Gi&aacute; xăng dầu h&ocirc;m nay 7/3: Duy tr&igrave; xu hướng t&iacute;ch cực nhờ nguồn cung thắt chặt</a></p>

<p>07-03-2023<a href="https://vietnambiz.vn/gia-vang-hom-nay-73-tiep-da-giam-nhe-20233775438312.htm" title="Gi&amp;#225; v&amp;#224;ng h&amp;#244;m nay 7/3: V&amp;#224;ng SJC ghi nhận giảm 100.000 đồng/lượng">Gi&aacute; v&agrave;ng h&ocirc;m nay 7/3: V&agrave;ng SJC ghi nhận giảm 100.000 đồng/lượng</a></p>

<p>07-03-2023<a href="https://vietnambiz.vn/ty-gia-usd-hom-nay-73-truot-gia-do-thi-truong-than-trong-20233610430479.htm" title="Tỷ gi&amp;#225; USD h&amp;#244;m nay 7/3: Trượt gi&amp;#225; đ&amp;#225;ng kể trong nước">Tỷ gi&aacute; USD h&ocirc;m nay 7/3: Trượt gi&aacute; đ&aacute;ng kể trong nước</a></p>

<h2 dir="ltr">Gi&aacute; sắt th&eacute;p x&acirc;y dựng h&ocirc;m nay tr&ecirc;n S&agrave;n giao dịch Thượng Hải</h2>

<p dir="ltr"><a href="https://vietnambiz.vn/chu-de/sat-thep-74.htm" title="Giá thép">Giá thép&nbsp;</a>h&ocirc;m nay giao th&aacute;ng 5/2023 tr&ecirc;n S&agrave;n giao dịch Thượng Hải tăng 28 nh&acirc;n d&acirc;n tệ l&ecirc;n mức 4.241 nh&acirc;n d&acirc;n tệ/tấn tại thời điểm khảo s&aacute;t v&agrave;o l&uacute;c 9h40 (giờ Việt Nam).</p>

<table>
	<tbody>
		<tr>
			<td rowspan="2">
			<p dir="ltr"><strong>T&ecirc;n loại</strong></p>
			</td>
			<td rowspan="2">
			<p dir="ltr"><strong>Kỳ hạn</strong></p>
			</td>
			<td rowspan="2">
			<p dir="ltr"><strong>Ng&agrave;y 7/3</strong></p>
			</td>
			<td rowspan="2">
			<p dir="ltr"><strong>Ch&ecirc;nh lệch so với giao dịch trước đ&oacute;</strong></p>
			</td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td>
			<p dir="ltr">Gi&aacute; th&eacute;p</p>
			</td>
			<td>
			<p dir="ltr">Giao th&aacute;ng 5/2023</p>
			</td>
			<td>
			<p dir="ltr">4.241</p>
			</td>
			<td>
			<p dir="ltr">+28</p>
			</td>
		</tr>
		<tr>
			<td>
			<p dir="ltr">Gi&aacute; đồng</p>
			</td>
			<td>
			<p dir="ltr">Giao th&aacute;ng 4/2023</p>
			</td>
			<td>
			<p dir="ltr">69.690</p>
			</td>
			<td>
			<p dir="ltr">+170</p>
			</td>
		</tr>
		<tr>
			<td>
			<p dir="ltr">Gi&aacute; kẽm</p>
			</td>
			<td>
			<p dir="ltr">Giao th&aacute;ng 4/2023</p>
			</td>
			<td>
			<p dir="ltr">23.505</p>
			</td>
			<td>
			<p dir="ltr">+135</p>
			</td>
		</tr>
		<tr>
			<td>
			<p dir="ltr">Gi&aacute; niken</p>
			</td>
			<td>
			<p dir="ltr">Giao th&aacute;ng 4/2023</p>
			</td>
			<td>
			<p dir="ltr">191.160</p>
			</td>
			<td>
			<p dir="ltr">+1.700</p>
			</td>
		</tr>
	</tbody>
</table>

<p dir="ltr"><strong>Bảng gi&aacute; giao dịch tương lai của một số kim loại tr&ecirc;n S&agrave;n Thượng Hải (Đơn vị: nh&acirc;n d&acirc;n tệ/tấn). Tổng hợp: Thảo Vy</strong></p>

<p dir="ltr">V&agrave;o h&ocirc;m thứ Hai (6/3), gi&aacute; quặng sắt kỳ hạn tr&ecirc;n S&agrave;n giao dịch Đại Li&ecirc;n (DCE) v&agrave; S&agrave;n giao dịch Singapore (SGX) suy yếu,&nbsp;<em>Reuters</em>&nbsp;đưa tin.</p>

<p><img alt="" src="https://cdn.vietnambiz.vn/1881912202208555/images/2023/03/07/bieu-do-gia-thep-hom-nay-20230307094335145.png?width=250" /></p>

<p>Biểu đồ quặng sắt kỳ hạn tại S&agrave;n Thượng Hải. (Nguồn:&nbsp;<em>SHFE</em>)</p>

<p dir="ltr">Cụ thể, gi&aacute; quặng sắt DCIOcv1 giao th&aacute;ng 5/2023 tr&ecirc;n S&agrave;n DCE của Trung Quốc đ&atilde; kết th&uacute;c giao dịch trong ng&agrave;y thấp hơn 2,13% xuống 897 nh&acirc;n d&acirc;n tệ/tấn (tương đương 129,70 USD/tấn).</p>

<p dir="ltr">Tương tự, hợp đồng quặng sắt chuẩn SZZFJ3 giao th&aacute;ng 4/2023 tr&ecirc;n S&agrave;n SGX giảm 1,23% xuống 123,85 USD/tấn trong c&ugrave;ng ng&agrave;y.</p>

<p dir="ltr">Nguy&ecirc;n nh&acirc;n của sự sụt giảm n&agrave;y l&agrave; do v&agrave;o tuần trước, cơ quan hoạch định nh&agrave; nước của Trung Quốc cho biết họ đ&atilde; t&igrave;m kiếm lời khuy&ecirc;n của chuy&ecirc;n gia về c&aacute;c biện ph&aacute;p ch&iacute;nh s&aacute;ch để đối ph&oacute; với sự gia tăng nhanh ch&oacute;ng gần đ&acirc;y của gi&aacute; nguy&ecirc;n liệu th&ocirc;.</p>

<p dir="ltr">Ủy ban Cải c&aacute;ch v&agrave; Ph&aacute;t triển Quốc gia (NDRC) cho biết v&agrave;o cuối ng&agrave;y 3/3 rằng, c&aacute;c chuy&ecirc;n gia nhận định gi&aacute; tăng l&agrave; do đầu cơ v&agrave; đề nghị c&aacute;c cơ quan chức năng n&ecirc;n tăng cường gi&aacute;m s&aacute;t thị trường.</p>

<p dir="ltr">Theo một b&agrave;i đăng tr&ecirc;n t&agrave;i khoản WeChat ch&iacute;nh thức của m&igrave;nh, NDRC y&ecirc;u cầu &ldquo;ngăn chặn&rdquo; việc lan truyền th&ocirc;ng tin định gi&aacute; sai lệch cũng như kh&ocirc;ng để xảy ra t&igrave;nh trạng đầu cơ t&iacute;ch trữ.</p>

<p dir="ltr">&Ocirc;ng Huang Jing, nh&agrave; giao dịch quặng sắt từ Shanghai Yongjiu - một cơ quan thương mại của Trung Quốc, cho biết: &ldquo;Một số người tham gia thị trường đ&atilde; chuyển t&agrave;i sản kh&ocirc;ng c&oacute; t&iacute;nh thanh khoản sang tiền mặt để kh&oacute;a lợi nhuận v&igrave; lo ngại rằng gi&aacute; c&oacute; thể phải đối mặt với &aacute;p lực giảm tiếp sau tin tức từ NDRC&rdquo;.</p>

<p dir="ltr">Đường Sơn, trung t&acirc;m sản xuất th&eacute;p h&agrave;ng đầu của Trung Quốc, đ&atilde; bắt đầu một đợt ứng ph&oacute; khẩn cấp cấp độ 2 kh&aacute;c từ ng&agrave;y 4/3 để xử l&yacute; t&igrave;nh trạng &ocirc; nhiễm kh&ocirc;ng kh&iacute; nghi&ecirc;m trọng, đ&aacute;nh dấu lần thứ hai trong hai tuần họ thực hiện c&aacute;c biện ph&aacute;p n&agrave;y.</p>
', NULL, CAST(N'2023-03-07T22:16:57.907' AS DateTime), 1)
INSERT [dbo].[News] ([NewsID], [EmployeeID], [Title], [SubContent], [Image], [Content], [CreatedAt], [ModifyAt], [Status]) VALUES (1017, NULL, N'Giá sắt thép xây dựng hôm nay 28/2: Về dưới mức 4.200 nhân dân tệ/tấn', N'Giá thép hôm nay giảm xuống mức 4.165 nhân dân tệ/tấn trên Sàn giao dịch Thượng Hải. Trung tâm sản xuất thép Đường Sơn của Trung Quốc đã được yêu cầu giảm bớt công suất để đối phó với tình trạng ô nhiễm nặng.', N'gia-sat-thep-xay-dung-hom-nay-282-ve-duoi-muc-4200-nhan-dan-tetan.jfif', N'<h2 dir="ltr">Gi&aacute; sắt th&eacute;p x&acirc;y dựng h&ocirc;m nay tr&ecirc;n S&agrave;n giao dịch Thượng Hải</h2>

<p dir="ltr"><a href="https://vietnambiz.vn/chu-de/sat-thep-74.htm" title="Giá thép">Giá thép&nbsp;</a>h&ocirc;m nay giao th&aacute;ng 5/2023 tr&ecirc;n S&agrave;n giao dịch Thượng Hải giảm 36 nh&acirc;n d&acirc;n tệ xuống mức 4.165 nh&acirc;n d&acirc;n tệ/tấn tại thời điểm khảo s&aacute;t v&agrave;o l&uacute;c 9h45 (giờ Việt Nam).</p>

<table>
	<tbody>
		<tr>
			<td rowspan="2">
			<p dir="ltr"><strong>T&ecirc;n loại</strong></p>
			</td>
			<td rowspan="2">
			<p dir="ltr"><strong>Kỳ hạn</strong></p>
			</td>
			<td rowspan="2">
			<p dir="ltr"><strong>Ng&agrave;y 28/2</strong></p>
			</td>
			<td rowspan="2">
			<p dir="ltr"><strong>Ch&ecirc;nh lệch so với giao dịch trước đ&oacute;</strong></p>
			</td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td>
			<p dir="ltr">Gi&aacute; th&eacute;p</p>
			</td>
			<td>
			<p dir="ltr">Giao th&aacute;ng 5/2023</p>
			</td>
			<td>
			<p dir="ltr">4.165</p>
			</td>
			<td>
			<p dir="ltr">-36</p>
			</td>
		</tr>
		<tr>
			<td>
			<p dir="ltr">Gi&aacute; đồng</p>
			</td>
			<td>
			<p dir="ltr">Giao th&aacute;ng 4/2023</p>
			</td>
			<td>
			<p dir="ltr">68.710</p>
			</td>
			<td>
			<p dir="ltr">0</p>
			</td>
		</tr>
		<tr>
			<td>
			<p dir="ltr">Gi&aacute; kẽm</p>
			</td>
			<td>
			<p dir="ltr">Giao th&aacute;ng 4/2023</p>
			</td>
			<td>
			<p dir="ltr">23.090</p>
			</td>
			<td>
			<p dir="ltr">-15</p>
			</td>
		</tr>
		<tr>
			<td>
			<p dir="ltr">Gi&aacute; niken</p>
			</td>
			<td>
			<p dir="ltr">Giao th&aacute;ng 4/2023</p>
			</td>
			<td>
			<p dir="ltr">198.040</p>
			</td>
			<td>
			<p dir="ltr">+1.480</p>
			</td>
		</tr>
	</tbody>
</table>

<p dir="ltr"><strong>Bảng gi&aacute; giao dịch tương lai của một số kim loại tr&ecirc;n S&agrave;n Thượng Hải (Đơn vị: nh&acirc;n d&acirc;n tệ/tấn). Tổng hợp: Thảo Vy</strong></p>

<p dir="ltr">V&agrave;o h&ocirc;m thứ Hai (27/2), gi&aacute; quặng sắt tiếp tục giảm do lo ngại về nhu cầu yếu hơn trong ngắn hạn,&nbsp;<em>Reuters</em>&nbsp;đưa tin.</p>

<p><img alt="" src="https://cdn.vietnambiz.vn/1881912202208555/images/2023/02/28/bieu-do-gia-thep-hom-nay-20230228095221831.png?width=250" /></p>

<p>Biểu đồ quặng sắt kỳ hạn tại S&agrave;n Thượng Hải. (Nguồn:&nbsp;<em>SHFE</em>)</p>

<p dir="ltr">T&acirc;m l&yacute; n&agrave;y diễn ra sau khi trung t&acirc;m sản xuất th&eacute;p Đường Sơn của Trung Quốc được y&ecirc;u cầu giảm bớt c&ocirc;ng suất v&agrave;o thứ Bảy (25/2) để đối ph&oacute; với t&igrave;nh trạng &ocirc; nhiễm nặng.</p>

<p dir="ltr">Ch&iacute;nh quyền Đường Sơn cho biết, họ đ&atilde; triển khai ứng ph&oacute; khẩn cấp cấp độ 2 từ Chủ Nhật (26/2) để đối ph&oacute; với dự b&aacute;o &ocirc; nhiễm kh&ocirc;ng kh&iacute; nghi&ecirc;m trọng trong tuần n&agrave;y.</p>

<p dir="ltr">C&ocirc;ng ty Tư vấn Mysteel cho biết trong một b&aacute;o c&aacute;o rằng, một số nh&agrave; m&aacute;y đ&atilde; l&ecirc;n kế hoạch giảm c&ocirc;ng suất thi&ecirc;u kết từ 30% đến 50% để đ&aacute;p ứng y&ecirc;u cầu của ch&iacute;nh phủ.</p>

<p dir="ltr">Hiện, kh&ocirc;ng r&otilde; c&aacute;c hạn chế sản xuất sẽ k&eacute;o d&agrave;i bao l&acirc;u. Th&agrave;nh phố H&agrave;m Đan, cũng l&agrave; một nơi sản xuất th&eacute;p chủ chốt của Trung Quốc, đ&atilde; thực hiện c&aacute;c biện ph&aacute;p hạn chế tương tự v&agrave;o Chủ Nhật.</p>

<p dir="ltr">Một nh&agrave; ph&acirc;n t&iacute;ch th&eacute;p c&oacute; trụ sở tại Thượng Hải cho biết: &ldquo;Gi&aacute; hợp đồng kỳ hạn giảm v&agrave;o h&ocirc;m thứ Hai chủ yếu l&agrave; do hạn chế sản xuất ở Đường Sơn v&agrave; H&agrave;m Đan&rdquo;.</p>

<p dir="ltr">Việc hạn chế sản xuất diễn ra trước ng&agrave;y khai mạc cuộc họp quốc hội thường ni&ecirc;n của Trung Quốc v&agrave;o ng&agrave;y 5/3, một trong những sự kiện quan trọng nhất trong năm khi Bắc Kinh thường nỗ lực hơn nữa để đảm bảo bầu trời quang đ&atilde;ng.</p>

<p dir="ltr">C&aacute;c nh&agrave; ph&acirc;n t&iacute;ch từ Ng&acirc;n h&agrave;ng ANZ cho biết rằng, h&agrave;ng tồn kho tại cảng tăng cũng g&acirc;y th&ecirc;m kh&oacute; khăn cho quặng sắt. Theo đ&oacute;, tổng kho dự trữ đ&atilde; tăng 1,2% trong tuần trước l&ecirc;n mức cao nhất kể từ th&aacute;ng 9/2022.</p>

<p><img alt="" src="https://cdn.vietnambiz.vn/1881912202208555/images/2023/02/28/5-vnboptimized-2023022809521921.png?width=700" /></p>

<p>Ảnh:&nbsp;<em>Thảo Vy</em></p>

<h2 dir="ltr">Gi&aacute; th&eacute;p x&acirc;y dựng h&ocirc;m nay tại thị trường trong nước</h2>

<p dir="ltr">Theo&nbsp;<em>SteelOnline.vn</em>, gi&aacute; th&eacute;p x&acirc;y dựng trong nước ng&agrave;y 28/2 vẫn neo ở mức cũ, cụ thể như sau:</p>

<h3 dir="ltr">Gi&aacute; th&eacute;p tại miền Bắc</h3>

<p dir="ltr">Thương hiệu th&eacute;p H&ograve;a Ph&aacute;t vẫn giữ nguy&ecirc;n gi&aacute; th&eacute;p cuộn CB240 ở mức 15.960 đồng/kg, gi&aacute; th&eacute;p thanh vằn D10 CB300 ở mức 15.840 đồng/kg.</p>

<p dir="ltr">Gi&aacute; th&eacute;p cuộn CB240 của thương hiệu th&eacute;p Việt &Yacute; vẫn được duy tr&igrave; ở mức 15.910 đồng/kg. Tương tự, gi&aacute; th&eacute;p thanh vằn D10 CB300 cũng ở mức cũ l&agrave; 15.810 đồng/kg.</p>

<p dir="ltr">Th&eacute;p Việt Đức cũng giữ nguy&ecirc;n gi&aacute; th&eacute;p cuộn CB240 ở mức 15.710 đồng/kg v&agrave; gi&aacute; th&eacute;p thanh vằn D10 CB300 ở mức 15.810 đồng/kg.</p>

<p dir="ltr">Đối với thương hiệu Th&eacute;p Việt Sing, gi&aacute; th&eacute;p cuộn CB240 hiện ở mức 15.830 đồng/kg v&agrave; gi&aacute; th&eacute;p thanh vằn D10 CB300 ở mức 15.830 đồng/kg.</p>

<p dir="ltr">Gi&aacute; của thương hiệu th&eacute;p Việt Nhật cũng đi ngang: gi&aacute; th&eacute;p cuộn CB240 ở mức 15.880 đồng/kg v&agrave; gi&aacute; th&eacute;p thanh vằn D10 CB300 ở mức 15.880 đồng/kg.</p>
', NULL, CAST(N'2023-03-07T22:17:49.673' AS DateTime), 1)
INSERT [dbo].[News] ([NewsID], [EmployeeID], [Title], [SubContent], [Image], [Content], [CreatedAt], [ModifyAt], [Status]) VALUES (1018, 1, N'q', N'q', N'default.jpg', N'<p>q</p>
', CAST(N'2023-03-07T21:12:19.160' AS DateTime), NULL, 0)
INSERT [dbo].[News] ([NewsID], [EmployeeID], [Title], [SubContent], [Image], [Content], [CreatedAt], [ModifyAt], [Status]) VALUES (1019, 2, N'a', N'a', N'a.png', N'<p>a</p>
', CAST(N'2023-03-08T14:30:58.533' AS DateTime), NULL, 0)
INSERT [dbo].[News] ([NewsID], [EmployeeID], [Title], [SubContent], [Image], [Content], [CreatedAt], [ModifyAt], [Status]) VALUES (1020, 2, N'd', N'd', N'd.png', N'<p>d</p>
', CAST(N'2023-03-08T14:31:13.250' AS DateTime), NULL, 0)
INSERT [dbo].[News] ([NewsID], [EmployeeID], [Title], [SubContent], [Image], [Content], [CreatedAt], [ModifyAt], [Status]) VALUES (1021, 2, N'asd', N'asd', N'asd.png', N'<p>asd</p>
', CAST(N'2023-03-08T14:31:22.567' AS DateTime), NULL, 0)
INSERT [dbo].[News] ([NewsID], [EmployeeID], [Title], [SubContent], [Image], [Content], [CreatedAt], [ModifyAt], [Status]) VALUES (1022, 1, N'awd', N'awd', N'awd.png', N'<p>awd</p>
', CAST(N'2023-03-08T14:31:37.680' AS DateTime), NULL, 0)
INSERT [dbo].[News] ([NewsID], [EmployeeID], [Title], [SubContent], [Image], [Content], [CreatedAt], [ModifyAt], [Status]) VALUES (1023, 2, N'adq', N'qwdqwd', N'adq.png', N'<p>qwdqwd</p>
', CAST(N'2023-03-08T14:31:54.427' AS DateTime), NULL, 0)
INSERT [dbo].[News] ([NewsID], [EmployeeID], [Title], [SubContent], [Image], [Content], [CreatedAt], [ModifyAt], [Status]) VALUES (1024, 2, N'asd', N'asd', N'asd.png', N'<p>as</p>
', CAST(N'2023-03-08T22:27:31.820' AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[News] OFF
GO
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (1, 11, CAST(475000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (2, 11, CAST(475000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3, 4, CAST(499000 AS Decimal(18, 0)), 2, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (4, 13, CAST(449000 AS Decimal(18, 0)), 2, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (5, 4, CAST(499000 AS Decimal(18, 0)), 5, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (6, 4, CAST(499000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (2012, 1, CAST(326000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (2012, 9, CAST(1350000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (2013, 1, CAST(326000 AS Decimal(18, 0)), 4, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (2013, 9, CAST(1350000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (2013, 13, CAST(449000 AS Decimal(18, 0)), 2, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (2014, 4, CAST(499000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (2014, 12, CAST(549000 AS Decimal(18, 0)), 6, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (2015, 4, CAST(499000 AS Decimal(18, 0)), 5, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (2015, 9, CAST(1350000 AS Decimal(18, 0)), 4, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3015, 9, CAST(1350000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3016, 8, CAST(18360 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3017, 9, CAST(1350000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3018, 11, CAST(475000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3019, 12, CAST(549000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3020, 4, CAST(499000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3021, 2, CAST(296000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3022, 4, CAST(499000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3023, 9, CAST(1350000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3024, 2, CAST(296000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3025, 4, CAST(499000 AS Decimal(18, 0)), 2, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3026, 12, CAST(549000 AS Decimal(18, 0)), 2, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3027, 11, CAST(475000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3028, 9, CAST(1350000 AS Decimal(18, 0)), 5, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3029, 9, CAST(1350000 AS Decimal(18, 0)), 4, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3030, 11, CAST(475000 AS Decimal(18, 0)), 2, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3031, 9, CAST(1350000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3032, 12, CAST(549000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3033, 9, CAST(1350000 AS Decimal(18, 0)), 4, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3034, 12, CAST(549000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3035, 13, CAST(449000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3036, 11, CAST(475000 AS Decimal(18, 0)), 2, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3037, 4, CAST(499000 AS Decimal(18, 0)), 2, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3038, 12, CAST(549000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3039, 11, CAST(475000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3040, 1, CAST(326000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3041, 12, CAST(549000 AS Decimal(18, 0)), 4, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3042, 12, CAST(549000 AS Decimal(18, 0)), 4, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3043, 13, CAST(449000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3044, 9, CAST(1350000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3044, 12, CAST(549000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3045, 8, CAST(18490 AS Decimal(18, 0)), 7, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3045, 13, CAST(449000 AS Decimal(18, 0)), 7, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3047, 4, CAST(499000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3048, 12, CAST(549000 AS Decimal(18, 0)), 2, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3049, 4, CAST(499000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3050, 4, CAST(499000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3051, 1, CAST(326000 AS Decimal(18, 0)), 4, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3052, 13, CAST(449000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3053, 9, CAST(1350000 AS Decimal(18, 0)), 3, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3054, 4, CAST(499000 AS Decimal(18, 0)), 1, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3055, 11, CAST(475000 AS Decimal(18, 0)), 5, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3056, 4, CAST(499000 AS Decimal(18, 0)), 2, 0)
INSERT [dbo].[OrderDetails] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (3057, 1, CAST(326000 AS Decimal(18, 0)), 4, 0)
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (1, 5, NULL, CAST(N'2023-02-14T00:00:00.000' AS DateTime), CAST(N'2023-02-15T00:00:00.000' AS DateTime), NULL, 475000, N'286 Nguyen Xien', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (2, 5, NULL, CAST(N'2023-02-14T03:06:24.337' AS DateTime), CAST(N'2023-02-16T00:00:00.000' AS DateTime), NULL, 475000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3, 5, NULL, CAST(N'2023-02-14T03:07:20.060' AS DateTime), CAST(N'2023-02-15T00:00:00.000' AS DateTime), CAST(N'2023-02-15T00:00:00.000' AS DateTime), 998000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (4, 5, NULL, CAST(N'2023-02-14T03:10:28.547' AS DateTime), CAST(N'2023-02-16T00:00:00.000' AS DateTime), NULL, 898000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (5, 5, NULL, CAST(N'2023-02-14T03:11:34.263' AS DateTime), CAST(N'2023-04-16T00:00:00.000' AS DateTime), NULL, 2495000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (6, 5, NULL, CAST(N'2023-02-14T03:13:13.683' AS DateTime), CAST(N'2023-02-16T00:00:00.000' AS DateTime), NULL, 499000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (2012, 5, NULL, CAST(N'2023-02-17T00:52:24.063' AS DateTime), CAST(N'2023-02-25T00:00:00.000' AS DateTime), NULL, 1676000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (2013, 5, NULL, CAST(N'2023-02-21T01:28:43.353' AS DateTime), CAST(N'2023-02-23T00:00:00.000' AS DateTime), NULL, 6252000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (2014, 5, NULL, CAST(N'2021-02-21T16:31:38.953' AS DateTime), CAST(N'2021-03-24T00:00:00.000' AS DateTime), NULL, 3793000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (2015, 5, NULL, CAST(N'2023-02-23T02:09:34.393' AS DateTime), CAST(N'2023-02-25T00:00:00.000' AS DateTime), NULL, 7895000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3015, 5, NULL, CAST(N'2022-02-23T23:29:18.900' AS DateTime), CAST(N'2023-02-24T00:00:00.000' AS DateTime), NULL, 1350000, N'', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3016, 5, NULL, CAST(N'2023-02-23T23:50:13.523' AS DateTime), CAST(N'2023-02-24T00:00:00.000' AS DateTime), NULL, 18360, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3017, 5, NULL, CAST(N'2023-03-05T23:22:11.847' AS DateTime), CAST(N'2023-03-09T00:00:00.000' AS DateTime), NULL, 4050000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3018, 5, NULL, CAST(N'2020-03-05T23:26:59.843' AS DateTime), CAST(N'2020-03-07T00:00:00.000' AS DateTime), NULL, 475000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3019, 5, NULL, CAST(N'2023-03-05T23:31:23.120' AS DateTime), CAST(N'2023-03-06T00:00:00.000' AS DateTime), NULL, 549000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3020, 5, NULL, CAST(N'2023-03-05T23:32:37.250' AS DateTime), CAST(N'2023-03-07T00:00:00.000' AS DateTime), NULL, 499000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3021, 5, NULL, CAST(N'2023-03-05T23:38:08.570' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 888000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3022, 5, NULL, CAST(N'2023-03-05T23:40:48.300' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 1497000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3023, 5, NULL, CAST(N'2023-03-05T23:42:42.103' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 4050000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3024, 5, NULL, CAST(N'2023-03-05T23:44:54.113' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 888000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3025, 5, NULL, CAST(N'2023-03-05T23:46:37.073' AS DateTime), CAST(N'2023-03-07T00:00:00.000' AS DateTime), NULL, 998000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3026, 5, NULL, CAST(N'2022-05-05T23:55:13.130' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 1098000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3027, 5, NULL, CAST(N'2023-03-05T23:56:41.140' AS DateTime), CAST(N'2023-03-07T00:00:00.000' AS DateTime), NULL, 1425000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3028, 5, NULL, CAST(N'2023-03-06T00:01:57.333' AS DateTime), CAST(N'2023-03-09T00:00:00.000' AS DateTime), NULL, 6750000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3029, 5, NULL, CAST(N'2023-03-06T00:12:21.427' AS DateTime), CAST(N'2023-03-09T00:00:00.000' AS DateTime), NULL, 5400000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3030, 5, NULL, CAST(N'2023-03-06T00:40:08.347' AS DateTime), CAST(N'2023-03-09T00:00:00.000' AS DateTime), NULL, 950000, N'Kirchgasse 7', 1)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3031, 5, NULL, CAST(N'2023-03-06T00:48:02.937' AS DateTime), CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 4050000, N'Kirchgasse 7', 1)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3032, 5, NULL, CAST(N'2023-03-06T00:57:02.487' AS DateTime), CAST(N'2023-03-09T00:00:00.000' AS DateTime), NULL, 549000, N'Kirchgasse 7', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3033, 15, NULL, CAST(N'2023-03-06T01:00:43.993' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 5400000, N'1112afsaf', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3034, 15, NULL, CAST(N'2023-03-06T01:03:59.187' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 549000, N'1112afsaf', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3035, 15, NULL, CAST(N'2023-03-06T01:06:03.877' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 1347000, N'1112afsaf', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3036, 15, NULL, CAST(N'2023-03-06T01:19:10.950' AS DateTime), CAST(N'2023-03-09T00:00:00.000' AS DateTime), NULL, 950000, N'1112afsaf', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3037, 15, NULL, CAST(N'2023-03-06T01:25:18.617' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 998000, N'1112afsaf', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3038, 15, NULL, CAST(N'2023-03-06T01:26:41.927' AS DateTime), CAST(N'2023-03-23T00:00:00.000' AS DateTime), NULL, 549000, N'1112afsaf', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3039, 15, NULL, CAST(N'2023-03-06T01:32:48.363' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 1425000, N'1112afsaf', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3040, 5, NULL, CAST(N'2023-03-06T01:49:37.663' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 978000, N'Kirchgasse 7', 1)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3041, 15, NULL, CAST(N'2023-03-06T13:55:31.083' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 2196000, N'1112afsaf', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3042, 15, NULL, CAST(N'2023-03-06T13:59:19.210' AS DateTime), CAST(N'2023-03-07T00:00:00.000' AS DateTime), NULL, 2196000, N'1112afsaf', 1)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3043, 15, NULL, CAST(N'2023-03-06T14:05:43.363' AS DateTime), CAST(N'2023-03-07T00:00:00.000' AS DateTime), NULL, 1347000, N'1112afsaf', 1)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3044, 15, NULL, CAST(N'2023-03-06T15:55:32.500' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 4599000, N'1112afsaf', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3045, 15, NULL, CAST(N'2023-03-06T15:57:24.533' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 3272430, N'1112afsaf', 1)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3046, 24, NULL, CAST(N'2023-03-06T16:04:30.597' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 0, NULL, NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3047, 25, NULL, CAST(N'2023-03-06T16:11:21.777' AS DateTime), CAST(N'2023-03-14T00:00:00.000' AS DateTime), NULL, 499000, NULL, NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3048, 15, NULL, CAST(N'2023-03-06T16:12:50.583' AS DateTime), CAST(N'2023-03-07T00:00:00.000' AS DateTime), NULL, 1098000, N'1112afsaf', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3049, 26, NULL, CAST(N'2023-03-06T16:15:01.400' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 499000, NULL, NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3050, 28, NULL, CAST(N'2023-03-06T16:22:53.630' AS DateTime), CAST(N'2023-03-09T00:00:00.000' AS DateTime), NULL, 499000, NULL, NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3051, 15, NULL, CAST(N'2023-03-06T16:29:04.327' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 1304000, N'1112afsaf', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3052, 15, NULL, CAST(N'2023-03-06T16:31:30.037' AS DateTime), CAST(N'2023-03-09T00:00:00.000' AS DateTime), NULL, 1347000, N'1112afsaf', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3053, 15, NULL, CAST(N'2023-03-06T16:32:46.283' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 4050000, N'1112afsaf', 1)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3054, 29, NULL, CAST(N'2023-03-06T16:33:59.913' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 499000, N'Kirchgasse 124222', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3055, 15, NULL, CAST(N'2023-03-06T17:04:07.720' AS DateTime), CAST(N'2023-03-08T00:00:00.000' AS DateTime), NULL, 2375000, N'FPT', NULL)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3056, 5, NULL, CAST(N'2023-03-07T13:22:25.567' AS DateTime), CAST(N'2023-03-09T00:00:00.000' AS DateTime), NULL, 998000, N'Kirchgasse 7', 1)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipAddress], [PaymentStatus]) VALUES (3057, 5, NULL, CAST(N'2023-03-07T13:26:13.550' AS DateTime), CAST(N'2023-03-09T00:00:00.000' AS DateTime), NULL, 1304000, N'Kirchgasse 7', 1)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [Description], [Image], [Status]) VALUES (1, N'Thép thanh vằn Việt Nhật', 1, N'36 cây/bó', CAST(326000 AS Decimal(18, 0)), 980, 26, 29, 1, N'Quy cách: 36cây/bó. 
Đường kính : phổ biến từ Φ10, Φ12, Φ14, Φ16, Φ18, Φ20,…Φ51.
Chiều dài: tiêu chuẩn 11,7m/cây
. Tiêu chuẩn TCVN 1651-2: 2008: CB300-V, CB400-V, CB500-V
Tiêu chuẩn JIS G3112 – 2010:SD 295A, SD 390, SD 490
ASTM A 615M -09 : G40, G60. 
Xuất xứ: Thép Vina Kyoei – Việt Nam', N'item1.jpg                                                                                           ', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [Description], [Image], [Status]) VALUES (2, N'Thép thanh vằn Pomia', 1, N'30 cây/bó', CAST(296000 AS Decimal(18, 0)), 1490, 35, 24, 1, N'Quy cách :30 cây/bó. 
Đường kính : phổ biến 10mm, 12mm, 14mm, 16mm, 18mm, 20mm,…
Chiều dài: tiêu chuẩn 11,7m/cây. 
Tiêu chuẩn TCVN 1651-2: 2008: CB300-V, CB400-V, CB500-V
. Tiêu chuẩn JIS G3112 – 2010:SD 295A, SD 390, SD 490
ASTM A 615M -09 -2012: G40, G60
. Xuất xứ: Thép Pomina – Việt Nam', N'item2.jpg                                                                                           ', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [Description], [Image], [Status]) VALUES (3, N'Thép thanh vằn Hoà Phát', 1, N'30 cây/bó', CAST(349000 AS Decimal(18, 0)), 1200, 31, 29, 1, N'Quy cách :30 cây/bó. 
Đường kính : phổ biến từ 10mm, 12mm, 14mm, 16mm, 18mm, 20mm
. Chiều dài: chiều dài tiêu chuẩn 11,7m/cây
. TCVN 1651-2: 2008: CB300-V, CB400-V, CB500-V
JIS G3112 – 1987:SD 295A,SD 295B,SD 345, SD 390, SD 490. 
Xuất xứ: Thép Hòa Phát – Việt Nam', N'item3.jpg                                                                                           ', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [Description], [Image], [Status]) VALUES (4, N'Thép thanh vằn Đông Nam Á', 1, N'120 cây/bó', CAST(499000 AS Decimal(18, 0)), 1972, 32, 28, 1, N'Quy cách: từ 120 cây/bó. 
Đường kính:  Ø10, Ø12, Ø14, Ø16, Ø18. 
Chiều dài: chiều dài chuẩn 11,7m/thanh. 
TCVN 1651-2: 2008: CB300-V (CT51) , CB300-V (ATM)
JIS G3112 – 2010:SD 295A, SD 390 hoặc tương đương
. Xuất xứ: Thép Đông Nam Á – Việt Nam', N'item4.jpg                                                                                           ', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [Description], [Image], [Status]) VALUES (5, N'Thép cuộn Việt Nhật', 2, N'Cuộn', CAST(18000 AS Decimal(18, 0)), 1000, 80, 40, 1, N'Quy cách : Cuộn. 
Đường kính: phổ biến 6mm – 8mm
. TCVN 1651-1:2008: CB240-T, CB300-T
JIS G 3505 -2004: SWRM 10, SWRM 12, SWRM 15, SWRM 20
. 
Xuất xứ: Thép Vina Kyoei – Việt Nam', N'item5.jpg                                                                                           ', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [Description], [Image], [Status]) VALUES (6, N'Thép cuộn Hoà Phát', 2, N'Cuộn', CAST(18634 AS Decimal(18, 0)), 1200, 90, 47, 1, N'Quy cách :Cuộn. 
Đường kính : 6mm – 10mm
. Trọng lượng: 1000kg – 2100kg
. Tiêu chuẩn JIS (Nhật Bản), ASTM ( Hoa Kỳ), BS (Anh), TCVN (Việt Nam)…
Xuất xứ: Thép Hòa Phát – Việt Nam', N'item7.jpg                                                                                           ', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [Description], [Image], [Status]) VALUES (7, N'Thép cuộn Miền Nam', 2, N'Cuộn', CAST(18370 AS Decimal(18, 0)), 1100, 40, 34, 1, N'Quy cách:Cuộn. 
Đường kính: phổ biến 6mm – 8mm. 
Trọng lượng: 2000kg. 
Tiêu chuẩn TCVN 1651-1:2018
. Xuất xứ: Thép Miền Nam – Việt Nam', N'item6.jpg                                                                                           ', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [Description], [Image], [Status]) VALUES (8, N'Thép cuộn Đông Nam Á', 2, N'Cuộn', CAST(18500 AS Decimal(18, 0)), 1242, 2, 1, 1, N'Quy cách :Cuộn. Đường kính : 6mm – 8mm. Xuất xứ: Việt Nam', N'item8.jpg                                                                                           ', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [Description], [Image], [Status]) VALUES (9, N'Thép hình chữ I An Khánh', 3, N'120x6m', CAST(1350000 AS Decimal(18, 0)), 661, 36, 30, 1, N'Độ dài tiêu chuẩn: 6 mét
….
Tiêu chuẩn JIS 3101:2010, JIS G3101:2015, JISG3192:2010, TCVN 7571-1:2006. 
Thương hiệu: An Khánh Steel', N'item9.jpg                                                                                           ', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [Description], [Image], [Status]) VALUES (11, N'Thép chữ V Miền Nam', 3, N'V40 x 40 x 5mm x 6m', CAST(475000 AS Decimal(18, 0)), 882, 65, 40, 1, N'Chiều dài: 6 mét, 12 mét. 
Mác thép: A36 – SS400 – Q235B – S235JR – GR.A – GR.B. 
Tiêu chuẩn: TCVN, ASTM – JIS G3101 – KD S3503 – GB/T 700 – EN10025-2 – A131
. Thương hiệu: Thép V Nhà Bè – VNSteel', N'item12.jpg                                                                                          ', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [Description], [Image], [Status]) VALUES (12, N'Thép hộp chữ nhật mạ kễm Hoà Phát', 4, N'50x100mmx1.2mm', CAST(549000 AS Decimal(18, 0)), 274, 23, 31, 1, N'Quy cách: Đóng theo bó
. Tiêu chuẩn: JIS 3321: 2010 của Nhật bản, BS-EN 10346: 2009 của Châu Âu, AS 1397: 2001 của Úc, ASTM A792 của Mỹ.
Thương hiệu: Hòa Phát
. Xuất xứ: Việt Nam', N'item10.jpg                                                                                          ', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [Description], [Image], [Status]) VALUES (13, N'Thép hộp vuông mạ kẽm Sendo', 4, N'40 x 40mmx1.2mm', CAST(449000 AS Decimal(18, 0)), 474, 27, 29, 1, N'Quy cách: Bó gồm nhiều cây. 
Mác thép: SGCC
. Tiêu chuẩn:  ASTM A500/A500M-18, BS EN 10255:2004, JIS G 3444:2015, TCVN. 
Thương hiệu: Thép Sendo Việt Nhật', N'item11.jpg                                                                                          ', 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
ALTER TABLE [dbo].[News]  WITH CHECK ADD  CONSTRAINT [FK_News_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[News] CHECK CONSTRAINT [FK_News_Employees]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
USE [master]
GO
ALTER DATABASE [SWP391] SET  READ_WRITE 
GO
