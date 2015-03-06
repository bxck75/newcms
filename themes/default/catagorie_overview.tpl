
<div>
	<?php if(isset($this->msg)){ ?>
	<div class="msg"><?php echo $this->msg; ?></div>
	<?php } ?>
	<table class="list">
		<thead>
			<tr>
                                <td align="center"><?php echo $this->label_catagorie_id; ?></td>
				<td><?php echo $this->label_catagorie_name; ?></td>
				<td align="center" ><?php echo $this->label_catagorie_parent_id; ?></td>
                                <td align="center" colspan="3"><?php echo $this->label_catagorie_edit; ?></td>

			</tr>
		</thead>
		<tbody>
                        <?php if(is_array($this->catagories)){ ?>
                            <?php foreach($this->catagories as $catagorie){ ?>
                                <tr>
                                    <td align="center" ><?php echo $catagorie['category_id']; ?></td>
                                    <td align="left" ><?php echo stripslashes($catagorie['category_name']); ?></td>
                                    <td align="center"><?php echo $catagorie['parent_category_id']; ?></td>

                                    <td class="edit_option_button" align="center"><a href="index.php?route=catagorie/edit&id=<?php echo $catagorie['category_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/edit.png"  /></a></td>
                                    <td class="edit_option_button" align="center"><a href="index.php?route=catagorie/delete&id=<?php echo $catagorie['category_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/remove.png"  /></a></td>
                                    <td class="edit_option_button" align="center"><a target=_blank href="index.php?route=catagorie/catagorie_pdf&id=<?php echo $catagorie['category_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/pdf.png"  /></a></td>		
                                </tr>
                            <?php } ?>
                        <?php } ?>
                        <tr><td colspan="6"><input type="button" onclick="addCatagorie();" value="Catagorie toevoegen" /></td></tr>
    </table>
</div>

<script>

	
	function addCatagorie(){
		document.location.href='index.php?route=catagorie/add&token=<?php echo $_GET['token']; ?>';
	}
</script>
