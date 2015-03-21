<div>
	<?php if(isset($this->msg)){ ?>
	<div class="msg"><?php echo $this->msg; ?></div>
	<?php } ?>
	<form name="form" method="post" action="index.php?route=<?php echo $_GET['route'] ?>&token=<?php echo $_GET['token'] ?>" enctype="multipart/form-data">
	<input type="hidden" name="id" value="<?php echo (isset($_GET['id']))?$_GET['id']:''; ?>" />
	<table class="list">
            <?php //echo"<pre>";var_dump($this->parent_product_data);echo "</pre>"; ?>
		<tr>
			<td><?php echo $this->label_product_name; ?> : </td>
			<td><input class="required" type="text" name="req_name" value="<?php echo stripslashes($this->product['name']); ?>" /></td>
		</tr>
                <tr>
			<td><?php echo $this->label_product_parent_choose; ?></td>
                        <td> 
                        <select class="element select medium" id="element_1" name="parent_category"> 
                            <?php foreach($this->parent_category_data as $parent_cat) { ?>
                                <?php if($parent_cat['category_name'] != ''){ ?>
                                        <?php echo $parent_cat['product_id']; ?>
                                        <?php //echo $_GET['id']; ?>
                                        <?php //echo "<pre>";var_dump($this->parent_category_data);echo"</pre>"; ?>
                                        <?php echo "<pre>";var_dump($this->product);echo"</pre>"; ?>
                                    <?php if($this->product[category_id] == $parent_cat['category_id']) { ?>
                                        <option value="<?php echo $parent_cat['category_id']; ?>" selected='selected' ><?php echo $parent_cat['category_name']; ?></option>
                                   <?php  }else{ ?>
                                        <option value="<?php echo $parent_cat['category_id']; ?>" ><?php echo $parent_cat['category_name']; ?></option>        
<?php                               }
                                }
                           } 
?>
                                

                        </select> 
                        </td>
			
		</tr>
		<tr><td colspan="2"><input type="button" onclick="validate();" name="btnSubmit" value="Opslaan" /></td></tr>
		<tr><td colspan="2"><input type="button" name="btnBack" value="Annuleren" onclick="document.location.href='index.php?route=product/overview&token=<?php echo $_GET['token']; ?>'" /></td></tr>
                <tr>
                    <input type="file" name="fileUpload" id="fileUpload" class="fileUpload" />

                </tr>
        
        </table>
	</form>
</div>
<?php if(file_exist('./themes/default/uploads/basic.php'){echo "yeselse{echo "No!";} ?>
<script>
    
	$(document).ready(function(){
                var int ID = <?php echo $_GET["id"]; ?>;
		$('input[name^="req"]').each(function(){
			$(this).after('<span>*</span>');
		})
                $('.fileUpload').liteUploader({
				script: './themes/default/uploads/basic.php';
			})
			.on('lu:success', function (e, response) {
				alert('Uploaded!');
			});
                
	});
	
	function validate(){
                 
		error = false;
		
		$('input[name^="req"]').each(function(){
			$(this).parent().find('span').html('*');
			
			if($(this).val() == ''){
				$(this).css('border', '1px solid #f00');
				$(this).parent().find('span').append('   Dit veld is verplicht!');
				error = true;
			}
		});
		
		if(isNaN($('input[name^="reqnum"]').val())){
			$('input[name="req_price"]').css('border', '1px solid #f00');
			$('input[name="req_price"]').parent().find('span').append('   Dit moet een getal zijn!');
			error = false;
		}


                if(error == false)
                    $('form').submit();
                
		
	}

	
	
</script>














