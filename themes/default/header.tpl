<body>
	<div id="header">

	
	
	</div>
	<div class="clear_all">&nbsp;</div>
	<div id="container">
            <h1><?php echo $this->title; ?></h1>
        <div id="wrapper">
            <?php   if(isset($_GET['route'])){
                        $path = explode('/',$_GET['route']);
                        if($path[0]== 'login'){ ?>
                            <style>#container {width:600px;height:300px;}</style>
                        <?php }
                    }
                    if($path[0]!= 'login'){ ?>
        <div id="push_sidebar">
       <div id="tree">


            <ul class="list-unstyled">
                <?php if($this->IsAuthorized($_GET['token'],'event', 'view')){?>
    		<li class="folder"><?php echo $this->menu_categorys; ?>
			    <ul>
    				<?php if($this->IsAuthorized($_GET['token'],'event', 'add')){?>
    				<li><a href="index.php?route=category/overview&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_view_category; ?></a></li>
    				<?php } ?>
    				<?php if($this->IsAuthorized($_GET['token'],'event', 'add')){?>
    				<li><a href="index.php?route=category/add&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_add_category; ?></a></li>
    				<?php } ?>
			    </ul>
			</li>
			<?php } ?>
                <?php if($this->IsAuthorized($_GET['token'],'event', 'view')){?>
    		<li class="folder"><?php echo $this->menu_categorys; ?>
			    <ul>
    				<?php if($this->IsAuthorized($_GET['token'],'event', 'add')){?>
    				<li><a href="index.php?route=product/overview&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_view_category; ?></a></li>
    				<?php } ?>
    				<?php if($this->IsAuthorized($_GET['token'],'event', 'add')){?>
    				<li><a href="index.php?route=product/add&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_add_category; ?></a></li>
    				<?php } ?>
			    </ul>
			</li>
			<?php } ?>
                <li class="folder"><?php echo $this->menu_fancy; ?>
                    <ul>
                        <?php if($this->IsAuthorized($_GET['token'],'fancy', 'html5')){?>
                        <li class="file"><a href="index.php?route=fancy/vectorjs&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_fancy_vectorjs; ?></a></li>
                        <?php } ?>
                        <?php if($this->IsAuthorized($_GET['token'],'fancy', 'html5')){?>
                        <li class="file"><a href="index.php?route=fancy/html5&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_fancy_html5; ?></a></li>
                        <?php } ?>
                    </ul>
                <li class="folder"><?php echo $this->menu_usermanagement; ?>
                        <ul>
                        <?php if($this->IsAuthorized($_GET['token'],'user', 'view')){?>
                        <li class="file"><a href="index.php?route=user/overview&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_manage_users; ?></a></li>
                        <?php } ?>
                        <?php if($this->IsAuthorized($_GET['token'],'user', 'edit')){?>
                        <li class="file"><a href="index.php?route=user/group&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_manage_groups; ?></a></li>
                        <?php } ?>
                        <?php if($this->IsAuthorized($_GET['token'],'user', 'add')){?>
                        <li class="file"><a href="index.php?route=user/add&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_add_user; ?></a></li>
                        <?php } ?>
                        <?php if($this->IsAuthorized($_GET['token'],'login', 'logout')){?>
                        <li class="file"><a href="index.php?route=login/logout&token=<?php echo $_GET['token']; ?>"><?php echo $this->menu_logout; ?></a></li>
                        <?php } ?>
                        </ul>
                <!--<li id="videoParent1" class="folder">Video
                        <ul>
                            <li id="videoNode1" data-icon="false">
                                <span>
                                    <video target="_parent" id="video1" src="http://simpl.info/video/video/chrome.mp4" controls="controls">
                                      Your browser does not support the <code>video</code> element.
                                    </video>
                                </span>
                        </ul>-->
                <li class="folder"><?php echo $this->menu_catalog; ?>
                     <ul> 
                <?php $root_id = 1;?>       
                <?php foreach($this->children[$root_id] as $child){ ?>
                        

                        <li class="folder"><span><?php echo $child["category_name"]; ?> || <?php echo $child["category_text"]; ?>|| <?php echo $child["category_id"]; ?></span>
                        
                        
                        <?php if(is_array($this->children[$child['category_id']])){ ?>
                        
                         <ul>
                            <?php foreach($this->children[$child['category_id']] as $grandchild){ ?>
                                    

                                <li class="folder"><span><?php echo $grandchild["category_name"]; ?> || <?php echo $grandchild["category_text"]; ?></span>
                                
                                    <ul><li href="www.google.nl"  ><span><?php echo $grandchild["category_name"]; ?> || <?php echo $grandchild["category_text"]; ?></span></ul>
                                    
                                    
                             <?php } ?>   
                               
                        <?php } ?>
                        </ul>
                        <?php } ?>

                    </ul>                 
                 <?php } //die();?>   
            </ul>
        </div>
    
</div>


<span class="nav_trigger">
  <i class="fa fa-navicon"></i>
</span>
                 
<script>
    
    
    

$( document ).ready(function() {
    
});
$(".nav_trigger").click(function() {
    $(this).effect("bounce", { times:3 }, 300);
    $( "#push_sidebar" ).fadeTo( "slow" , 0.9);
    console.log( "sidebar out fade ready!" );
    $("body").toggleClass("show_sidebar");
    $(".nav_trigger .fa").toggleClass("fa-navicon fa-times");
});
</script>                    
                    


