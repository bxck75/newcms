<div>
	<?php if(isset($this->msg)){ ?>
	<div class="msg"><?php echo $this->msg; ?></div>
	<?php } ?>
	<form name="form" method="post" action="index.php?route=<?php echo $_GET['route'] ?>&token=<?php echo $_GET['token'] ?>" enctype="multipart/form-data">
	 <h2 class="form-signin-heading"><?php echo $this->label_category_menu; ?></h2>
        <input type="hidden" name="id" value="<?php echo (isset($_GET['id']))?$_GET['id']:''; ?>" />
	<table class="list">
            <?php //echo"<pre>";var_dump($this->parent_category_data);echo "</pre>"; ?>
		<tr>
			<td><?php echo $this->label_category_name; ?> : </td>
			<td><input class="required form-control" type="text" name="req_name" value="<?php echo stripslashes($this->category['category_name']); ?>" /></td>
		</tr>

		<tr>
			<td><?php echo $this->label_category_text; ?></td>
			<td><input class="required form-control" type="text" name="req_text" value="<?php echo stripslashes($this->category['category_text']); ?>" /></td>
			
		</tr>
		<tr>
			<td><?php echo $this->label_category_parent_choose; ?></td>
                        <td> 
                        <select class="form-control " id="element_1" name="req_parent_category"> 
                            <?php foreach($this->parent_category_data as $parent_cat) { ?>
                            <?php //var_dump($parent_cat);//die(); ?>
                                <?php if($parent_cat['category_name'] != ''){ ?>
                                    <?php if($this->category['parent_id'] == $parent_cat['category_id']) { ?>
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
		<tr><td colspan="2"><input class="btn btn-lg btn-primary btn-block" type="button" onclick="validate();" name="btnSubmit" value="Opslaan" /></td></tr>
		<tr><td colspan="2"><input class="btn btn-lg btn-primary btn-block" type="button" name="btnBack" value="Annuleren" onclick="document.location.href='index.php?route=category/overview&token=<?php echo $_GET['token']; ?>'" /></td></tr>
               <?php //var_dump($this->category_branch_id); ?>
                
                <input type="hidden"  name="branch_in" value="<?php echo $this->category_branch_id[0]['branch_in']; ?>" />
        
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














