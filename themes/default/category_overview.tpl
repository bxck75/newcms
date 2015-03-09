
<div>
	<?php if(isset($this->msg)){ ?>
	<div class="msg"><?php echo $this->msg; ?></div>
	<?php } ?>
	<table class="list">
		<thead>
			<tr>
                                <td align="center"><?php echo $this->label_category_id; ?></td>
				<td><?php echo $this->label_category_name; ?></td>
				<td align="center" ><?php echo $this->label_category_discription; ?></td>
                                <td align="center" colspan="3"><?php echo $this->label_category_edit; ?></td>

			</tr>
		</thead>
		<tbody>
                        <?php if(is_array($this->categorys)){ ?>
                            <?php foreach($this->categorys as $category){ ?>
                                <tr>
                                    <td align="center" ><?php echo $category['category_id']; ?></td>
                                    <td align="left" ><?php echo stripslashes($category['category_name']); ?></td>
                                    <td align="center"><?php echo $category['category_text']; ?></td>

                                    <td class="edit_option_button" align="center"><a href="index.php?route=category/edit&id=<?php echo $category['category_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/edit.png"  /></a></td>
                                    <td class="edit_option_button" align="center"><a href="index.php?route=category/delete&id=<?php echo $category['category_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/remove.png"  /></a></td>
                                    <td class="edit_option_button" align="center"><a target=_blank href="index.php?route=category/category_pdf&id=<?php echo $category['category_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/pdf.png"  /></a></td>		
                                </tr>
                            <?php } ?>
                        <?php } ?>
                        <tr><td colspan="6"><input type="button" onclick="addcategory();" value="category toevoegen" /></td></tr>
    </table>
</div>

<script>

	
	function addcategory(){
		document.location.href='index.php?route=category/add&token=<?php echo $_GET['token']; ?>';
	}
</script>
