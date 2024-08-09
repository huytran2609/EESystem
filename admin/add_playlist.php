<?php

include '../components/connect.php';

if(isset($_COOKIE['tutor_id'])){
   $tutor_id = $_COOKIE['tutor_id'];
}else{
   $tutor_id = '';
   header('location:login.php');
}

if(isset($_POST['submit'])){

   $id = unique_id();
   $title = $_POST['title'];
   $title = filter_var($title, FILTER_SANITIZE_STRING);
   $namespace = $_POST['namespace'];
   $namespace = filter_var($namespace, FILTER_SANITIZE_STRING);
   $description = $_POST['description'];
   $description = filter_var($description, FILTER_SANITIZE_STRING);
   $status = $_POST['status'];
   $status = filter_var($status, FILTER_SANITIZE_STRING);

   $image = $_FILES['image']['name'];
   $image = filter_var($image, FILTER_SANITIZE_STRING);
   $ext = pathinfo($image, PATHINFO_EXTENSION);
   $rename = unique_id().'.'.$ext;
   $image_size = $_FILES['image']['size'];
   $image_tmp_name = $_FILES['image']['tmp_name'];
   $image_folder = '../uploaded_files/'.$rename;

   // Thêm bản ghi vào cơ sở dữ liệu với trường namespace
   $add_playlist = $conn->prepare("INSERT INTO `playlist` (id, tutor_id, title, description, thumb, status, namespace) VALUES (?, ?, ?, ?, ?, ?, ?)");
   $add_playlist->execute([$id, $tutor_id, $title, $description, $rename, $status, $namespace]);

   // Di chuyển tệp tải lên và kiểm tra lỗi
   if (move_uploaded_file($image_tmp_name, $image_folder)) {
      $message[] = 'Khóa học mới đã được tạo!';
   } else {
      $message[] = 'Lỗi khi tải lên hình ảnh!';
   } 

}



?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Thêm khóa học</title>

   <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

   <!-- custom css file link  -->
   <link rel="stylesheet" href="../css/admin_style.css">

</head>
<body>

<?php include '../components/admin_header.php'; ?>
   
<section class="playlist-form">

   <h1 class="heading">Tạo khóa học</h1>

   <form action="" method="post" enctype="multipart/form-data">
      <p>Trạng thái khóa học <span>*</span></p>
      <select name="status" class="box" required>
         <option value="" selected disabled>-- Chọn trạng thái</option>
         <option value="active">Kích hoạt</option>
         <option value="deactive">Chưa kích hoạt</option>
      </select>
      <p>Tiêu đề khóa học<span>*</span></p>
      <input type="text" name="title" maxlength="100" required placeholder="Nhập tiêu đề khóa học" class="box">
      <p>Namespace <span>*</span></p>
      <input type="text" name="namespace" maxlength="255" required placeholder="Nhập namespace khóa học" class="box">
      <p>Mô tả khóa học <span>*</span></p>
      <textarea name="description" class="box" required placeholder="Nhập mô tả khóa học" maxlength="1000" cols="30" rows="10"></textarea>
      <p>Hình thu nhỏ khóa học <span>*</span></p>
      <input type="file" name="image" accept="image/*" required class="box">
      <input type="submit" value="Tạo khóa học" name="submit" class="btn">
   </form>

</section>


<?php include '../components/footer.php'; ?>

<script src="../js/admin_script.js"></script>

</body>
</html>