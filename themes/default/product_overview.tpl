
<div>
	<?php if(isset($this->msg)){ ?>
	<div class="msg"><?php echo $this->msg; ?></div>
	<?php } ?>
	<table class="list">
		<thead>
			<tr>
                                <td align="center"><?php echo $this->label_product_id; ?></td>
				<td><?php echo $this->label_product_name; ?></td>
				<td align="center" ><?php echo $this->label_product_category; ?></td>
                                <td align="center" colspan="3"><?php echo $this->label_product_edit; ?></td>

			</tr>
		</thead>
		<tbody>
                        <?php if(is_array($this->products)){ ?>
                            <?php foreach($this->products as $product){ ?>
                                <tr>
                                    <td align="center" ><?php echo $product['product_id']; ?></td>
                                    <td align="left" ><?php echo stripslashes($product['name']); ?></td>
                                    <td align="center"><?php echo $product['category_id']; ?></td>

                                    <td class="edit_option_button" align="center"><a href="index.php?route=product/edit&id=<?php echo $product['product_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/edit.png"  /></a></td>
                                    <td class="edit_option_button" align="center"><a href="index.php?route=product/delete&id=<?php echo $product['product_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/remove.png"  /></a></td>
                                    <td class="edit_option_button" align="center"><a target=_blank href="index.php?route=product/product_pdf&id=<?php echo $product['product_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/pdf.png"  /></a></td>		
                                </tr>
                            <?php } ?>
                        <?php } ?>
                        <tr><td colspan="6"><input type="button" onclick="addproduct();" value="product toevoegen" /></td></tr>
    </table>
</div>

<script>

	
	function addproduct(){
		document.location.href='index.php?route=product/add&token=<?php echo $_GET['token']; ?>';
	}
</script>
