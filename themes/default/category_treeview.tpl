
<div>
	<?php if(isset($this->msg)){ ?>
	<div class="msg"><?php echo $this->msg; ?></div>
	<?php } ?>
	
</div>
<?php //var_dump($this->GrandChildren); echo "------------------------------------------------------</br>";?>
<div id="tree1"></div>
<script>
    
    <?php $i = 0;$output .= "var data = ["; ?>
    <?php foreach($this->Children as $baselvl) {  ?>
        <?php $output .="{ label: '".$baselvl['category_name']."',children: ["; ?>
        <?php foreach($this->Children[0] as $firstlvl){ ?>
        <?php //var_dump($firstlvl);die ?>
            <?php if (is_array($firstlvl) ){ ?>
            <?php $output .= "{ label: '".$firstlvl['category_name'].$i."' },"; ?>
            <?php $i++; ?>
        <?php  } ?>
        
        <?php  } ?>
        <?php $output = rtrim($output,','); ?>
    <?php $output .="]},"; } ?>
    <?php $output = rtrim($output,','); ?>
        <?php echo $output; ?>
    <?php echo "];"; ?>
</script>
<?php //echo $output; ?>

<script>
$(document).ready(function(){
    
$('#tree1').tree({
        data: data
    });
    
                
});
	
	function addcategory(){
		document.location.href='index.php?route=category/add&token=<?php echo $_GET['token']; ?>';
	}
</script>
