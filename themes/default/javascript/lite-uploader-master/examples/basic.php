<?php

if ($_FILES['fileUpload']['name']) {
    echo $uploadedUrl = './themes/default/uploads/' . $_FILES['fileUpload']['name']; die;
    move_uploaded_file($_FILES['fileUpload']['tmp_name'], $uploadedUrl);
}

echo json_encode('Ok');
exit;
