<?php
echo "HALLO";
if ($_FILES['fileUpload']['name']) {
    $uploadedUrl = 'product_image_id_'.$_GET['product_id'].$_FILES['fileUpload']['name']; 
    move_uploaded_file($_FILES['fileUpload']['tmp_name'], $uploadedUrl);
}

echo json_encode('Ok');
exit;
