
<div>
	<?php if(isset($this->msg)){ ?>
	<div class="msg"><?php echo $this->msg; ?></div>
	<?php } ?>
	<table class="list">
		<thead>
			<tr>
                                                   
                            
                         
                            
                            
				<td><?php echo $this->label_chart_name; ?></td>
				<td><?php echo $this->label_chart_startdatum; ?></td>

				<td colspan="3"><?php echo $this->label_chart_edit; ?></td>
<!--				<td><?php echo $this->label_chart_delete; ?></td>
				<td><?php echo $this->label_chart_pdf; ?></td>-->

			</tr>
		</thead>
		<tbody>
			<?php foreach($charts as $chart){ ?>
			<tr onclick="showLocRes(<?php echo $chart['id'] ?>);">
				<td><?php echo stripslashes($chart['catagory_name']); ?></td>
				<td><?php echo $chart['parent_catagory_id']; ?></td>

				<td><a href="index.php?route=chart/edit&id=<?php echo $chart['chart_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/edit.png"  /></a></td>
				<td><a href="index.php?route=chart/delete&id=<?php echo $chart['chart_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/remove.png"  /></a></td>
				<!-- toegevoegd Oorzaak ivm pdf functie -->
				<td><a target=_blank href="index.php?route=chart/chart_pdf&id=<?php echo $chart['chart_id'] ?>&token=<?php echo $_GET['token'] ?>"><img src="./themes/<?php echo THEME ?>/images/pdf.png"  /></a></td>		
			</tr>
                        


			<?php } ?>
                        
			<tr><td colspan="6"><input type="button" onclick="addChart();" value="Chart toevoegen" /></td></tr>
    </table>
</div>

<script>
	$(document).ready(function(){
		$('.row').hide();
	});
	
	function addChart(){
		document.location.href='index.php?route=chart/add&token=<?php echo $_GET['token']; ?>';
	}
	
	function showLocRes(chart_id){
		$('.row').hide();

	}
</script>
