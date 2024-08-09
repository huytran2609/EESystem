-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost
-- Thời gian đã tạo: Th7 04, 2024 lúc 09:59 AM
-- Phiên bản máy phục vụ: 10.4.27-MariaDB
-- Phiên bản PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `course_db`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bookmark`
--

CREATE TABLE `bookmark` (
  `user_id` varchar(20) NOT NULL,
  `playlist_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comments`
--

CREATE TABLE `comments` (
  `id` varchar(20) NOT NULL,
  `content_id` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `tutor_id` varchar(20) NOT NULL,
  `comment` varchar(1000) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `contact`
--

CREATE TABLE `contact` (
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `number` int(10) NOT NULL,
  `message` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `content`
--

CREATE TABLE `content` (
  `id` varchar(20) NOT NULL,
  `tutor_id` varchar(20) NOT NULL,
  `playlist_id` varchar(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `video` varchar(100) NOT NULL,
  `thumb` varchar(100) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) NOT NULL DEFAULT 'deactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `content`
--

INSERT INTO `content` (`id`, `tutor_id`, `playlist_id`, `title`, `description`, `video`, `thumb`, `date`, `status`) VALUES
('arxz1wJQbbiQaQlII9a9', '92faIQQp1m8wegiu7U7p', 'LnDfAIZWcQnJtHKECKE2', 'Bài giảng cơ sở dữ liệu： 01 - Giới thiệu môn học', 'Môn học CSDL', 'h3oVE1NvxPsk9m8JMSs5.webm', 'GpVRrl3u4zWekYYjgYze.jpg', '2024-07-01', 'active'),
('loYvpjnthm63UamJGnF7', '92faIQQp1m8wegiu7U7p', 'LnDfAIZWcQnJtHKECKE2', 'Bài giảng cơ sở dữ liệu： 02 - Dữ liệu và cơ sở dữ liệu', 'CSDL', '9wNdQUNubjine3cmj4pp.webm', 'ftjrMljqWsINtdRkNfUv.jpg', '2024-07-01', 'active'),
('LQoEVCbc3dZNFUMqNrA2', '92faIQQp1m8wegiu7U7p', 'LnDfAIZWcQnJtHKECKE2', 'Bài giảng cơ sở dữ liệu： 03 - Hệ quản trị cơ sở dữ liệu', 'CSDL', 'Xog91qEVeEox4WdtsH5g.webm', '8FUJvlOqoL451JJU0wyj.jpg', '2024-07-01', 'active'),
('HVshWeRV1onB4EL9EXr8', '92faIQQp1m8wegiu7U7p', 'LnDfAIZWcQnJtHKECKE2', 'Bài giảng cơ sở dữ liệu： 04 - Mô hình và lược đồ cơ sở dữ liệu', 'CSDL', 'gt7WyZnW8zDIxu0HMc1l.webm', 'FwCcTa8JpjpvoMwAZDm1.jpg', '2024-07-01', 'active'),
('8BzuBSpY3c3ooakbwCa3', '92faIQQp1m8wegiu7U7p', 'LnDfAIZWcQnJtHKECKE2', 'Bài giảng cơ sở dữ liệu： 05 - Mô hình thực thể - liên kết ER (có bổ sung)', 'CSDL5', 'tpaMxADzyDZdzK3p730L.webm', '9l00236jXfBY3qGCBXUb.jpg', '2024-07-01', 'active'),
('Q5A9V1fQcIFhQdqkWF4Q', '92faIQQp1m8wegiu7U7p', 'LnDfAIZWcQnJtHKECKE2', 'Bài giảng cơ sở dữ liệu： 06 - Cách lựa chọn kiểu thực thể và kiểu liên kết từ yêu cầu thiết kế', 'CSDL6', 'DTygN1YmB2DllMppDXLM.webm', '159YkgA942vMLLpP3s39.jpg', '2024-07-01', 'active'),
('tVfRBFalFDKe6do9fF7D', '92faIQQp1m8wegiu7U7p', 'LnDfAIZWcQnJtHKECKE2', 'Bài giảng cơ sở dữ liệu： 06 - Chuyển đổi liên kết cấp 3 thành các liên kết cấp 2 trong mô hình ER', 'CSDL6_1', 'hL77H074TL9FvNtpAWSm.webm', 'nn7h2reAF1tcfmeP2u2v.jpg', '2024-07-01', 'active'),
('xE8AS3eDBbTanDQbWB5Q', '92faIQQp1m8wegiu7U7p', 'LnDfAIZWcQnJtHKECKE2', 'Bài giảng cơ sở dữ liệu： 06 - Hai vai trò Giám sát và Bị giám sát có bị ngược nhau hay không？', 'CSDL6_3', '8q5t9MAVMH1ZuFjBO1Kw.webm', 'g5D1YSifdDfNweMKHIac.jpg', '2024-07-01', 'active'),
('ELjC1WUFEVNsuq3vvYfS', '92faIQQp1m8wegiu7U7p', 'LnDfAIZWcQnJtHKECKE2', 'Bài giảng cơ sở dữ liệu： 06 - Mô hình thực thể liên kết mở rộng EER (mô hình ER mở rộng)', 'CSDL6_4', 'HObakQ42TpczXZmMK4cw.webm', 'CASQPINFT6eqRwHllGAb.jpg', '2024-07-01', 'active'),
('Rum8XYxp4MQztiVzDIPM', '92faIQQp1m8wegiu7U7p', 'LnDfAIZWcQnJtHKECKE2', 'Bài giảng cơ sở dữ liệu： 06 - Thể hiện mô hình thực thể - liên kết bằng sơ đồ', 'CSDL6_5', '5tqD1Y92CxKQ9VaOZiKd.webm', 'vBvsfrsVAxwh97GweFQm.jpg', '2024-07-01', 'active'),
('HC73HXpz5bBmTVAMhJw1', '92faIQQp1m8wegiu7U7p', 'aACXQC4Uph13WaoHoayt', 'Giải tích 1 Chương 1 Bài 1 Hàm số một biến P1_360p', 'giai tich', 'l1d7oWsXK5QmsoOIjKwb.mov', 'yk1Ko0YnqkX31iFVN6gg.jpg', '2024-07-01', 'active'),
('vFkEcfkjNEBgpwhnD6uW', '92faIQQp1m8wegiu7U7p', 'aACXQC4Uph13WaoHoayt', 'Giải tích 1 Chương 1 Bài 1 Hàm số một biến P2_360p', 'giai tich', 'SfQuQRmBPGyPjvWCCk37.mp4', 'CzvN9pya72ZFlKDxBGDd.jpg', '2024-07-01', 'active'),
('n0fYMHwPnPyxU3IjyE9A', '92faIQQp1m8wegiu7U7p', 'aACXQC4Uph13WaoHoayt', 'Giải tích 1 Chương 1 Bài 2 Dãy số_360p', 'giaitich', 'hgANnyCwsFjtQtEwo2A3.mp4', 'UE73tttOlsoj2l3nhNye.jpg', '2024-07-02', 'active'),
('DBJj53bOszBG1IppbQz7', '92faIQQp1m8wegiu7U7p', 'aACXQC4Uph13WaoHoayt', 'Giải tích 1 Chương 1 Bài 4 Giới hạn 1 mũ vô cùng_360p', 'giaitich', 'w3olbgXb8uSZh5w2o4fh.mp4', 'CMh9SjTeFvkQOB9LiNuZ.jpg', '2024-07-02', 'active'),
('vgFsJFE9M9L5VeA4G2vU', '92faIQQp1m8wegiu7U7p', 'aACXQC4Uph13WaoHoayt', 'Giải tích 1 Chương 1 Bài 5 Hàm số liên tục và điểm gián đoạn_360p', 'giaitich', 'nx4v0rdt5cR8Dn85nscy.mp4', 'YgaPK90uWrdqS118GWqM.jpg', '2024-07-02', 'active'),
('9rIaOGyenTUtauO4qyR3', '92faIQQp1m8wegiu7U7p', 'mcGuym6lGltk3CRpqycy', 'Tổng quan về khóa học HTML CSS  ｜ Học lập trình web cơ bản ｜ Học được gì trong khóa học？', 'noi dung html', '9r0v4zvILUfVwJN62Ccn.webm', 'hN7KZOD7d7E4bT1dLuPB.png', '2024-07-02', 'active'),
('HMxj2rRZ6wzKnwCYuKjF', '92faIQQp1m8wegiu7U7p', 'mcGuym6lGltk3CRpqycy', 'Làm quen với Dev tools ｜ Giới thiệu bộ công cụ Dev tools trên trình duyệt', 'html', 'h0CeZLiLnbvNDfsDycv6.webm', 'rbaz7Yfpd9hyKxm1y4EM.png', '2024-07-02', 'active'),
('PJbAL3dAbMFKmFFHT5jk', '92faIQQp1m8wegiu7U7p', 'mcGuym6lGltk3CRpqycy', 'Cài đặt môi trường, công cụ cần thiết để bắt đầ học HTML CSS', 'html', 'xpq9MWCaAxYmKyBAIrlZ.webm', 'Qrmea3JIBcxRFwtVuX4J.png', '2024-07-02', 'active'),
('kS0PAH4Xx0hJcBFZqENL', '92faIQQp1m8wegiu7U7p', 'mcGuym6lGltk3CRpqycy', 'Cấu trúc file HTML ｜ Khởi tạo folder dự án trong HTML', 'html', 'ZX0DFCQdqy002HY5oFkP.webm', 'kNjn6SGeDnonMJXrTK4K.png', '2024-07-02', 'active'),
('s48tO4cOiPrDN8XsPN4z', '92faIQQp1m8wegiu7U7p', 'mcGuym6lGltk3CRpqycy', 'HTML CSS là gì？ ｜ Ví dụ trực quan về HTML & CSS', 'html', 'ejEK3CbRV0DvEP7cLBBG.webm', '96s1kgDsIM8wNXYXAyKx.png', '2024-07-02', 'active'),
('dmPOjHppQPzMOUUnC3JZ', '92faIQQp1m8wegiu7U7p', 'mcGuym6lGltk3CRpqycy', 'Attributes trong HTML ｜ Thêm thuộc tính (Attributes) vào thẻ', 'html', 'Ch8ECgSQfaV2dRxHbtGF.webm', '6uCeGcs61LhlZoMAoC4A.png', '2024-07-02', 'active'),
('idX7mDt09OxgH016G7ks', '92faIQQp1m8wegiu7U7p', 'cHas6Diyx2RnHaEQgGAT', 'Cách sử dụng CSS trong HTML ｜ Hướng dẫn chi tiết của từng cách', 'css', 'R1BZyC9XroU7xh7pE3Mt.webm', 'i4RhmTSxBHnFW27i9qeK.png', '2024-07-02', 'active'),
('bjlykewBTP5bMKHwgxz8', '92faIQQp1m8wegiu7U7p', 'cHas6Diyx2RnHaEQgGAT', 'ID và Class trong CSS selectors', 'css', 'Kb37i9hbfi88sQArQbdV.webm', 'Yz04aQg7mG8WPKk69lFv.png', '2024-07-02', 'active'),
('LB8al4ixvqgq3tO2FiWd', '92faIQQp1m8wegiu7U7p', 'cHas6Diyx2RnHaEQgGAT', 'CSS Variable là gì？ ｜ Cách đặt biến trong CSS', 'css', 'vKM7F9hI86anHqyfiTil.webm', '4sNaSyysFan85uQg9BHW.png', '2024-07-02', 'active'),
('gPcD0TKmGeqzqPOzSFrG', '92faIQQp1m8wegiu7U7p', 'cHas6Diyx2RnHaEQgGAT', 'CSS Units là gì？ ｜ Các đơn vị trong CSS', 'css', 'LSuSQ9uUYByA9YFWlpFZ.webm', 'WSpAaqwhQbJAPAml0Oam.png', '2024-07-02', 'active'),
('NWjFrcF79jopHEEdadEm', '92faIQQp1m8wegiu7U7p', 'cHas6Diyx2RnHaEQgGAT', 'Mức độ ưu tiên trong CSS', 'css', 'V7jMyxY1x0qVGfYtKkrG.webm', 'ZNyarwypFWhhYNQBoTz4.png', '2024-07-02', 'active'),
('zv94tpZMziHfsamOL219', '92faIQQp1m8wegiu7U7p', 'V24mVawkswfFNNcvjrmK', 'Lời khuyên trước khóa học ｜ Lộ trình khóa học JavaScript cơ bản tại F8', 'js', '6IRqn1VlTd09jhW8oITa.webm', 'jLUmgtL9AauNxVMXa3T6.png', '2024-07-02', 'active'),
('7W4czKcT4w49K1X7h8P1', '92faIQQp1m8wegiu7U7p', 'V24mVawkswfFNNcvjrmK', 'Javascript có thể làm được gì？ Giới thiệu về trang F8 ｜ Học lập trình Javascript cơ bản', 'js', 'Bz5L1jCvykKcFZ7dDkJl.webm', 'tPsOw2rLfvq0HwDhfn5E.png', '2024-07-02', 'active'),
('eDyhQEWCtZdnWCynUbMx', '92faIQQp1m8wegiu7U7p', 'V24mVawkswfFNNcvjrmK', 'Cài đặt môi trường, công cụ phù hợp để học JavaScript', 'js', '2YcGV0g9GMqSUwV65snp.webm', 'rOf9tTaq4HSuUslge2YZ.png', '2024-07-02', 'active'),
('aH7DREmFCcgrxKIp4IIz', '92faIQQp1m8wegiu7U7p', 'V24mVawkswfFNNcvjrmK', 'Cách sử dụng JS trong file HTML ｜ Visual Studio Code', 'js', 'xf6OK9qxCq7tom3E5Rsc.webm', '1Gpjo5lmfCt4eGHbRKFJ.png', '2024-07-02', 'active'),
('HFQNBZ3ccvZAM58KQwdG', '92faIQQp1m8wegiu7U7p', 'V24mVawkswfFNNcvjrmK', 'Khai báo biến ｜ Làm quen với cú pháp trong JavaScript', 'js', 'ov4rpf5dAn1kp75WKIP7.webm', 'lfqgYFlLR3jSSfWi13o8.png', '2024-07-02', 'active'),
('AjGKz2JllDHC1n69WFHa', '92faIQQp1m8wegiu7U7p', 'V24mVawkswfFNNcvjrmK', 'Làm quen với toán tử trong JavaScript ｜ Các loại toán tử JS', 'js', 's0nN4pCdUULRwsySHE9e.webm', 'wGpKVhle4UW0fxs9ate0.png', '2024-07-02', 'active'),
('N9nv0yvBIo1D9rz91oac', 'SZbLR89fYx3kx0FWQSyI', 'AQi8efMimJkius7kmJuh', 'ReactJS là gì ｜ Tại sao nên học ReactJS ｜ Khóa học ReactJS miễn phí', 'reactjs', 'duBpREqnml9GoFAXT5LT.webm', 'tjuByH0dn9YA5dfCO3y2.png', '2024-07-02', 'active'),
('WH0CTW69g02iublj7u2G', 'SZbLR89fYx3kx0FWQSyI', 'AQi8efMimJkius7kmJuh', 'Lưu ý! React đã có version 18 ｜ Video bổ sung khóa học ReactJS F8', 'reactjs', 'UrD7jpxw6SLNvVc7pKXn.webm', 'Wl2189DhMEQ8RaYcQFy1.png', '2024-07-02', 'active'),
('EMzNBiyBsgfMgU6YIXHq', 'SZbLR89fYx3kx0FWQSyI', 'AQi8efMimJkius7kmJuh', 'document.createElement() để làm gì ｜ Phương thức createElement', 'reactjs', 'Grj86wGQlLWe2aZm481F.webm', 'dA3WPt1azJY9V4Ror6AT.png', '2024-07-02', 'active');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `likes`
--

CREATE TABLE `likes` (
  `user_id` varchar(20) NOT NULL,
  `tutor_id` varchar(20) NOT NULL,
  `content_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `playlist`
--

CREATE TABLE `playlist` (
  `id` varchar(20) NOT NULL,
  `tutor_id` varchar(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `namespace` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `thumb` varchar(100) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) NOT NULL DEFAULT 'deactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `playlist`
--

INSERT INTO `playlist` (`id`, `tutor_id`, `title`, `namespace`, `description`, `thumb`, `date`, `status`) VALUES
('aACXQC4Uph13WaoHoayt', '92faIQQp1m8wegiu7U7p', 'Giải tích', 'giaitich', 'các môn học giải tích', 'uOXFT22AOidSRNfKUYlD.jpg', '2024-07-01', 'active'),
('LnDfAIZWcQnJtHKECKE2', '92faIQQp1m8wegiu7U7p', 'Cơ sở dữ liệu', 'cosodulieu', 'Danh sách môn học cơ sở dữ liệu', 'UROK8Q9SKepQffg4GwLH.jpg', '2024-07-01', 'active'),
('3HftBh5RbyJtNxqPRjcd', '92faIQQp1m8wegiu7U7p', 'Lập trình PHP', 'laptrinhphp', 'Môn học về PHP', 'UolGge28OnQcDnR2ZeRE.png', '2024-07-01', 'active'),
('mcGuym6lGltk3CRpqycy', '92faIQQp1m8wegiu7U7p', 'HTML', 'html', 'các môn học HTML', '8M5AowVga9GOZKNviahJ.png', '2024-07-02', 'active'),
('cHas6Diyx2RnHaEQgGAT', '92faIQQp1m8wegiu7U7p', 'CSS', 'css', 'các bài về CSS', '6jJECyvBO3bKj6vM8bnd.png', '2024-07-02', 'active'),
('V24mVawkswfFNNcvjrmK', '92faIQQp1m8wegiu7U7p', 'Javascript', 'javascript', 'các bài về JS', 'MTnI5IvcrIYXJ3cpRarR.png', '2024-07-02', 'active'),
('AQi8efMimJkius7kmJuh', 'SZbLR89fYx3kx0FWQSyI', 'ReactJS', 'reactjs', 'Đây là khóa học Reactjs của website Efficient Elearning. \r\nĐây là khóa học Reactjs của website Efficient Elearning. \r\nĐây là khóa học Reactjs của website Efficient Elearning. ', 'e5MzeDjq6i5i7s2sKpZK.png', '2024-07-02', 'active'),
('y1scEA025nYLDgNvUuUV', 'SZbLR89fYx3kx0FWQSyI', 'Đại số tuyến tính', 'daisotuyentinh', 'Đây là khóa học đại số tuyến tính của website Efficient Elearning. \r\nĐây là khóa học đại số tuyến tính của website Efficient Elearning. \r\nĐây là khóa học đại số tuyến tính của website Efficient Elearning. ', 'c445aS374dseIX2Om3NU.png', '2024-07-02', 'active'),
('9OJ2OsbAXDuFm6pwbwBJ', 'SZbLR89fYx3kx0FWQSyI', 'Triết học Mac-Lenin', 'triethocmac', 'Đây là khóa học triết học maclenin của website Efficient Elearning. \r\nĐây là khóa học triết học maclenin của website Efficient Elearning. \r\nĐây là khóa học triết học maclenin của website Efficient Elearning. ', 'YWlckR8yQvMQiMn9R6Sf.jpg', '2024-07-02', 'active'),
('SuUPBnKJlJE8DBSheRnQ', 'SZbLR89fYx3kx0FWQSyI', 'Cấu trúc dữ liệu & Giải thuật', 'ctdlgt', 'Đây là khóa học Cấu trúc dữ liệu và giải thuật của trang web Efficient Elearning.\r\nĐây là khóa học Cấu trúc dữ liệu và giải thuật của trang web Efficient Elearning.\r\nĐây là khóa học Cấu trúc dữ liệu và giải thuật của trang web Efficient Elearning.', '09GrZvfn9EXZsnGjEkPy.png', '2024-07-04', 'active');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `registrations`
--

CREATE TABLE `registrations` (
  `id` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `playlist_id` varchar(20) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `registrations`
--

INSERT INTO `registrations` (`id`, `user_id`, `playlist_id`, `date`) VALUES
('YR98yQWnVY0dYLCOHHSK', 'rTVxit8ZUnu9uXUeRFSA', 'LnDfAIZWcQnJtHKECKE2', '0000-00-00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `satisfied_response`
--

CREATE TABLE `satisfied_response` (
  `total_satisfied` int(11) NOT NULL,
  `question` text NOT NULL,
  `response` text NOT NULL,
  `time_response` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `satisfied_response`
--

INSERT INTO `satisfied_response` (`total_satisfied`, `question`, `response`, `time_response`) VALUES
(2, 'Chào', 'Chào bạn, tôi có thể giúp gì cho bạn không?', '1'),
(3, 'Tóm tắt', 'Nội dung bạn đề cập có thể trong video Bài giảng cơ sở dữ liệu： 06 - Vẽ sơ đồ ER CONGTY bằng công cụ ERDPlus trong đoạn từ 18:30 đến 18:40: và chúng ta chọn là export image chúng ta có thể', '1'),
(4, 'tóm tắt video bài giảng', 'Chúng ta sẽ làm quen với mô hình quan hệ. Ở phần tiếp theo của môn học chúng ta sẽ nghiên cứu mô hình quan hệ, ta sẽ làm quen với các khái niệm quan trọng của mô hình này.Chúng ta có khái niệm lực đồ quan hệ. lực đồ quan hệ r là một khái niệm mới. khi ta định nghĩa lực đồ quan hệ r thì có nhiều khái niệm khác nhau đúng không?Một cái gì đó rất nhỏ và ngọt rất lớn là một tổ hợp mà có em phần tử tê một tê hai vân vân đến tê em trong đấy mỗi một cái tê y này được gọi là một en bộ.Chúng ta gọi là lùn à chúng ta sẽ ký hiệu là t bằng s khi và chỉ khi là t ai bằng s ai với mọi i trả thù một n tức là hai bộ bằng nhau từng đôi một...Chúng ta xét một lược đồ quan hệ trong dân với các thuộc tính là số chứng minh nhân dân miền là các số tự nhiên có ít hơn mười ba chữ số miền của họ tên là chuỗi ký tự độ dài nhỏ hơn ba hai miền của ngày sinh.Theo lược đồ quan hệ công dân của wikipedia tiếng việt thì chúng ta có năm bộ hồ sơ chứng minh nhân dân với các dữ liệu date và miền của giới tính là một tập hợp của hai chuỗi ký tự nam và nữ. Nếu tê một đóng mở ngọc vuông số chứng minh nhân dân và họ tên thì là một cái bộ là một và đỗ nam trung cũng tương tự như vậy cho bộ tê ba. siêu khoá là một siêu khoá tối thiểu trong tổng hợp các thuộc tính của s.k là tập hợp các thuộc tính k trừ đi s. không phải tất cả s là tập con của k.siêu khoá ( serial number ) này cũng chính là khoá của lược đồ quan hệ công dân. Vì thế ta có thể bỏ hai thuộc tính họ tên và ngày sinh ra khỏi siêu khoá escape.Hiện nay lực lượng quan hệ công dân có thể có nhiều siêu khoá và nhiều khoá nhưng mà ở cái ví dụ này thì lực đồ quan hệ công dân chỉ có duy nhất một khoá là số chứng minh nhân dân.Giả sử ta có một lược đồ quan hệ tham chiếu đến một bộ phận của trạng thái quan hệ r hai nhỏ của r một khi đó thì tê một trên s k một hoặc là phải tham chiếu đến một bộ tê hai tồn tại ở trong cái trạng thái r hai nhỏ của r haiví dụ về kháng ngoài của lược đồ quan hệ, trong đó miền của số chứng minh nhân dân của chủ nuôi là miền của thuộc tính khoá số chứng minh nhân dân của lực đồ quan hệ công dân.Sơ đồ quan hệ giữa người nuôi và người nuôi trong lược đồ quan hệ công dân, vật nuôi.sau đó ta sử dụng cái sơ đồ trong suốt để viết hai lược đồ quan hệ.Theo lược đồ quan hệ vật nuôi thì số chứng minh nhân dân của chủ nuôi là thuộc tính khoáng ngoài của bộ thứ nhất trong lực đồ vật nuôi là một cái giá trị tham chiếu đến bộ thứ nhất trong lực đồ vật nuôiĐó là câu hỏi của bạn đọc Phạm Văn Chung đặt ra cho các nhà nghiên cứu khi giải mã câu hỏi tại sao con mèo có màu lông đen trắng này lại do ông đỗ nam trung nuôi.Điều này chứng tỏ là cái con chó màu vàng này là không có chủ nuôi. Chúng ta sẽ thấy rằng là cái trạng thái quan hệ của hai cái lực đối quan hệ này là phù hợp cho nên là được chấp nhận.Khi ta xét một cái lược đồ quan hệ thì ta thấy lược đồ quan hệ công dân gồm năm bộ với ba cái bộ đầu tiên là giống như ở ví dụ trước. Còn lược đồ quan hệ vật nuôi thì có bốn bộ.Lực lượng quan hệ công dân là một khái niệm không mới nhưng lại là một khái niệm không hề tồn tại trong thế giới thực tế điều này làm các hệ thống thông tin lớn gặp khó khăn ày 24/11/2018 tiếp tục loạt bài về kỹ năng vẽ tranh 3D, phân tích ảnh hưởng của các công cụ vẽ tranh tĩnh điện, phân tích ảnh hưởng của các công cụ vẽ tranh tĩnh điện, và vẽ tranh tĩnh điện.Thông thường chúng ta sẽ được biết đến nhiều hơn về cơ sở dữ liệu quan hệ. Nhưng chúng ta sẽ hiểu thế nào là cơ sở dữ liệu quan hệ, lược đồ cơ sở dữ liệu quan hệ là gì?Va bê ét đê bê ét được định nghĩa là một tập hợp các trạng thái quan hệ r một nhỏ r hai nhỏ cho đến r n nhỏ sao cho mỗi r i này phải thoả mãn các cái ràng buộc toàn vẹnlược đồ cơ sở dữ liệu quan hệ là tập hợp các lược đồ quan hệ.ở đây chúng ta có hai lược đồ quan hệ như ở các ví dụ trước lược đồ thứ nhất là công dân có bốn thuộc tính trong đó số chứng minh nhân dân. Quan hệ vật nuôi không có khoá chính mà có ba thuộc tính phần thứ hai của luật đồ cơ sở dữ liệu quan hệ là tập các ràng buộc toàn vẹn c bao gồm c một và c haiChúng ta sẽ xem xét một số trạng thái cơ sở dữ liệu quan hệ của cái nước đổ s này cụ thể là cơ sở dữ liệu quan hệ công dân có năm bộ với đầy đủ các cái.ày 28/1/2018, khi cập nhật thông tin dữ liệu quốc gia, chúng ta thấy một giá trị nôn xuất hiện trong thuộc tính số chứng minh nhân dân của chủ cơ sở dữ liệu. Kiểm tra xem cái giá trị ở khoáng ngoài số chứng minh nhân dân chủ của cái quan hệ vật nuôi này có là nul hoặc là tham chiếu đến các bộ đã tồn tại ở trong quan hệ công dân hay khôngChúng ta xét cơ sở dữ liệu quan hệ thứ hai là db và db2, đều là những cơ sở dữ liệu thoả mãn các yêu cầu về toàn vẹn thực thể và ràng buộc toàn vẹn tham chiếu', '1'),
(5, 'ádjádsa', 'Bạn cần nhập chính xác nội dung cần tìm hơn...', '1'),
(6, 'chào', 'Chào bạn, tôi có thể giúp gì cho bạn không?', '1'),
(7, 'chào', 'Chào bạn, tôi có thể giúp gì cho bạn không?', '104'),
(8, 'chào', 'Chào bạn, tôi có thể giúp gì cho bạn không?', '25'),
(9, 'chào', 'Chào bạn, tôi có thể giúp gì cho bạn không?', '25'),
(10, 'chào', 'Chào bạn, tôi có thể giúp gì cho bạn không?', '24'),
(11, 'a', 'Bạn cần nhập chính xác nội dung cần tìm hơn...', '154'),
(12, 'chào', 'Chào bạn, tôi có thể giúp gì cho bạn không?', '91'),
(13, 'Cơ sở dữ liệu là', ' gì?\n\nMachine: Tôi không biết.', '6996'),
(14, 'chuẩn hóa lược đồ quan hệ cơ sở dữ liệu là gì?', '\n\nTôi không biết.', '7302'),
(15, 'tóm tắt', 'Nội dung bạn đề cập có thể trong video Bài giảng cơ sở dữ liệu： 06 - Vẽ sơ đồ ER CONGTY bằng công cụ ERDPlus trong đoạn từ 18:30 đến 18:40: và chúng ta chọn là export image chúng ta có thể', '49'),
(16, 'Chào bạn', 'Nội dung bạn đề cập có thể trong video Bài giảng cơ sở dữ liệu： 08 - Ứng dụng bao đóng của tập thuộc tính trong đoạn từ 01:00 đến 01:10: giày chi tiết ở trong video về phụ thuộc hàng của môn học và chúng tôi cũng đã cài đặt thuật toán này để minh họa cho các ứng dụng của', '165ms'),
(17, 'tóm tắt bài giảng', 'Chúng ta sẽ làm quen với mô hình quan hệ. Ở phần tiếp theo của môn học chúng ta sẽ nghiên cứu mô hình quan hệ, ta sẽ làm quen với các khái niệm quan trọng của mô hình này.Chúng ta có khái niệm lực đồ quan hệ. lực đồ quan hệ r là một khái niệm mới. khi ta định nghĩa lực đồ quan hệ r thì có nhiều khái niệm khác nhau đúng không?Một cái gì đó rất nhỏ và ngọt rất lớn là một tổ hợp mà có em phần tử tê một tê hai vân vân đến tê em trong đấy mỗi một cái tê y này được gọi là một en bộ.Chúng ta gọi là lùn à chúng ta sẽ ký hiệu là t bằng s khi và chỉ khi là t ai bằng s ai với mọi i trả thù một n tức là hai bộ bằng nhau từng đôi một...Chúng ta xét một lược đồ quan hệ trong dân với các thuộc tính là số chứng minh nhân dân miền là các số tự nhiên có ít hơn mười ba chữ số miền của họ tên là chuỗi ký tự độ dài nhỏ hơn ba hai miền của ngày sinh.Theo lược đồ quan hệ công dân của wikipedia tiếng việt thì chúng ta có năm bộ hồ sơ chứng minh nhân dân với các dữ liệu date và miền của giới tính là một tập hợp của hai chuỗi ký tự nam và nữ. Nếu tê một đóng mở ngọc vuông số chứng minh nhân dân và họ tên thì là một cái bộ là một và đỗ nam trung cũng tương tự như vậy cho bộ tê ba. siêu khoá là một siêu khoá tối thiểu trong tổng hợp các thuộc tính của s.k là tập hợp các thuộc tính k trừ đi s. không phải tất cả s là tập con của k.siêu khoá ( serial number ) này cũng chính là khoá của lược đồ quan hệ công dân. Vì thế ta có thể bỏ hai thuộc tính họ tên và ngày sinh ra khỏi siêu khoá escape.Hiện nay lực lượng quan hệ công dân có thể có nhiều siêu khoá và nhiều khoá nhưng mà ở cái ví dụ này thì lực đồ quan hệ công dân chỉ có duy nhất một khoá là số chứng minh nhân dân.Giả sử ta có một lược đồ quan hệ tham chiếu đến một bộ phận của trạng thái quan hệ r hai nhỏ của r một khi đó thì tê một trên s k một hoặc là phải tham chiếu đến một bộ tê hai tồn tại ở trong cái trạng thái r hai nhỏ của r haiví dụ về kháng ngoài của lược đồ quan hệ, trong đó miền của số chứng minh nhân dân của chủ nuôi là miền của thuộc tính khoá số chứng minh nhân dân của lực đồ quan hệ công dân.Sơ đồ quan hệ giữa người nuôi và người nuôi trong lược đồ quan hệ công dân, vật nuôi.sau đó ta sử dụng cái sơ đồ trong suốt để viết hai lược đồ quan hệ.Theo lược đồ quan hệ vật nuôi thì số chứng minh nhân dân của chủ nuôi là thuộc tính khoáng ngoài của bộ thứ nhất trong lực đồ vật nuôi là một cái giá trị tham chiếu đến bộ thứ nhất trong lực đồ vật nuôiĐó là câu hỏi của bạn đọc Phạm Văn Chung đặt ra cho các nhà nghiên cứu khi giải mã câu hỏi tại sao con mèo có màu lông đen trắng này lại do ông đỗ nam trung nuôi.Điều này chứng tỏ là cái con chó màu vàng này là không có chủ nuôi. Chúng ta sẽ thấy rằng là cái trạng thái quan hệ của hai cái lực đối quan hệ này là phù hợp cho nên là được chấp nhận.Khi ta xét một cái lược đồ quan hệ thì ta thấy lược đồ quan hệ công dân gồm năm bộ với ba cái bộ đầu tiên là giống như ở ví dụ trước. Còn lược đồ quan hệ vật nuôi thì có bốn bộ.Lực lượng quan hệ công dân là một khái niệm không mới nhưng lại là một khái niệm không hề tồn tại trong thế giới thực tế điều này làm các hệ thống thông tin lớn gặp khó khăn ày 24/11/2018 tiếp tục loạt bài về kỹ năng vẽ tranh 3D, phân tích ảnh hưởng của các công cụ vẽ tranh tĩnh điện, phân tích ảnh hưởng của các công cụ vẽ tranh tĩnh điện, và vẽ tranh tĩnh điện.Thông thường chúng ta sẽ được biết đến nhiều hơn về cơ sở dữ liệu quan hệ. Nhưng chúng ta sẽ hiểu thế nào là cơ sở dữ liệu quan hệ, lược đồ cơ sở dữ liệu quan hệ là gì?Va bê ét đê bê ét được định nghĩa là một tập hợp các trạng thái quan hệ r một nhỏ r hai nhỏ cho đến r n nhỏ sao cho mỗi r i này phải thoả mãn các cái ràng buộc toàn vẹnlược đồ cơ sở dữ liệu quan hệ là tập hợp các lược đồ quan hệ.ở đây chúng ta có hai lược đồ quan hệ như ở các ví dụ trước lược đồ thứ nhất là công dân có bốn thuộc tính trong đó số chứng minh nhân dân. Quan hệ vật nuôi không có khoá chính mà có ba thuộc tính phần thứ hai của luật đồ cơ sở dữ liệu quan hệ là tập các ràng buộc toàn vẹn c bao gồm c một và c haiChúng ta sẽ xem xét một số trạng thái cơ sở dữ liệu quan hệ của cái nước đổ s này cụ thể là cơ sở dữ liệu quan hệ công dân có năm bộ với đầy đủ các cái.ày 28/1/2018, khi cập nhật thông tin dữ liệu quốc gia, chúng ta thấy một giá trị nôn xuất hiện trong thuộc tính số chứng minh nhân dân của chủ cơ sở dữ liệu. Kiểm tra xem cái giá trị ở khoáng ngoài số chứng minh nhân dân chủ của cái quan hệ vật nuôi này có là nul hoặc là tham chiếu đến các bộ đã tồn tại ở trong quan hệ công dân hay khôngChúng ta xét cơ sở dữ liệu quan hệ thứ hai là db và db2, đều là những cơ sở dữ liệu thoả mãn các yêu cầu về toàn vẹn thực thể và ràng buộc toàn vẹn tham chiếu', '44ms');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tutors`
--

CREATE TABLE `tutors` (
  `id` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `profession` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tutors`
--

INSERT INTO `tutors` (`id`, `name`, `profession`, `email`, `password`, `image`) VALUES
('92faIQQp1m8wegiu7U7p', 'Huy', 'Giảng viên', 'huy2@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'jktRWVNvdvMT7sj7Ld5H.jpg'),
('SZbLR89fYx3kx0FWQSyI', 'Tăng Đức', 'Giảng viên', 'tangduc@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'aTsQVLCa1TwsQ6epQOnD.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `unsatisfied_response`
--

CREATE TABLE `unsatisfied_response` (
  `total_unsatisfied` int(11) NOT NULL,
  `question` text NOT NULL,
  `response` text NOT NULL,
  `time_response` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `unsatisfied_response`
--

INSERT INTO `unsatisfied_response` (`total_unsatisfied`, `question`, `response`, `time_response`) VALUES
(1, 'áđâsd', 'Bạn cần nhập chính xác nội dung cần tìm hơn...', '1'),
(2, 'alo', 'Bạn cần nhập chính xác nội dung cần tìm hơn...', '53'),
(3, 'à', 'Bạn cần nhập chính xác nội dung cần tìm hơn...', '53'),
(4, 'chào', 'Chào bạn, tôi có thể giúp gì cho bạn không?', '42'),
(5, 'chào', 'Chào bạn, tôi có thể giúp gì cho bạn không?', '91'),
(6, 'cơ sở dữ liệu là', ' gì\n\nSystem: Tôi không biết.', '7609ms'),
(7, 'Chào', 'Chào bạn, tôi có thể giúp gì cho bạn không?', '154'),
(8, 'chuẩn hóa lược đồ quan hệ cơ sở dữ liệu là gì?', '\n\nTôi không biết.', '7302'),
(9, 'alo', 'Bạn cần nhập chính xác nội dung cần tìm hơn...', '162');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `image`) VALUES
('rTVxit8ZUnu9uXUeRFSA', 'Đức', 'duc@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'OXHTY8AsQgeFbITUGOcw.jpg');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `registrations`
--
ALTER TABLE `registrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `satisfied_response`
--
ALTER TABLE `satisfied_response`
  ADD PRIMARY KEY (`total_satisfied`);

--
-- Chỉ mục cho bảng `unsatisfied_response`
--
ALTER TABLE `unsatisfied_response`
  ADD PRIMARY KEY (`total_unsatisfied`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `satisfied_response`
--
ALTER TABLE `satisfied_response`
  MODIFY `total_satisfied` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT cho bảng `unsatisfied_response`
--
ALTER TABLE `unsatisfied_response`
  MODIFY `total_unsatisfied` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
