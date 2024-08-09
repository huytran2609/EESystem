<?php

include 'components/connect.php';

if(isset($_COOKIE['user_id'])){
   $user_id = $_COOKIE['user_id'];
}else{
   $user_id = '';
}

if(isset($_GET['get_id'])){
   $get_id = $_GET['get_id'];
}else{
   $get_id = '';
   header('location:home.php');
}

if(isset($_POST['save_list'])){

   if($user_id != ''){
      
      $list_id = $_POST['list_id'];
      $list_id = filter_var($list_id, FILTER_SANITIZE_STRING);

      $select_list = $conn->prepare("SELECT * FROM `registrations` WHERE user_id = ? AND playlist_id = ?");
      $select_list->execute([$user_id, $list_id]);

      if($select_list->rowCount() > 0){
         $remove_registrations = $conn->prepare("DELETE FROM `registrations` WHERE user_id = ? AND playlist_id = ?");
         $remove_registrations->execute([$user_id, $list_id]);
         $message[] = 'Đã xóa khoá học!';
      }else{
         $id = unique_id();
         $insert_registrations = $conn->prepare("INSERT INTO `registrations`(id, user_id, playlist_id) VALUES(?,?,?)");
         $insert_registrations->execute([$id, $user_id, $list_id]);
         $message[] = 'Đã đăng ký khóa học!';
      }

   }else{
      $message[] = 'Vui lòng đăng nhập trước!';
   }

}

?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Khóa học</title>

   <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

   <!-- custom css file link  -->
   <link rel="stylesheet" href="css/chatbot.css?v=1.0">
   <link rel="stylesheet" href="css/style.css?v=1.0">

</head>
<body>

<?php include 'components/user_header.php'; ?>

<!-- playlist section starts  -->

<section class="playlist">

   <h1 class="heading">Chi tiết khóa học</h1>

   <div class="row">

      <?php
         $select_playlist = $conn->prepare("SELECT * FROM `playlist` WHERE id = ? and status = ? LIMIT 1");
         $select_playlist->execute([$get_id, 'active']);
         if($select_playlist->rowCount() > 0){
            $fetch_playlist = $select_playlist->fetch(PDO::FETCH_ASSOC);

            $playlist_id = $fetch_playlist['id'];
            $namespace = $fetch_playlist['namespace'];
            // Đưa namespace vào JavaScript
            echo "<script>const playlistNamespace = " . json_encode($namespace) . ";</script>";

            $count_videos = $conn->prepare("SELECT * FROM `content` WHERE playlist_id = ?");
            $count_videos->execute([$playlist_id]);
            $total_videos = $count_videos->rowCount();

            $select_tutor = $conn->prepare("SELECT * FROM `tutors` WHERE id = ? LIMIT 1");
            $select_tutor->execute([$fetch_playlist['tutor_id']]);
            $fetch_tutor = $select_tutor->fetch(PDO::FETCH_ASSOC);

            $select_registrations = $conn->prepare("SELECT * FROM `registrations` WHERE user_id = ? AND playlist_id = ?");
            $select_registrations->execute([$user_id, $playlist_id]);

      ?>

      <div class="col">
         <form action="" method="post" class="save-list">
            <input type="hidden" name="list_id" value="<?= $playlist_id; ?>">
            <?php
               if($select_registrations->rowCount() > 0){
            ?>
            <button type="submit" name="save_list"><span>Đã đăng ký khóa học</span></button>
            <?php
               }else{
            ?>
               <button type="submit" name="save_list"><span>Đăng ký khóa học</span></button>
            <?php
               }
            ?>
         </form>
         <div class="thumb">
            <span><?= $total_videos; ?> Bài giảng</span>
            <img src="uploaded_files/<?= $fetch_playlist['thumb']; ?>" alt="">
         </div>
      </div>

      <div class="col">
         <div class="tutor">
            <img src="uploaded_files/<?= $fetch_tutor['image']; ?>" alt="">
            <div>
               <h3><?= $fetch_tutor['name']; ?></h3>
               <span><?= $fetch_tutor['profession']; ?></span>
            </div>
         </div>
         <div class="details">
            <h3><?= $fetch_playlist['title']; ?></h3>
            <p><?= $fetch_playlist['description']; ?></p>
            <div class="date"><i class="fas fa-calendar"></i><span><?= $fetch_playlist['date']; ?></span></div>
         </div>
      </div>

      <?php
         }else{
            echo '<p class="empty">Không tìm thấy bài giảng!</p>';
         }  
      ?>

   </div>

</section>

<!-- playlist section ends -->

<!-- videos container section starts  -->

<section class="videos-container">

   <h1 class="heading">Bài giảng của khóa học</h1>

   <div class="box-container">

      <?php
         $select_content = $conn->prepare("SELECT * FROM `content` WHERE playlist_id = ? AND status = ? ORDER BY date DESC");
         $select_content->execute([$get_id, 'active']);
         if($select_content->rowCount() > 0){
            while($fetch_content = $select_content->fetch(PDO::FETCH_ASSOC)){  
      ?>
      <a href="watch_video.php?get_id=<?= $fetch_content['id']; ?>" class="box">
         <i class="fas fa-play"></i>
         <img src="uploaded_files/<?= $fetch_content['thumb']; ?>" alt="">
         <h3><?= $fetch_content['title']; ?></h3>
      </a>
      <?php
            }
         }else{
            echo '<p class="empty">Chưa có bài giảng nào!</p>';
         }
      ?>

   </div>

</section>

<!-- videos container section ends -->


<?php 
   if($select_registrations->rowCount() > 0){
?>
<button class="chatbot-toggler">
   <span class="material-symbols-rounded"><i class="fas fa-comment-alt"></i></span>
   <span class="material-symbols-outlined"><i class="fas fa-xmark"></span>
</button>
<?php
}
?>
<div class="chatbot">
   <header>
      <h2>Chatbot</h2>
      <select class="chat-option" id="chat-options">
         <option value="summarize-search">Tóm tắt và tìm kiếm nội dung</option>
         <option value="answer-question">Trả lời câu hỏi nội dung</option>
      </select>
      <span class="close-btn material-symbols-outlined">close</span>
   </header>
   <ul class="chatbox">
      <li class="chat incoming">
         <span class="material-symbols-outlined"><img class="chatbot-icon" src="./images/chatbot.png" alt="chatbot"></span>
         <p>Xin chào 👋<br>Hãy lựa chọn chức năng để tôi có thể giúp bạn</p>
      </li>
   </ul>
   <div class="chat-input">
      <textarea placeholder="Nhập nội dung..." spellcheck="false" required></textarea>
      <span id="send-btn" class="material-symbols-rounded"><img class="send-icon" src="./images/paper.png" alt="Gửi"></span>
   </div>
</div>






<!-- custom js file link  -->
<script src="js/chatbot.js?v=1.0"></script>
<script src="js/script.js"></script>
   
</body>
</html>