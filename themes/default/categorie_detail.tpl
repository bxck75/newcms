<div>
	<?php if(isset($this->msg)){ ?>
	<div class="msg"><?php echo $this->msg; ?></div>
	<?php } ?>
	<form name="form" method="post" action="index.php?route=<?php echo $_GET['route'] ?>&token=<?php echo $_GET['token'] ?>" enctype="multipart/form-data">
	<input type="hidden" name="id" value="<?php echo (isset($_GET['id']))?$_GET['id']:''; ?>" />
	<table class="list">
            <?php //echo"<pre>";var_dump($this->category_childs);echo "</pre>"; ?>
		<tr>
			<td><?php echo $this->label_category_name; ?> : </td>
			<td><input class="required" type="text" name="category_name" value="<?php echo stripslashes($this->category['category_name']); ?>" /></td>
		</tr>

		<tr>
			<td><?php echo $this->label_category_text; ?></td>
			<td><input class="required" type="text" name="category_text" value="<?php echo stripslashes($this->category['category_text']); ?>" /></td>
			
		</tr>
		<tr><td colspan="2"><input type="button" onclick="validate();" name="btnSubmit" value="Opslaan" /></td></tr>
		<tr><td colspan="2"><input type="button" name="btnBack" value="Annuleren" onclick="document.location.href='index.php?route=category/overview&token=<?php echo $_GET['token']; ?>'" /></td></tr>
	</table>
	</form>
</div>
<script>
    
	$(document).ready(function(){
		$('input[name^="req"]').each(function(){
			$(this).after('<span>*</span>');
		});
                
	});
	
	function validate(){
                 $('form').submit();
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
			error = true;
		}


                if(error == false)
                    $('form').submit();
                
		
	}

	
	
</script>














