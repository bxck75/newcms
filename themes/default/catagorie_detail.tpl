<div>
	<?php if(isset($this->msg)){ ?>
	<div class="msg"><?php echo $this->msg; ?></div>
	<?php } ?>
	<form name="frm" method="post" action="index.php?route=<?php echo $_GET['route'] ?>&token=<?php echo $_GET['token'] ?>" enctype="multipart/form-data">
	<input type="hidden" name="id" value="<?php echo (isset($_GET['id']))?$_GET['id']:''; ?>" />
	<table class="list">
            <?php echo"<pre>";var_dump($this->catagorie_childs);echo "</pre>"; ?>
		<tr>
			<td><?php echo $this->label_catagorie_name; ?> : </td>
			<td><input class="required" type="text" name="req_name" value="<?php echo stripslashes($this->catagorie['category_name']); ?>" /></td>
		</tr>

		<tr>
			<td><?php echo $this->label_catagorie_parent_id; ?></td>
			<td><input class="required" type="text" name="reqnum_parent_id" value="<?php echo $this->catagorie['parent_category_id']; ?>" /></td>
		</tr>
		
                <?php if(is_array($this->catagorie_childs)){
                    foreach($this->catagorie_childs as $children){ ?>
                    <tr>
                            <td><?php echo $this->label_category_child; ?></td>
                            <td>
                                    <select name="catagory[]">
                                            <option value="">-- Selecteer een locatie --</option>
                                            <?php foreach($this->catagorys as $catagory){ ?>
                                            <option value="<?php echo $catagory['catagory_id'] ?>" <?php echo ($catagory['catagory_id'] == $catagory_id['catagory_id'])?'selected="selected"':''; ?>><?php echo $catagory['name'] ?></option>
                                            <?php } ?>
                                    </select> <img src="./themes/<?php echo THEME ?>/images/remove.png" onclick="deleteCatagory(this);" />
                            </td>
                    </tr>
                    <?php } ?>
                <?php } ?>
		<tr class="catagory_placeholder">
			<td colspan="2"><input type="button" name="addCatagoryhtml" value="Add catagory" onclick="addCatagory();" /></td>
		</tr>
		<tr><td colspan="2"><input type="button" onclick="validate();" name="btnSubmit" value="Opslaan" /></td></tr>
		<tr><td colspan="2"><input type="button" name="btnBack" value="Annuleren" onclick="document.location.href='index.php?route=catagorie/overview&token=<?php echo $_GET['token']; ?>'" /></td></tr>
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
			error = true;
		}

		catagory_array = [];
		
		$('select[name="catagory[]"]').each(function(){
                        
			if($.inArray($(this).val(), catagory_array) != -1){
				error = true;
				$(this).css('border', '1px solid #f00');
			}else{
				catagory_array.push($(this).val());
			}
		});
                
		resource_array = [];
		
		$('select[name="resource[]"]').each(function(){
                        
			if($.inArray($(this).val(), resource_array) != -1){
				error = true;
				$(this).css('border', '1px solid #f00');
			}else{
				resource_array.push($(this).val());
			}
		});
                

                if(error == false)
                    $('form').submit();
                
		
	}

	function addCatagory(){
		html = '';
		
		html += '<tr>';
		html += '<td>Locatie:</td>';
		html += '<td>';
		html += '<select name="catagory[]">';
		html += '<option value="">-- Selecteer een catagorie --</option>';
		<?php if(is_array($this->catagorys)){ 
                    foreach($this->catagorys  as $catagory){ ?>
                        html += '<option value="<?php echo $catagory['category_id'] ?>"><?php echo $catagory['name'] ?></option>';
                    <?php } 
                } ?>
		html += '</select>';
		html += '  <img src="./themes/<?php echo THEME ?>/images/remove.png" onclick="deleteCatagory(this);" />';
		html += '</td>';
		html += '</tr>';

		$('.catagory_placeholder').before(html);
	}
	function addResource(){
		html = '';
		
		html += '<tr>';
		html += '<td>Resource:</td>';
		html += '<td>';
		html += '<select name="resource[]">';
		html += '<option value="">-- Selecteer een resource --</option>';
                <?php if(is_array($this->locations)){
                        foreach($this->resources as $resource){ ?>
                            html += '<option value="<?php echo $resource['resource_id'] ?>"><?php echo $resource['name'] ?></option>';
                    <?php } 
                } ?>
		html += '</select>';
		html += '  <img src="./themes/<?php echo THEME ?>/images/remove.png" onclick="deleteResource(this);" />';
		html += '</td>';
		html += '</tr>';

		$('.resource_placeholder').before(html);
	}
        

        
	

	function deleteCatagory(catagory){
		$(catagory).parent().parent().remove();
	}	
	function deleteResource(resource){
		$(resource).parent().parent().remove();
	}	
	
	
</script>














