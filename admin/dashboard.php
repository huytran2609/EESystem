<?php

include '../components/connect.php';

if(isset($_COOKIE['tutor_id'])){
   $tutor_id = $_COOKIE['tutor_id'];
}else{
   $tutor_id = '';
   header('location:login.php');
}

$select_contents = $conn->prepare("SELECT * FROM `content` WHERE tutor_id = ?");
$select_contents->execute([$tutor_id]);
$total_contents = $select_contents->rowCount();

$select_playlists = $conn->prepare("SELECT * FROM `playlist` WHERE tutor_id = ?");
$select_playlists->execute([$tutor_id]);
$total_playlists = $select_playlists->rowCount();

$select_likes = $conn->prepare("SELECT * FROM `likes` WHERE tutor_id = ?");
$select_likes->execute([$tutor_id]);
$total_likes = $select_likes->rowCount();

$select_comments = $conn->prepare("SELECT * FROM `comments` WHERE tutor_id = ?");
$select_comments->execute([$tutor_id]);
$total_comments = $select_comments->rowCount();

$select_satisfied = $conn->prepare("SELECT * FROM `satisfied_response`");
$select_satisfied->execute();
$total_satisfied = $select_satisfied->rowCount();

$select_unsatisfied = $conn->prepare("SELECT * FROM `unsatisfied_response`");
$select_unsatisfied->execute();
$total_unsatisfied = $select_unsatisfied->rowCount();

?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Bảng điều khiển</title>

   <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

   <!-- custom css file link  -->
   <link rel="stylesheet" href="../css/admin_style.css">

</head>
<body>

<?php include '../components/admin_header.php'; ?>
   
<section class="dashboard">

   <h1 class="heading">Bảng điều khiển</h1>

   <div class="box-container">

      <div class="box">
         <h3>Xin chào!</h3>
         <p><?= $fetch_profile['name']; ?></p>
         <a href="profile.php" class="btn">Xem hồ sơ</a>
      </div>

      <div class="box">
         <h3><?= $total_contents; ?></h3>
         <p>Tổng bài giảng</p>
         <a href="add_content.php" class="btn">Thêm bài giảng mới</a>
      </div>

      <div class="box">
         <h3><?= $total_playlists; ?></h3>
         <p>Tổng khóa học</p>
         <a href="add_playlist.php" class="btn">Thêm khóa học mới</a>
      </div>

      <div class="box">
         <h3><?= $total_likes; ?></h3>
         <p>Tổng lượt thích</p>
         <a href="contents.php" class="btn">Xem bài giảng</a>
      </div>

      <div class="box">
         <h3><?= $total_comments; ?></h3>
         <p>Tổng bình luận</p>
         <a href="comments.php" class="btn">Xem bình luận</a>
      </div>

      <div class="box" >
         <div style="display: flex">
            <div style="width: 160px">
               <h3><?= $total_satisfied; ?></h3>
               <p>Hài lòng</p>
            </div>
            <div style="width: 180px; margin-left: 10px">
               <h3><?= $total_unsatisfied; ?></h3>
               <p>Không hài lòng</p>
            </div>
         </div>
         <a style="margin-top: 0 " href="http://localhost/phpmyadmin/index.php?route=/sql&pos=0&db=course_db&table=satisfied_response" class="btn">Xem chi tiết</a>
      </div>

      <div class="box">
         <h3>Tính năng</h3>
         <p>Đăng nhập hoặc Đăng ký</p>
         <div class="flex-btn">
            <a href="login.php" class="option-btn">Đăng nhập</a>
            <a href="register.php" class="option-btn">Đăng ký</a>
         </div>
      </div>

   </div>

</section>

















<script src="../js/admin_script.js"></script>

</body>
</html>