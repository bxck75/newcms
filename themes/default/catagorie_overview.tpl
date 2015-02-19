
<div>
	<?php if(isset($this->msg)){ ?>
	<div class="msg"><?php echo $this->msg; ?></div>
	<?php } ?>
	<table class="list">
		<thead>
			<tr>
                                                   
                            
                         
                            
                            
				<td><?php echo $this->label_catagorie_name; ?></td>
				<td><?php echo $this->label_catagorie_startdatum; ?></td>

				<td colspan="3"><?php echo $this->label_catagorie_edit; ?></td>
<!--				<td><?php echo $this->label_catagorie_delete; ?></td>
				<td><?php echo $this->label_catagorie_pdf; ?></td>-->

			</tr>
		</thead>
		<tbody>
			<?php foreach($catagories as $catagorie){ ?>
			<tr onclick="showLocRes(<?php echo $catagorie['id'] ?>);">
				<td><?php echo stripslashes($catagorie['catagory_name']); ?></td>
				<td><?php echo $catagorie['parent_catagory_id']; ?></td>

				<td><a href="index.php?route=catagorie/edit&id=<?php echo $catagorie['catagorie_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/edit.png"  /></a></td>
				<td><a href="index.php?route=catagorie/delete&id=<?php echo $catagorie['catagorie_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/remove.png"  /></a></td>
				<!-- toegevoegd Oorzaak ivm pdf functie -->
				<td><a target=_blank href="index.php?route=catagorie/catagorie_pdf&id=<?php echo $catagorie['catagorie_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/pdf.png"  /></a></td>		
			</tr>
                        


			<?php } ?>
                        
			<tr><td colspan="6"><input type="button" onclick="addCatagorie();" value="Catagorie toevoegen" /></td></tr>
    </table>
</div>

<script>
	$(document).ready(function(){
		$('.row').hide();
	});
	
	function addCatagorie(){
		document.location.href='index.php?route=catagorie/add&token=<?php echo $_GET['token']; ?>';
	}
	
	function showLocRes(catagorie_id){
		$('.row').hide();
		$('.location_'+catagorie_id).show();
		$('.resource_'+catagorie_id).show();
		$('.performance_'+catagorie_id).show();
	}
</script>
